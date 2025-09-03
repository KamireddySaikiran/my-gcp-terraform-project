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
resource "google_container_node_pool" "primary_nodes" {
  name       = "test-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  # Add explicit dependency
  depends_on = [google_container_cluster.primary]

  node_config {
    preemptible  = true
    machine_type = "e2-small"
    # ... rest of config
  }
}
