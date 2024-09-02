apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- gotk-components.yaml
- gotk-sync.yaml
patches:
- patch: |
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: kustomize-controller
      annotations: ${service_account_annotations}
      labels: ${service_account_labels}
  target:
    kind: ServiceAccount
    name: kustomize-controller
    labelSelector: app.kubernetes.io/part-of=flux
- patch: |
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: kustomize-controller
    spec:
      template:
        metadata:
          labels: ${pod_labels}
  target:
    kind: Deployment
    name: kustomize-controller
- patch: |
    apiVersion: kustomize.toolkit.fluxcd.io/v1
    kind: Kustomization
    metadata:
      name: flux-system
    spec:
      prune: ${flux_system_prune}
      decryption:
        provider: sops
  target:
    kind: Kustomization
    name: flux-system
