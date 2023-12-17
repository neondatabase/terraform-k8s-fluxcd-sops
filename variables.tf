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

variable "irsa_role_arn" {
  description = "Arn of IRSA role that is mapped to kustomize-controller service account in flux-system namespace"
  type        = string
}

# optional
variable "controller_ssh_known_hosts" {
  description = "SSH known hosts for flux controller. Defaults to github.com ECDSA key."
  type        = string
  default     = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}

variable "namespace" {
  description = "Kubernetes namespace to deploy fluxcd to"
  type        = string
  default     = "flux-system"
}

variable "annotations" {
  description = "Annotations to add to created kubernetes resources"
  type        = map(string)
  default     = {}
}

variable "cluster_variables" {
  description = "Key-value pairs to create 'terraform-flux-cluster-variables' ConfigMap for flux/Kustomization postBuild use"
  type        = map(string)
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
  default     = "v2.1.1"
}
