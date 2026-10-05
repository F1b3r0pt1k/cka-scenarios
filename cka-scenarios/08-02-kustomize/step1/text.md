Create the directory `/root/manifests`.

Add `pod.yaml` for a Pod named `nginx` with image `nginx:1.27-alpine`.

Add `configmap.yaml` for a ConfigMap named `logs-config` with key `dir` set to `/etc/logs/traffic.log`.

Create both objects with a single declarative command.
