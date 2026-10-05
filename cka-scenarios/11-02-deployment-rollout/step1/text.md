Create a Deployment named `nginx` with 3 replicas.

- Container name: `nginx`
- Image: `nginx:1.27.0-alpine`
- Label on the Deployment object: `tier=backend`
- Label on the Pod template: `app=v1` (the selector must match)

Wait until all replicas are ready.

Change the container image to `nginx:1.27.4-alpine` and wait until that revision is fully rolled out.

Set the Deployment annotation `kubernetes.io/change-cause` to `Pick up patch version` so the rollout history records that cause.
