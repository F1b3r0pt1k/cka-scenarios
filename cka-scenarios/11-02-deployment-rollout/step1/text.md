Create a Deployment named `nginx` with 3 replicas.

- Container name: `nginx`
- Image: `nginx:1.27.0-alpine`
- Label on the Deployment object: `tier=backend`
- Label on the Pod template: `app=v1` (the selector must match)

Wait until all replicas are ready.

Change the container image to `nginx:1.27.4-alpine` and wait until that revision is fully rolled out.

Set the Deployment annotation `kubernetes.io/change-cause` to `Pick up patch version` so the rollout history records that cause.

## Details

Selector and Pod template label must both be `app=v1`. The Deployment object's own label `tier=backend` is metadata only. It is not the selector.

Container name `nginx`, image `nginx:1.27.0-alpine`, 3 replicas. After they are ready, set the image to `nginx:1.27.4-alpine` and wait for the rollout.

Record the cause with the annotation `kubernetes.io/change-cause=Pick up patch version` on the Deployment. `kubectl rollout history deployment/nginx` should show that text.

## Finished when

- 3 ready replicas, label `tier=backend`, template label `app=v1`.
- The live image is `nginx:1.27.4-alpine`.
- The change cause is `Pick up patch version`.

Docs: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment
