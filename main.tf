################################################################################
# Kubernetes Namespace, Secret and ConfigMap creation
################################################################################
resource "kubernetes_namespace" "flux_system_ns" {
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [metadata[0].labels]
  }
}

resource "kubernetes_secret" "flux_system_secret" {
  metadata {
    name      = "flux-system"
    namespace = var.namespace
  }

  data = {
    identity       = var.controller_ssh_private_key
    "identity.pub" = var.controller_ssh_public_key
    known_hosts    = var.controller_ssh_known_hosts
  }

  depends_on = [kubernetes_namespace.flux_system_ns]
}

resource "kubernetes_config_map" "flux_cluster_variables" {

  metadata {
    name      = "terraform-flux-cluster-variables"
    namespace = var.namespace
  }
  data = var.cluster_variables

  depends_on = [kubernetes_namespace.flux_system_ns]
}

resource "kubernetes_secret" "flux_cluster_secrets" {

  metadata {
    name      = "terraform-flux-cluster-secrets"
    namespace = var.namespace
  }
  data = var.cluster_secrets

  depends_on = [kubernetes_namespace.flux_system_ns]
}

################################################################################
# FluxCD bootstrapping
################################################################################
resource "terraform_data" "fluxcd_reprovision" {
  input = var.path
}

resource "flux_bootstrap_git" "this" {
  ## Using read-only secret for flux controller, so need to disable the creation
  ## and create the secret beforehand
  disable_secret_creation = true
  path                    = var.path
  delete_git_manifests    = var.delete_git_manifests
  keep_namespace          = var.keep_namespace
  watch_all_namespaces    = var.watch_all_namespaces
  kustomization_override = templatefile("${path.module}/kustomization.yaml.tpl", {
    service_account_annotations        = jsonencode(var.service_account_annotations)
    service_account_labels             = jsonencode(var.service_account_labels)
    pod_labels                         = jsonencode(var.pod_labels)
    flux_system_prune                  = jsonencode(var.flux_system_prune)
    kustomize_controller_feature_gates = join(",", [for key, value in var.kustomize_controller_feature_gates : "${key}=${value}"])
  })
  version    = var.fluxcd_version
  depends_on = [kubernetes_secret.flux_system_secret]

  timeouts = {
    create = "2m"
    delete = "2m"
    read   = "2m"
    update = "2m"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.fluxcd_reprovision]
  }
}
