provider "google" {
  //credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project = "terraformpractical"
  //region      = "us-west1"

}

resource "google_compute_network" "myvpc" {
  name                    = "myvpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.myvpc.name
}

resource "google_filestore_instance" "instance" {
  name = "test-instance"
  zone = "us-central1-b"
  tier = "STANDARD"

  file_shares {
    capacity_gb = 10241
    name        = "share1"
  }

  networks {
    network = google_compute_network.myvpc.name
    modes   = ["MODE_IPV4"]
  }
}


//tier - (Required) The service tier of the instance. 
//Possible values are TIER_UNSPECIFIED, STANDARD, PREMIUM, BASIC_HDD, BASIC_SSD, and HIGH_SCALE_SSD.
