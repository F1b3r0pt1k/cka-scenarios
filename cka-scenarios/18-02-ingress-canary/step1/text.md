Create namespace `production`.

Deploy `blue` with 3 replicas of `nginx:1.27.0-alpine` and a ClusterIP Service `blue` on port 80.

Deploy `green` with 3 replicas of `nginx:1.27.4-alpine` and a ClusterIP Service `green` on port 80.

Create two Ingresses in `production`, both class `nginx`, host `app.production.com`, path `/`:

- `app-main` routes to Service `blue`
- `app-canary` routes to Service `green`, marked as a canary, with weight `20`

Add a hosts entry on the control plane if you want to curl the host name. The check calls the controller Service directly with a Host header.

## Details

Namespace `production`. Ingress class `nginx`.

- Deployment and Service `blue`, 3 replicas, `nginx:1.27.0-alpine`, port 80
- Deployment and Service `green`, 3 replicas, `nginx:1.27.4-alpine`, port 80

Ingress `app-main`: host `app.production.com`, path `/`, backend `blue`.

Ingress `app-canary`: same host and path, backend `green`, annotations:

- `nginx.ingress.kubernetes.io/canary: "true"`
- `nginx.ingress.kubernetes.io/canary-weight: "20"`

The weight is the string `20`. You can add `app.production.com` to `/etc/hosts` pointing at the controller address if you want to curl the hostname. The check reads the objects. It does not sample the 20 percent split.

## Finished when

Both Deployments are ready, `app-main` sends `/` to `blue`, and `app-canary` sends `/` to `green` with canary `true` and weight `20`.

Docs: https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#canary
