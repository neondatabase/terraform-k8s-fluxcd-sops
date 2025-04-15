terraform {
  required_version = ">= 1.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.5.1"
    }
  }
}
