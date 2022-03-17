output "hvn_id" {
  value       = hcp_hvn.hvn.id
  description = "ID of HashiCorp Virtual Network."
}

output "hcp_consul_ca_file" {
  value = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.consul_ca_file : ""
  description = "The cluster CA file encoded as a base64 string"
  sensitive = true
}

output "hcp_consul_configuration_file" {
  value = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.consul_config_file : ""
  sensitive = true
  description = "Configuration file for HCP Consul, encoded as a base64 string"
}

output "hcp_consul_root_token" {
  value = {
    secret_id = var.hcp_consul_name != "" ? hcp_consul_cluster_root_token.consul.secret_id : ""
    accessor_id = var.hcp_consul_name != "" ? hcp_consul_cluster_root_token.consul.accessor_id : ""
  }
  sensitive = true
  description = "Token used to bootstrap the cluster's ACL system."
}

output "hcp_consul_id" {
  value       = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.cluster_id : ""
  description = "ID of HCP Consul."
}

output "hcp_consul_private_endpoint" {
  value       = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.consul_private_endpoint_url : ""
  description = "Private endpoint of HCP Consul."
}

output "hcp_consul_public_endpoint" {
  value       = var.hcp_consul_name != "" && var.hcp_consul_public_endpoint ? hcp_consul_cluster.consul.0.consul_public_endpoint_url : ""
  description = "Public endpoint of HCP Consul."
}

output "hcp_vault_id" {
  value       = var.hcp_vault_name != "" ? hcp_vault_cluster.vault.0.cluster_id : ""
  description = "ID of HCP Vault."
}

output "hcp_vault_private_endpoint" {
  value       = var.hcp_vault_name != "" ? hcp_vault_cluster.vault.0.vault_private_endpoint_url : ""
  description = "Private endpoint of HCP Vault."
}

output "hcp_vault_public_endpoint" {
  value       = var.hcp_vault_name != "" && var.hcp_vault_public_endpoint ? hcp_vault_cluster.vault.0.vault_public_endpoint_url : ""
  description = "Public endpoint of HCP Vault."
}

output "hcp_vault_token" {
  value = var.hcp_vault_name != "" ? hcp_vault_cluster_admin_token.token.token: ""
  sensitive = true
  description = "The Vault cluster admin token resource generates an admin-level token for the HCP Vault cluster."
}

