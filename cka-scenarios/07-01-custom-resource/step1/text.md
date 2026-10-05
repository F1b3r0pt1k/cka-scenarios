Apply `/root/database-crd.yaml`.

List CRDs and confirm the new type is present. Inspect its schema so you know the `spec` fields.

Create a namespaced custom resource of that kind named `sample` in the `default` namespace. Set `spec.version` to `7` and `spec.storage` to `10Gi`.

## Details

`/root/database-crd.yaml` is on the control plane. After you apply it, `kubectl api-resources` and `kubectl explain database.spec` show the kind `Database` and the spec fields `version` and `storage`.

Create the object in `default`. Field names are case-sensitive.

## Finished when

- CRD `databases.platform.example.com` exists.
- `database/sample` has `spec.version` `7` and `spec.storage` `10Gi`.

Docs: https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/
