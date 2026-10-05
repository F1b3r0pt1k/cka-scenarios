Create namespace `quota-demo`.

Create a ResourceQuota named `app` in that namespace from a file. Hard limits:

- `pods`: `2`
- `requests.cpu`: `2`
- `requests.memory`: `500Mi`

Try to create a Pod named `too-big` in `quota-demo` that requests `500m` CPU and `1Gi` memory, using `nginx:1.27-alpine`. Save the error text to `/root/quota-error.txt`.

Create a Pod named `fits` in the same namespace that requests `200m` CPU and `200Mi` memory. It should be running.

Describe the quota and keep the namespace total within the hard limits.
