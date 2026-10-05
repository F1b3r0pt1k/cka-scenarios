Create namespace `webapp`.

In that namespace create:

- Deployment `frontend`, 2 replicas, image `nginx:1.27-alpine`, and a ClusterIP Service `frontend` on port 80
- Deployment `api`, 2 replicas, image `httpd:2.4-alpine`, and a ClusterIP Service `api` on port 80

Create an Ingress named `app` in `webapp` with class `nginx` and host `app.example.com`.

- `/` and `/app` go to Service `frontend` port 80
- `/api` goes to Service `api` port 80

Use prefix path matching. Request `/` through the ingress controller and confirm you reach nginx.
