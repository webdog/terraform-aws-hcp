locals {
  ingress_consul_rules = [
    {
      description = "HCP Consul Server RPC"
      port        = 8300
      protocol    = "tcp"
    },
    {
      description = "Consul LAN Serf (tcp)"
      port        = 8301
      protocol    = "tcp"
    },
    {
      description = "Consul LAN Serf (udp)"
      port        = 8301
      protocol    = "udp"
    },
    {
      description = "Consul HTTP"
      port        = 80
      protocol    = "udp"
    },
    {
      description = "Consul HTTPS"
      port        = 443
      protocol    = "udp"
    }
  ]

  egress_consul_rules = [
    {
      description = "All egress"
      port        = "0"
      protocol    = "-1"
  }]

  hcp_consul_security_groups = flatten([
    for _, sg in var.hcp_consul_security_group_ids : [
      for _, rule in local.ingress_consul_rules : {
        security_group_id = sg
        description       = rule.description
        port              = rule.port
        protocol          = rule.protocol
      }
    ]
  ])

  hcp_consul_security_groups_egress = flatten([
    for _, sg in var.hcp_consul_security_group_ids : [
      for _, rule in local.egress_consul_rules : {
        security_group_id = sg
        description       = rule.description
        port              = rule.port
        protocol          = rule.protocol
      }
    ]
  ])


}



resource "aws_security_group_rule" "hcp_consul" {
  count             = length(local.hcp_consul_security_groups)
  description       = local.hcp_consul_security_groups[count.index].description
  protocol          = local.hcp_consul_security_groups[count.index].protocol
  security_group_id = local.hcp_consul_security_groups[count.index].security_group_id
  cidr_blocks       = [var.hvn_cidr_block, var.vpc_cidr_block]
  from_port         = local.hcp_consul_security_groups[count.index].port
  to_port           = local.hcp_consul_security_groups[count.index].port
  type              = "ingress"
}



resource "aws_security_group_rule" "hcp_consul_egress" {
  count             = length(local.hcp_consul_security_groups_egress)
  description       = local.hcp_consul_security_groups[count.index].description
  protocol          = local.hcp_consul_security_groups[count.index].protocol
  security_group_id = local.hcp_consul_security_groups[count.index].security_group_id
  cidr_blocks       = [var.hvn_cidr_block, var.vpc_cidr_block]
  from_port         = local.hcp_consul_security_groups[count.index].port
  to_port           = local.hcp_consul_security_groups[count.index].port
  type              = "egress"
}

resource "hcp_consul_cluster" "consul" {
  count              = var.hcp_consul_name != "" ? 1 : 0
  hvn_id             = hcp_hvn.hvn.hvn_id
  datacenter         = var.hcp_consul_datacenter
  cluster_id         = var.hcp_consul_name
  tier               = var.hcp_consul_tier
  public_endpoint    = var.hcp_consul_public_endpoint
  min_consul_version = var.hcp_consul_version
  connect_enabled    = true

}

resource "hcp_consul_cluster_root_token" "consul" {
  cluster_id = hcp_consul_cluster.consul.0.cluster_id
}

