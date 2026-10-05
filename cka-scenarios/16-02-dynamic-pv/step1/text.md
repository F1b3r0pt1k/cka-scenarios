Create namespace `persistence`.

Create a PersistentVolumeClaim named `db-pvc` in that namespace.

- Access mode `ReadWriteOnce`
- Request `10Mi`
- Storage class `local-path`

Confirm the claim is Pending and that no PersistentVolume has been created for it yet.
