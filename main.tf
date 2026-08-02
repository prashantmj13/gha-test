terraform {
  backend "gcs" {
    bucket = "tf-backend-prashant"
    prefix = "terraform/qa/vpc"
  }
}

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # No backend block here on purpose.
  # backend.tf is generated per-run by copying backend.qa or backend.prod,
  # so state is isolated per environment without needing workspaces.
}

provider "google" {
  project = "cloud-ids-489610"
  region  = "asia-southeast1"
}

resource "google_compute_network" "vpc" {
  name                    = "qa-gha-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "qa-gha-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = "asia-southeast1"
  network       = google_compute_network.vpc.id

  # Handy for later: private Google API access without a NAT/IGW.
  private_ip_google_access = true
}
