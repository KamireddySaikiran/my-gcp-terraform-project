provider "google" {
  project = var.project_id
  region  = "us-west1"
  credentials = file(var.credentials_file)
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"
  initial_node_count = 2
}
