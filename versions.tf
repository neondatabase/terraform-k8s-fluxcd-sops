terraform {
  required_version = ">= 1.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.21"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 1.3.0"
    }
  }
}
