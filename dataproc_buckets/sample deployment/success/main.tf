provider "google" {
  //credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project = "terraformpractical"
  //region      = "us-west1"
}

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_dataproc_cluster" "mycluster" {
  name                          = "mycluster"
  region                        = "us-central1"
  graceful_decommission_timeout = "120s"
  labels = {
    foo = "bar"
  }

  cluster_config {
    staging_bucket = "kvs-staging-bucket"
    temp_bucket    = "kvs-temp-bucket"

    master_config {
      num_instances = 1
      machine_type  = "e2-medium"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 1
      machine_type     = "e2-medium"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      tags = ["foo", "bar"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      service_account = google_service_account.default.email
      service_account_scopes = [
        "cloud-platform"
      ]
    }
  }
}

#Staging bucket: Used to stage cluster job dependencies, job driver output, and cluster config files. Also receives output from the Cloud SDK gcloud dataproc clusters diagnose command.
#Temp bucket: Used to store ephemeral cluster and jobs data, such as Spark and MapReduce history files.

#It is not guaranteed that an auto generated bucket will be solely dedicated to your cluster; it may be shared with other clusters in the same region/zone also choosing to use the auto generation option.
