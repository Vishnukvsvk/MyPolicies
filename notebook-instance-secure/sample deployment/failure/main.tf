provider "google" {
  //credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project     = "terraformpractical"
  //region      = "us-west1"

}


resource "google_notebooks_instance" "instance" {
  name = "notebooks-instance"
  location = "us-central1-a"
  machine_type = "n1-standard-1" // can't be e2 because of accelerator

  accelerator_config {
    type         = "NVIDIA_TESLA_T4"
    core_count   = 1
  }

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "tf-latest-cpu"
  }

  //instance_owners = ["admin@hashicorptest.com"]
  //service_account = "emailAddress:my@service-account.com"

  install_gpu_driver = true
  boot_disk_type = "PD_SSD"
  boot_disk_size_gb = 110

  no_public_ip = true
  no_proxy_access = true

  network = data.google_compute_network.my_network.id
  subnet = data.google_compute_subnetwork.my_subnetwork.id

  labels = {
    k = "val"
  }

  metadata = {
    terraform = "true"
  }
}

data "google_compute_network" "my_network" {
  name = "default"
}

data "google_compute_subnetwork" "my_subnetwork" {
  name   = "default"
  region = "us-central1"
}