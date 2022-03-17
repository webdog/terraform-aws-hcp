resource "hcp_vault_cluster" "vault" {
  count           = var.hcp_vault_name != "" ? 1 : 0
  cluster_id      = var.hcp_vault_name
  hvn_id          = hcp_hvn.hvn.hvn_id
  public_endpoint = var.hcp_vault_public_endpoint
}

resource "hcp_vault_cluster_admin_token" "token" {
  cluster_id = hcp_vault_cluster.vault.0.cluster_id
}
