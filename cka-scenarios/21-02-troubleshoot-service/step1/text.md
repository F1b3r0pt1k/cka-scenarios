List endpoints for Service `web` in `shop`. Compare the Service selector and target port with the Pod labels and the container port.

Correct the Service. From a short-lived Pod in `shop`, `wget` the Service name `web` and confirm the nginx welcome page.

## Details

Namespace `shop` already has Deployment `web` and Service `web`. The original objects are also in `/root/broken-service.yaml`.

The Deployment is healthy: label `app=web`, container port 80, image `nginx:1.27-alpine`. The Service selector is `app=web-wrong` and `targetPort` is `8080`, so `kubectl get endpoints web -n shop` shows no addresses.

Edit the live Service. Selector `app=web`, target port `80`. Then `wget http://web` from a Pod in `shop` returns the nginx welcome page.

## Finished when

The Service selector is `app=web`, the target port is `80`, endpoints exist, and a request to `http://web` inside the namespace returns the welcome page.

Docs: https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/
