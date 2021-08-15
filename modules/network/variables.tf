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

variable "subnet_cidr_range" {
  description = "CIDR range for subnet"
}

variable "subnetworks" {
  type = list(object({
    subnet_region     = string
    subnet_cidr_range = string
  }))
  description = "Map containing subnet definition"
}
