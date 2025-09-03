provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}
resource "google_container_node_pool" "primary_nodes" {
  name       = "minimal-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"    # Smallest instance
    disk_type    = "pd-standard" # ← CRITICAL: Use STANDARD disks, not SSD
    disk_size_gb = 20            # Minimal disk size
    
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
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
