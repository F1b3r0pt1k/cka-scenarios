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

## Details

Gateway API and NGINX Gateway Fabric are installed. GatewayClass: `nginx`.

In `default`:

- Deployment and Service `web-app`, 2 replicas, `nginx:1.27-alpine`, port 80
- Deployment and Service `api-app`, 2 replicas, `httpd:2.4-alpine`, port 80

Gateway `main-gateway`: class `nginx`, one listener named anything you like, protocol `HTTP`, port `80`, hostname `example.local`.

HTTPRoute `app-routes`:

- `parentRefs` name `main-gateway`
- hostname `example.local`
- `PathPrefix` `/web` to Service `web-app` port 80
- `PathPrefix` `/api` to Service `api-app` port 80

Wait until `kubectl get gateway main-gateway` shows an accepted or programmed listener.

## Finished when

Both Deployments are ready and the Gateway and HTTPRoute fields match the list above.

Docs: https://gateway-api.sigs.k8s.io/guides/
