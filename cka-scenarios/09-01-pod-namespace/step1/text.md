Create namespace `web`.

Create a Pod named `nginx` in that namespace using `nginx:1.27-alpine` and container port 80.

Read the Pod details, including its IP address. From a short-lived Pod in the same namespace, request that IP (or the Pod name, if you also create a Service — the Pod IP is enough) on port 80 and confirm you receive the nginx welcome page. Then read the nginx container logs.
