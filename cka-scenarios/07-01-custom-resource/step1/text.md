Apply `/root/database-crd.yaml`.

List CRDs and confirm the new type is present. Inspect its schema so you know the `spec` fields.

Create a namespaced custom resource of that kind named `sample` in the `default` namespace. Set `spec.version` to `7` and `spec.storage` to `10Gi`.
