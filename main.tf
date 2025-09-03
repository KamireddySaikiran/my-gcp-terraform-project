provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}
resource "google_container_cluster" "primary" {
  name     = "minimal-gke-cluster"
  location = var.region
  initial_node_count = 1
  remove_default_node_pool = true
  
  # Add this to specify node configuration at cluster level
  node_config {
    disk_type = "pd-standard"  # Use standard disks, not SSD
    disk_size_gb = 20          # Minimal disk size
  }
}
