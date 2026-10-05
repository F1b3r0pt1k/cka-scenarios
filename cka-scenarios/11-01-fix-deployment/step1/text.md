Apply `/root/fix-me-deployment.yaml`. Read the error, fix the manifest, and create the Deployment.

Three replicas should become ready. Do not change the Deployment name, the replica count, or the container image.

## Details

`/root/fix-me-deployment.yaml` is rejected because `spec.selector.matchLabels` is `run: server` while the Pod template labels are `app: nginx`. Those two maps must be identical before the API server will create the Deployment.

Keep the name `nginx`, `replicas: 3`, and image `nginx:1.27-alpine`. Edit the file and apply it. Wait until the rollout finishes.

## Finished when

Deployment `nginx` has 3 ready replicas and the selector matches the Pod template labels.

Docs: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
