resource "google_cloud_run_service" "default" {
  name                       = "carved-rock-cloudrun-svc-${random_pet.suffix.id}"
  location                   = "us-east1"
  autogenerate_revision_name = true

  depends_on = [
    google_project_service.gcp_services
  ]

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/client-name" = "terraform"
      }
    }
  }
}

resource "random_pet" "suffix" {
  length = 2
}

resource "google_project_service" "gcp_services" {
  project = "terraform-prod"
  service = "run.googleapis.com"
}
