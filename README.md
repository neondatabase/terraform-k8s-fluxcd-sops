# terraform-eks-fluxcd-sops
Module to bootstrap FluxCD on EKS cluster with SOPS as encryption provider and a separate
set of credentials for flux controller, which makes it possible for giving the controller
a read-only access to the repository.

## Usage

```hcl
module "fluxcd" {
  source                     = "github.com/lassizci/terraform-eks-fluxcd-sops?ref=v0.9"
  path                       = "./clusters/dev"
  controller_ssh_public_key  = file("./deploy-key.pub")
  controller_ssh_private_key = file("./deploy-key.priv")
  controller_ssh_known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  irsa_role_arn              = "arn:aws:iam::123456789012:role/fluxcd-irsa-role"
}
```

<!-- BEGIN_TF_DOCS -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controller_ssh_known_hosts"></a> [controller\_ssh\_known\_hosts](#input\_controller\_ssh\_known\_hosts) | SSH known hosts for flux controller | `string` | n/a | yes |
| <a name="input_controller_ssh_private_key"></a> [controller\_ssh\_private\_key](#input\_controller\_ssh\_private\_key) | SSH private key for flux controller | `string` | n/a | yes |
| <a name="input_controller_ssh_public_key"></a> [controller\_ssh\_public\_key](#input\_controller\_ssh\_public\_key) | SSH public key for flux controller | `string` | n/a | yes |
| <a name="input_irsa_role_arn"></a> [irsa\_role\_arn](#input\_irsa\_role\_arn) | Arn of IRSA role that is mapped to kustomize-controller service account in flux-system namespace | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path relative to flux repository root where to look for manifests | `string` | n/a | yes |
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations to add to created kubernetes resources | `map(string)` | `{}` | no |
| <a name="input_cluster_variables"></a> [cluster\_variables](#input\_cluster\_variables) | Key-value pairs to create 'flux-cluster-variables' ConfigMap for flux/Kustomization postBuild use | `map(string)` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy fluxcd to | `string` | `"flux-system"` | no |
| <a name="input_version"></a> [version](#input\_version) | Flux version to use | `string` | `"v2.1.1"` | no |
| <a name="input_watch_all_namespaces"></a> [watch\_all\_namespaces](#input\_watch\_all\_namespaces) | Whether flux controller should watch all namespaces ifor custom resources or not | `bool` | `true` | no |

* * *
<details>
<summary>Detailed information</summary>
## Resources

| Name | Type |
|------|------|
| [flux_bootstrap_git.this](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/resources/bootstrap_git) | resource |
| [kubernetes_config_map.flux_cluster_variables](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.flux_system_ns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.flux_system_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

</details>
<!-- END_TF_DOCS -->
