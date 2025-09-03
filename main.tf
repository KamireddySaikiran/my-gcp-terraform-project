provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}
# This should be in your main.tf
resource "google_container_cluster" "primary" {
  name     = "minimal-gke-cluster"
  location = "us-west1"
  initial_node_count = 1
  remove_default_node_pool = true
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "minimal-pool"
  location   = "us-west1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
    disk_type    = "pd-standard"
    disk_size_gb = 20
    
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
