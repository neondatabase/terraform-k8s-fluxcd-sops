################################################################################
# Kubernetes Namespace, Secret and ConfigMap creation
################################################################################
resource "kubernetes_namespace" "flux_system_ns" {
  metadata {
    name        = var.namespace
    annotations = var.annotations
  }

  lifecycle {
    ignore_changes = [metadata[0].labels]
  }
}

resource "kubernetes_secret" "flux_system_secret" {
  metadata {
    name        = "flux-system"
    namespace   = var.namespace
    annotations = var.annotations
  }

  data = {
    identity       = var.controller_ssh_private_key
    "identity.pub" = var.controller_ssh_public_key
    known_hosts    = var.controller_ssh_known_hosts
  }
}

resource "kubernetes_config_map" "flux_cluster_variables" {
  count = length(var.cluster_variables) > 0 ? 1 : 0

  metadata {
    name        = "flux-cluster-variables"
    namespace   = var.namespace
    annotations = var.annotations
  }
  data = var.cluster_variables
}

################################################################################
# FluxCD bootstrapping
################################################################################
resource "flux_bootstrap_git" "this" {
  ## Using read-only secret for flux controller, so need to disable the creation
  ## and create the secret beforehand
  disable_secret_creation = true
  path                    = var.path
  watch_all_namespaces    = var.watch_all_namespaces
  kustomization_override  = templatefile("${path.module}/kustomization.yaml.tpl", { irsa_role_arn : var.irsa_role_arn })
  version                 = var.fluxcd_version
  depends_on              = [kubernetes_secret.flux_system_secret]
}
