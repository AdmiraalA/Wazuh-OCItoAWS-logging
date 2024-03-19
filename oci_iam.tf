resource "oci_identity_policy" "allow_function_access_secrets" {
  name          = "allow-function-access-secrets"
  description   = "Policy to allow functions to manage secret-family in the compartment"
  compartment_id = var.compartment_id

  statements {
    effect     = "ALLOW"
    description = "Allow functions to manage secret-family in the compartment"

    # Define the dynamic group
    # Replace "<your_dynamic_group_id>" with the actual dynamic group OCID
    # Replace "<compartment_id>" with the compartment OCID
    # Replace "<vault_id>" with the vault OCID if you want to narrow down to a single vault
    subject {
      type          = "DynamicGroup"
      dynamic_group = "<your_dynamic_group_id>"
    }

    # Define the permissions for managing secret-family
    # Replace "<compartment_id>" with the compartment OCID
    # Replace "<vault_id>" with the vault OCID if you want to narrow down to a single vault
    # If you don't want to restrict to a single vault, remove "resource.secret-family" line
    resources = ["secret-family", "resource.secret-family in compartment <compartment_id>", "resource.secret-family in vault <vault_id>"]
  }
}
