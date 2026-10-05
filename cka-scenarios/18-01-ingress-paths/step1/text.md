Create namespace `webapp`.

In that namespace create:

- Deployment `frontend`, 2 replicas, image `nginx:1.27-alpine`, and a ClusterIP Service `frontend` on port 80
- Deployment `api`, 2 replicas, image `httpd:2.4-alpine`, and a ClusterIP Service `api` on port 80

Create an Ingress named `app` in `webapp` with class `nginx` and host `app.example.com`.

- `/` and `/app` go to Service `frontend` port 80
- `/api` goes to Service `api` port 80

Use prefix path matching. Request `/` through the ingress controller and confirm you reach nginx.

## Details

ingress-nginx is already installed. IngressClass name: `nginx`. Controller Service: `ingress-nginx/ingress-nginx-controller`.

Namespace `webapp`.

- Deployment and Service `frontend`, 2 replicas, `nginx:1.27-alpine`, ClusterIP port 80
- Deployment and Service `api`, 2 replicas, `httpd:2.4-alpine`, ClusterIP port 80

Ingress `app`:

- `ingressClassName: nginx`
- host `app.example.com`
- prefix `/` and prefix `/app` to Service `frontend` port 80
- prefix `/api` to Service `api` port 80

There is no DNS record for that host. Call the controller ClusterIP with header `Host: app.example.com`. Path `/` should return the nginx welcome page.

## Finished when

Both Deployments are ready, the Ingress rules match the three paths, and a request to `/` with that Host header returns the nginx page.

Docs: https://kubernetes.io/docs/concepts/services-networking/ingress/
