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
