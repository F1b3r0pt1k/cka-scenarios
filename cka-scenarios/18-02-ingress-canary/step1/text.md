Create namespace `production`.

Deploy `blue` with 3 replicas of `nginx:1.27.0-alpine` and a ClusterIP Service `blue` on port 80.

Deploy `green` with 3 replicas of `nginx:1.27.4-alpine` and a ClusterIP Service `green` on port 80.

Create two Ingresses in `production`, both class `nginx`, host `app.production.com`, path `/`:

- `app-main` routes to Service `blue`
- `app-canary` routes to Service `green`, marked as a canary, with weight `20`

Add a hosts entry on the control plane if you want to curl the host name. The check calls the controller Service directly with a Host header.
