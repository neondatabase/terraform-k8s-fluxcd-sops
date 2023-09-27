terraform {
  required_version = ">= 1.5"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.21"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 1.1.1"
    }
  }
}
