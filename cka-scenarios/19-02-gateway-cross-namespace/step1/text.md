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
