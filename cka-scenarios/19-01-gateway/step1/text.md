In the `default` namespace create:

- Deployment `web-app`, 2 replicas, `nginx:1.27-alpine`, ClusterIP Service `web-app` port 80
- Deployment `api-app`, 2 replicas, `httpd:2.4-alpine`, ClusterIP Service `api-app` port 80

Create a Gateway named `main-gateway`.

- GatewayClass `nginx`
- One HTTP listener on port 80
- Hostname `example.local`

Create an HTTPRoute named `app-routes` attached to that Gateway.

- Hostname `example.local`
- Prefix `/web` to Service `web-app` port 80
- Prefix `/api` to Service `api-app` port 80

Wait until the Gateway reports a programmed address or an accepted listener, and the HTTPRoute is accepted.
