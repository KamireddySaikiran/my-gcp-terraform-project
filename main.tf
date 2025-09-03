provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

resource "google_container_cluster" "primary" {
  name     = "demo-gke"
  location = var.region
  initial_node_count = 1
}
