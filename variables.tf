# required
variable "path" {
  description = "Path relative to flux repository root where to look for manifests"
  type        = string
}

variable "controller_ssh_public_key" {
  description = "SSH public key for flux controller"
  type        = string
}

variable "controller_ssh_private_key" {
  description = "SSH private key for flux controller"
  type        = string
  sensitive   = true
}

# optional
# For features such as workload/pod identity, adding specific
# labels/annotations to service accounts is necessary, but those differ across
# cloud providers.
variable "service_account_annotations" {
  description = "Annotations to add to the kustomize-controller service account"
  type        = map(string)
  default     = {}
}

variable "service_account_labels" {
  description = "Annotations to add to the kustomize-controller service account"
  type        = map(string)
  default     = {}
}

variable "pod_labels" {
  description = "Labels to add to the kustomize-controller pods"
  type        = map(string)
  default     = {}
}

variable "controller_ssh_known_hosts" {
  description = "SSH known hosts for flux controller. Defaults to github.com ECDSA key."
  type        = string
  default     = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}

variable "kustomize_controller_feature_gates" {
  description = "Kustomize controller feature gates to enable/disable."
  type        = map(bool)
  default     = {}
}

variable "namespace" {
  description = "Kubernetes namespace to deploy fluxcd to"
  type        = string
  default     = "flux-system"
}

variable "cluster_variables" {
  description = "Key-value pairs to create 'terraform-flux-cluster-variables' ConfigMap for flux/Kustomization postBuild use"
  type        = map(string)
  default     = {}
}

variable "cluster_secrets" {
  description = "Key-value pairs to create 'terraform-flux-cluster-secrets' Secret for flux/Kustomization postBuild use"
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "watch_all_namespaces" {
  description = "Whether flux controller should watch all namespaces for custom resources or not"
  type        = bool
  default     = true
}

variable "fluxcd_version" {
  description = "Flux version to use"
  type        = string
  default     = "v2.3.0"
}

variable "delete_git_manifests" {
  description = "Delete manifests from git repository. Defaults to true."
  type        = bool
  default     = true
}

# FluxCD defaults to false, but the module explicitly creates the namespace,
# so flux_bootstrap_git should not be removing it.
variable "keep_namespace" {
  description = "Keep the namespace after uninstalling Flux components. Defaults to true"
  type        = bool
  default     = true
}

variable "flux_system_prune" {
  description = "Whether pruning should be set on flux-system Kustomization. Defaults to true"
  type        = bool
  default     = true
}
