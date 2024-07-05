# terraform-eks-fluxcd-sops
Module to bootstrap FluxCD on EKS cluster with SOPS as encryption provider and a separate
set of credentials for flux controller, which makes it possible for giving the controller
a read-only access to the repository.

## Usage

```hcl
module "fluxcd" {
  source                     = "github.com/neondatabase/terraform-eks-fluxcd-sops?ref=v0.16"
  path                       = "./clusters/dev"
  controller_ssh_public_key  = file("./deploy-key.pub")
  controller_ssh_private_key = file("./deploy-key.priv")
  controller_ssh_known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  service_account_annotations = {
    "eks.amazonaws.com/role-arn" = "arn:aws:iam::123456789012:role/fluxcd-irsa-role"
  }
}
```

<!-- BEGIN_TF_DOCS -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controller_ssh_private_key"></a> [controller\_ssh\_private\_key](#input\_controller\_ssh\_private\_key) | SSH private key for flux controller | `string` | n/a | yes |
| <a name="input_controller_ssh_public_key"></a> [controller\_ssh\_public\_key](#input\_controller\_ssh\_public\_key) | SSH public key for flux controller | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path relative to flux repository root where to look for manifests | `string` | n/a | yes |
| <a name="input_cluster_secrets"></a> [cluster\_secrets](#input\_cluster\_secrets) | Key-value pairs to create 'terraform-flux-cluster-secrets' Secret for flux/Kustomization postBuild use | `map(string)` | `{}` | no |
| <a name="input_cluster_variables"></a> [cluster\_variables](#input\_cluster\_variables) | Key-value pairs to create 'terraform-flux-cluster-variables' ConfigMap for flux/Kustomization postBuild use | `map(string)` | `{}` | no |
| <a name="input_controller_ssh_known_hosts"></a> [controller\_ssh\_known\_hosts](#input\_controller\_ssh\_known\_hosts) | SSH known hosts for flux controller. Defaults to github.com ECDSA key. | `string` | `"github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="` | no |
| <a name="input_fluxcd_version"></a> [fluxcd\_version](#input\_fluxcd\_version) | Flux version to use | `string` | `"v2.1.1"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy fluxcd to | `string` | `"flux-system"` | no |
| <a name="input_pod_labels"></a> [pod\_labels](#input\_pod\_labels) | Labels to add to the kustomize-controller pods | `map(string)` | `{}` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Annotations to add to the kustomize-controller service account | `map(string)` | `{}` | no |
| <a name="input_service_account_labels"></a> [service\_account\_labels](#input\_service\_account\_labels) | Annotations to add to the kustomize-controller service account | `map(string)` | `{}` | no |
| <a name="input_watch_all_namespaces"></a> [watch\_all\_namespaces](#input\_watch\_all\_namespaces) | Whether flux controller should watch all namespaces for custom resources or not | `bool` | `true` | no |

* * *
<details>
<summary>Detailed information</summary>
## Resources

| Name | Type |
|------|------|
| [flux_bootstrap_git.this](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/resources/bootstrap_git) | resource |
| [kubernetes_config_map.flux_cluster_variables](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.flux_system_ns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.flux_cluster_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.flux_system_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

</details>
<!-- END_TF_DOCS -->
