resource "google_compute_backend_service" "cloud_function_backend" {
  name = "cloud-function-backend"
  backend {
    group = google_compute_region_backend_service.serverless_neg.id
  }

  health_checks = [google_compute_health_check.http_health_check.id]
}

resource "google_compute_health_check" "http_health_check" {
  name               = "http-health-check"
  http_health_check {
    port = 8080
    request_path = "/"
  }
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2
}

resource "google_compute_url_map" "default" {
  name = "url-map"

  default_service = google_compute_backend_service.cloud_function_backend.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "http-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}
