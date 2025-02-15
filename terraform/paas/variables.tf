# These settings are for the sandbox and should mainly be overriden by TF_VARS
# or set with environment variables TF_VAR_xxxx

variable "api_url" {
  default = "https://api.london.cloud.service.gov.uk"
}

variable "AZURE_CREDENTIALS" { default = "{}" }
variable "azure_key_vault" {}
variable "azure_resource_group" {}

variable "application_stopped" {
  default = false
}

variable "timeout" {
  default = 180
}

variable "azure_vault_secret" {
  default = "CONTENT-KEYS"
}

variable "paas_monitoring_space" {}

variable "paas_space" {
  default = "sandbox"
}

variable "paas_app_database_name" {
  type    = string
  default = null
}
variable "paas_app_redis_name" {
  type    = string
  default = null
}

variable "paas_app_redis_plan" {
  default = "tiny-ha-6_x"
}

variable "database_plan" {
  default = "tiny-unencrypted-13"
}

variable "paas_monitoring_app" {}

variable "paas_org_name" {
  default = "dfe"
}

variable "instances" {
  default = 1
}

variable "logging" {
  default = 1
}

variable "basic_auth" {
  default = 1
}

variable "paas_asset_hostnames" {
  default = []
}

variable "paas_internet_hostnames" {
  default = []
}

variable "paas_app_route_name" {}

variable "paas_logging_name" {
  default = "logit-ssl-drain"
}

variable "paas_linked_services" {
  default = []
}

variable "paas_app_application_name" {
  default = "dfe-teacher-services-app"
}

variable "paas_app_docker_image" {
  default = "dfedigital/get-into-teaching-frontend:latest"
}

variable "strategy" {
  default = "blue-green"
}

variable "alerts" {
  type = map(any)
}

variable "statuscake_enable_basic_auth" {
  type    = bool
  default = false
}
