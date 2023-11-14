##############################################################################
# ServiceID API Key
#
# Creates a dynamic ServiceID API Key stored and managed in a Secrets-Manager secret
##############################################################################

# Validation
# Approach based on https://stackoverflow.com/a/66682419
locals {
  # validate auto rotation
  auto_rotation_validate_condition = var.sm_iam_secret_auto_rotation == true && var.sm_iam_secret_auto_rotation_unit != "month" && var.sm_iam_secret_auto_rotation_unit != "day" || var.sm_iam_secret_auto_rotation == true && var.sm_iam_secret_auto_rotation_interval == 0
  auto_rotation_validate_msg       = "Value for `sm_iam_secret_auto_rotation_unit' must be either `day` or `month` and value for `sm_iam_secret_auto_rotation_interval` must be higher than 0"
  # tflint-ignore: terraform_unused_declarations
  auto_rotation_validate_check = regex("^${local.auto_rotation_validate_msg}$", (!local.auto_rotation_validate_condition ? local.auto_rotation_validate_msg : ""))
  auto_rotation_enabled        = var.sm_iam_secret_auto_rotation == true ? [1] : []
}

resource "ibm_sm_iam_credentials_secret" "sm_iam_credentials_secret" {
  instance_id     = var.secrets_manager_guid
  region          = var.region
  name            = var.sm_iam_secret_name
  description     = var.sm_iam_secret_description
  secret_group_id = var.secret_group_id
  service_id      = var.serviceid_id
  ttl             = var.sm_iam_secret_ttl
  reuse_api_key   = var.sm_iam_secret_api_key_persistence
  endpoint_type   = var.service_endpoints

  ## This for_each block is NOT a loop to attach to multiple rotation blocks.
  ## This block is only used to conditionally add rotation block depending on var.sm_iam_secret_auto_rotation
  dynamic "rotation" {
    for_each = local.auto_rotation_enabled
    content {
      auto_rotate = true
      interval    = var.sm_iam_secret_auto_rotation_interval
      unit        = var.sm_iam_secret_auto_rotation_unit
    }
  }
}
