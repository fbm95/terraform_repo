resource "google_cloudbuild_trigger" "dev_app_build_deploy_trigger" {
  project        = var.project_id
  name           = "dev-app-build-deploy"
  description    = "Build and deploy the app"
  filename       = "cloudbuild.yaml"

  github {
    owner   = "fbm95"
    name    = "app_repo"
    push {
      branch = "(dev|prod)"
    }
  }

  substitutions = {
    _REGION = var.region
  }
}
