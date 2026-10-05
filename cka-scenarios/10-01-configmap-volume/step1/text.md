Create a ConfigMap named `app-config` from `/root/application.yaml`.

Create a Pod named `backend` using `nginx:1.27-alpine`. Mount the ConfigMap at `/etc/config`.

Open a shell in the Pod and read the file on that mount.

## Details

`/root/application.yaml` contains `log_level: info` and `listen: "8080"`. Creating the ConfigMap from that file (`--from-file`) uses the filename as the key, so the mount shows `/etc/config/application.yaml`.

Mount the ConfigMap as a volume on Pod `backend`. The image is `nginx:1.27-alpine`.

## Finished when

`kubectl exec backend -- cat /etc/config/application.yaml` prints `log_level: info`, and the container has a volume mount at `/etc/config`.

Docs: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
