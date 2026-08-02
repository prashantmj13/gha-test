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
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id

  # Handy for later: private Google API access without a NAT/IGW.
  private_ip_google_access = true
}
