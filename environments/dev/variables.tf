variable "region" {
  description = "Region name"
  default     = "europe-west1"
}

variable "project_id" {
  description = "The ID of the project"
}

variable "env_name" {
  description = "Environment name"
}

variable "dev_artifacts_bucket" {
  description = "Cloudbuild artifacts bucket name for dev environment"
}

variable "subnetworks" {
  type = map(object({
    subnet_region     = string
    subnet_cidr_range = string
  }))
  description = "Map containing subnet definition"
}