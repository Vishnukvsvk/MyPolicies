provider "google-beta" {
  //credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project = "terraformpractical"
  //region      = "us-west1"

}

resource "google_data_fusion_instance" "extended_instance" {
  provider    = google-beta
  name        = "my-instance"
  description = "My Data Fusion instance"
  region      = "us-central1"
  type        = "BASIC"
  labels = {
    example_key = "example_value"
  }
  private_instance = true
  network_config {
    network       = "default"
    ip_allocation = "10.89.48.0/22"
  }
  version                  = "6.3.0"
  dataproc_service_account = data.google_app_engine_default_service_account.default.email
}

data "google_app_engine_default_service_account" "default" {
  provider = google-beta
}
