provider "flux" {
  kubernetes = {
    config_path = "/some/kube/config"
  }
  git = {
    url = "https://does.not.exist"
  }
}


variables {
  path                       = "./clusters/dev"
  controller_ssh_public_key  = "SOME_VERY_PUBLIC_KEY"
  controller_ssh_private_key = "AN_EXTREMELY_SECRET_PRIVATE_KEY"
  controller_ssh_known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  service_account_annotations = {
    "eks.amazonaws.com/role-arn" = "arn:aws:iam::123456789012:role/fluxcd-irsa-role"
  }
  service_account_labels = {
    "foo" = "bar"
  }
}

run "validate" {
  command = plan
}
