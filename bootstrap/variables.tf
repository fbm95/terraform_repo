variable "bucket_location" {
  description = "Default region to create resources where applicable."
  type        = string
  default     = "EU"
}

variable "dev_project_id" {
  description = "The ID of the dev project"
  type = string
}

variable "prod_project_id" {
  description = "The ID of the prod project"
  type = string
}