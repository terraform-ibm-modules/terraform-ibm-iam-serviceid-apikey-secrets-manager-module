variable "prefix" {
  description = "Prefix for name of all resource created by this example"
  type        = string
  default     = "test-iam-serviceid-apikey"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "APIkey that's associated with the account to use, set via environment variable TF_VAR_ibmcloud_api_key or .tfvars file."
  sensitive   = true
}

variable "sm_service_plan" {
  type        = string
  description = "Secrets-Manager Trial plan"
  default     = "trial"
}

variable "sm_iam_secret_name" {
  type        = string
  description = "Name of SM IAM secret (dynamic ServiceID API Key) to be created"
  default     = "sm-iam-secret-puller" #tfsec:ignore:general-secrets-no-plaintext-exposure
}

variable "region" {
  type        = string
  description = "Region where resources will be created"
  default     = "au-syd"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}

variable "existing_sm_instance_guid" {
  type        = string
  description = "Existing Secrets Manager GUID. If not provided an new instance will be provisioned"
  default     = null
}

variable "existing_sm_instance_region" {
  type        = string
  description = "Existing Secrets Manager Region. Required if value is passed into var.existing_sm_instance_name"
  default     = null
}
