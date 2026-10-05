Create a PersistentVolume named `logs-pv`.

- hostPath `/var/logs`
- capacity `5Gi`
- access modes `ReadWriteOnce` and `ReadOnlyMany`
- status should become Available before it is claimed

Create a PersistentVolumeClaim named `logs-pvc` that requests `2Gi` with access mode `ReadWriteOnce`. It should bind to `logs-pv`.

Create a Pod named `nginx` using `nginx:1.27-alpine` and mount the claim at `/var/log/nginx`.

In the container, create `/var/log/nginx/my-nginx.log` containing `hello from nginx`.

## Details

`/var/logs` already exists on both nodes and is world-writable.

PersistentVolume `logs-pv`:

- capacity `5Gi`
- accessModes `ReadWriteOnce` and `ReadOnlyMany`
- hostPath `/var/logs`

It should be `Available` until the claim binds it.

PersistentVolumeClaim `logs-pvc`: access mode `ReadWriteOnce`, request `2Gi`. Do not set a storage class that would block static binding. Leaving `storageClassName` empty, or `""`, lets it bind to the static volume.

Pod `nginx`, image `nginx:1.27-alpine`, claim mounted at `/var/log/nginx`. Create `/var/log/nginx/my-nginx.log` containing `hello from nginx`.

## Finished when

The PV is `Bound` to `logs-pvc` with capacity `5Gi` and both access modes, and the file is readable inside the Pod.

Docs: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#static
