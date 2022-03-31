resource "hcp_vault_cluster" "vault" {
  count           = var.hcp_vault_name != "" ? 1 : 0
  cluster_id      = var.hcp_vault_name
  hvn_id          = hcp_hvn.hvn.hvn_id
  public_endpoint = var.hcp_vault_public_endpoint
}

resource "hcp_vault_cluster_admin_token" "token" {
  # Only create this resource if terraform "can" access the cluster id in the hcp_vault_cluster.vault collection.
  # Count is equal to the length of the collection, but only retur the first token
  count = can(hcp_vault_cluster.vault.0.cluster_id) ? length(hcp_vault_cluster.vault) : 0
  #count = length(hcp_vault_cluster.vault) == 0 ? 0 : 0
  #cluster_id = hcp_vault_cluster.vault.0.cluster_id
  cluster_id = hcp_vault_cluster.vault.0.cluster_id
}
