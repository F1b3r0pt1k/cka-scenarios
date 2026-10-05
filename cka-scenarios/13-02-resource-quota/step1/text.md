Create namespace `quota-demo`.

Create a ResourceQuota named `app` in that namespace from a file. Hard limits:

- `pods`: `2`
- `requests.cpu`: `2`
- `requests.memory`: `500Mi`

Try to create a Pod named `too-big` in `quota-demo` that requests `500m` CPU and `1Gi` memory, using `nginx:1.27-alpine`. Save the error text to `/root/quota-error.txt`.

Create a Pod named `fits` in the same namespace that requests `200m` CPU and `200Mi` memory. It should be running.

Describe the quota and keep the namespace total within the hard limits.

## Details

Namespace `quota-demo`. ResourceQuota `app` with hard limits `pods: "2"`, `requests.cpu: "2"`, `requests.memory: 500Mi`. Any Pod in that namespace must declare cpu and memory requests or the quota rejects it.

Pod `too-big`: image `nginx:1.27-alpine`, request cpu `500m` and memory `1Gi`. Creation fails. Save the full error, including the words `exceeded quota`, to `/root/quota-error.txt`. Do not leave a Pod named `too-big`.

Pod `fits`: request cpu `200m` and memory `200Mi`. It should become Ready. `kubectl describe quota app -n quota-demo` shows used versus hard.

## Finished when

The error file contains `exceeded quota`, `too-big` does not exist, and `fits` is Ready with memory request `200Mi`.

Docs: https://kubernetes.io/docs/concepts/policy/resource-quotas/
