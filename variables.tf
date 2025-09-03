variable "project_id" {}
variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-west1"  # or "europe-west1", "asia-southeast1"
}
variable "credentials_file" {}
