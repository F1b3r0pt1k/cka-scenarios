Create namespaces `production` and `staging`.

In `production`, Deployment `prod-web` with 3 replicas of `nginx:1.27-alpine` and ClusterIP Service `prod-web` on port 80.

In `staging`, Deployment `staging-web` with 2 replicas of `nginx:1.27-alpine` and ClusterIP Service `staging-web` on port 80.

In `production`, create Gateway `edge`:

- Class `nginx`
- HTTP listener on port 80
- Hostname `example.com`
- `allowedRoutes` from all namespaces

Create HTTPRoute `prod-route` in `production`, attached to `edge`:

- Exact path `/app` to Service `prod-web` port 80
- Set request header `X-Environment` to `production`

Create HTTPRoute `staging-route` in `staging`, attached to Gateway `edge` in namespace `production`:

- Prefix path `/staging` to Service `staging-web` port 80
- Set request header `X-Environment` to `staging`

Create a ReferenceGrant in `production` that allows HTTPRoutes from `staging` to attach to Gateway `edge`.

## Details

GatewayClass is `nginx`.

`production`: Deployment `prod-web`, 3 replicas, `nginx:1.27-alpine`, Service `prod-web` port 80.

`staging`: Deployment `staging-web`, 2 replicas, `nginx:1.27-alpine`, Service `staging-web` port 80.

Gateway `edge` in `production`: HTTP port 80, hostname `example.com`, `allowedRoutes.namespaces.from: All`.

HTTPRoute `prod-route` in `production`: parent `edge`, exact path `/app`, backend `prod-web` port 80, request header `X-Environment=production` using a `RequestHeaderModifier` filter with `set`.

HTTPRoute `staging-route` in `staging`: parentRef name `edge` and namespace `production`, prefix `/staging`, backend `staging-web` port 80, header `X-Environment=staging`.

ReferenceGrant in `production`: `from` an HTTPRoute in namespace `staging`, `to` Gateway `edge`. Without the grant, the cross-namespace parentRef is not allowed.

## Finished when

Both Deployments are ready, the listener allows all namespaces, both routes match the paths and headers above, and a ReferenceGrant in `production` allows `staging`.

Docs: https://gateway-api.sigs.k8s.io/guides/http-routing/
