variable "project_id" {
  description = "GCP project ID where resources will be provisioned"
  type        = string
  # No default on purpose — fill this in via terraform.tfvars or -var
}

variable "region" {
  description = "GCP region for regional resources (e.g. the subnet)"
  type        = string
  # e.g. "us-central1"
}

variable "vpc_name" {
  description = "Name of the VPC network to create"
  type        = string
  # e.g. "sample-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet to create inside the VPC"
  type        = string
  # e.g. "sample-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  # e.g. "10.10.0.0/24"
}
