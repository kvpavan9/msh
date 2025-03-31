resource "google_project_iam_binding" "cloud_function_binding" {
  project = "<your_project_id>"
  role    = "roles/cloudfunctions.invoker"
  members = [
    "allUsers"  # Use "allUsers" for public access, otherwise restrict to specific roles
  ]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
