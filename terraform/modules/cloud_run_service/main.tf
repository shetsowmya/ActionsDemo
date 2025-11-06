resource "google_cloud_run_service" "workato_agent" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image_url
        env {
          name  = "WORKATO_ENV"
          value = var.environment
        }
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

output "service_url" {
  value = google_cloud_run_service.workato_agent.status[0].url
}
