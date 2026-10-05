Create a PersistentVolume named `logs-pv`.

- hostPath `/var/logs`
- capacity `5Gi`
- access modes `ReadWriteOnce` and `ReadOnlyMany`
- status should become Available before it is claimed

Create a PersistentVolumeClaim named `logs-pvc` that requests `2Gi` with access mode `ReadWriteOnce`. It should bind to `logs-pv`.

Create a Pod named `nginx` using `nginx:1.27-alpine` and mount the claim at `/var/log/nginx`.

In the container, create `/var/log/nginx/my-nginx.log` containing `hello from nginx`.
