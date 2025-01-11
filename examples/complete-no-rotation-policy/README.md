# Complete with no rotation example

End to end example with the complete Secrets-Manager objects lifecycle including the dynamic IAM secret (without an explicit rotation policy).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.70.0, <2.0.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamic_serviceid_apikey1"></a> [dynamic\_serviceid\_apikey1](#module\_dynamic\_serviceid\_apikey1) | ../.. | n/a |
| <a name="module_iam_secrets_engine"></a> [iam\_secrets\_engine](#module\_iam\_secrets\_engine) | terraform-ibm-modules/secrets-manager-iam-engine/ibm | 1.2.6 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.6 |
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | terraform-ibm-modules/secrets-manager/ibm | 1.20.0 |
| <a name="module_secrets_manager_group_acct"></a> [secrets\_manager\_group\_acct](#module\_secrets\_manager\_group\_acct) | terraform-ibm-modules/secrets-manager-secret-group/ibm | 1.2.2 |
| <a name="module_secrets_manager_group_service"></a> [secrets\_manager\_group\_service](#module\_secrets\_manager\_group\_service) | terraform-ibm-modules/secrets-manager-secret-group/ibm | 1.2.2 |

### Resources

| Name | Type |
|------|------|
| [ibm_iam_service_id.secret_puller](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_service_id) | resource |
| [ibm_iam_service_policy.secret_puller_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_service_policy) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_sm_instance_guid"></a> [existing\_sm\_instance\_guid](#input\_existing\_sm\_instance\_guid) | Existing Secrets Manager GUID. If not provided an new instance will be provisioned | `string` | `null` | no |
| <a name="input_existing_sm_instance_region"></a> [existing\_sm\_instance\_region](#input\_existing\_sm\_instance\_region) | Existing Secrets Manager Region. Required if value is passed into var.existing\_sm\_instance\_name | `string` | `null` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | APIkey that's associated with the account to use, set via environment variable TF\_VAR\_ibmcloud\_api\_key or .tfvars file. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for name of all resource created by this example | `string` | `"test-iam-serviceid-apikey"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where resources will be created | `string` | `"au-syd"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | An existing resource group name to use for this example, if unset a new resource group will be created | `string` | `null` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Optional list of tags to be added to created resources | `list(string)` | `[]` | no |
| <a name="input_sm_iam_secret_name"></a> [sm\_iam\_secret\_name](#input\_sm\_iam\_secret\_name) | Name of SM IAM secret (dynamic ServiceID API Key) to be created | `string` | `"sm-iam-secret-puller"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_secrets_manager_guid"></a> [secrets\_manager\_guid](#output\_secrets\_manager\_guid) | GUID of Secrets-Manager instance in which IAM engine was configured |
| <a name="output_service_secret_group_id"></a> [service\_secret\_group\_id](#output\_service\_secret\_group\_id) | Secret-group ID containing IAM secret |
| <a name="output_sm_iam_secret_puller_apikey_secret_id"></a> [sm\_iam\_secret\_puller\_apikey\_secret\_id](#output\_sm\_iam\_secret\_puller\_apikey\_secret\_id) | Secrets-Manager IAM secret ID containing ServiceID API key |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
