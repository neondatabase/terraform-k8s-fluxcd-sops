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
<!-- END_TF_DOCS -->
