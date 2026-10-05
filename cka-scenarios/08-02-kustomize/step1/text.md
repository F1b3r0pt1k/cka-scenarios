Create the directory `/root/manifests`.

Add `pod.yaml` for a Pod named `nginx` with image `nginx:1.27-alpine`.

Add `configmap.yaml` for a ConfigMap named `logs-config` with key `dir` set to `/etc/logs/traffic.log`.

Create both objects with a single declarative command.

## Details

Both manifests go in `/root/manifests`. Apply the directory in one command (`kubectl apply -f /root/manifests`). The ConfigMap data key is `dir` and the value is exactly `/etc/logs/traffic.log`.

## Finished when

- Pod `nginx` uses image `nginx:1.27-alpine`.
- ConfigMap `logs-config` data `dir` is `/etc/logs/traffic.log`.

Docs: https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/
