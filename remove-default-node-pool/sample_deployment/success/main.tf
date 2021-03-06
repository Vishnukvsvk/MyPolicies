provider "google" {
  //credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project = "terraformpractical"
  //region      = "us-west1"

}

resource "google_service_account" "default" {
  account_id   = "kubernetes-vishnu-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "mycluster1" {
  name                     = "my-gke-cluster"
  location                 = "us-central1"
  remove_default_node_pool = true
  initial_node_count       = 1
  //subnetwork = "value"
}

resource "google_container_node_pool" "np1" {
  name       = "node-pool-1"
  location   = "us-central1"
  cluster    = google_container_cluster.mycluster1.name
  node_count = 1 //per zone



  node_config {
    preemptible  = true
    machine_type = "e2-micro"


    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    /*oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]*/
  }
}
