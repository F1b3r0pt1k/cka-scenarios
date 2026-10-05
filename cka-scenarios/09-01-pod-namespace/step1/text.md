Create namespace `web`.

Create a Pod named `nginx` in that namespace using `nginx:1.27-alpine` and container port 80.

Read the Pod details, including its IP address. From a short-lived Pod in the same namespace, request that IP (or the Pod name, if you also create a Service — the Pod IP is enough) on port 80 and confirm you receive the nginx welcome page. Then read the nginx container logs.

## Details

Create namespace `web` first. The container port field is `containerPort: 80`, not a Service. The Pod IP is in the Pod status. A temporary `busybox:1.36` Pod in `web` can `wget` that IP on port 80. The body contains `Welcome to nginx`. Then read logs with `kubectl logs`.

The check repeats that request. It deletes its own probe Pod named `curl-check` when it finishes.

## Finished when

Pod `web/nginx` is Ready, uses `nginx:1.27-alpine`, and exposes container port 80.

Docs: https://kubernetes.io/docs/concepts/workloads/pods/
