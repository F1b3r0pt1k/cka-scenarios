Create namespace `persistence`.

Create a PersistentVolumeClaim named `db-pvc` in that namespace.

- Access mode `ReadWriteOnce`
- Request `10Mi`
- Storage class `local-path`

Confirm the claim is Pending and that no PersistentVolume has been created for it yet.

## Details

StorageClass `local-path` is installed and uses `WaitForFirstConsumer`. A claim with that class stays `Pending` until a Pod that mounts it is scheduled. Do not create the Pod in this step.

Namespace `persistence`. Claim `db-pvc`, access mode `ReadWriteOnce`, request `10Mi`, `storageClassName: local-path`.

## Finished when

The claim phase is `Pending`, its storage class is `local-path`, and no PersistentVolume exists yet.

Docs: https://kubernetes.io/docs/concepts/storage/storage-classes/
