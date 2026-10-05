Write `/root/hello-deployment.yaml` for a Deployment named `hello` with 3 replicas. Use the image `nginx:1.27-alpine`. Create it from that file.

Edit the file so the replica count is 8. Apply the file again and wait until all eight Pods are ready.

## Details

Keep the object in `/root/hello-deployment.yaml`. The check reads that file and expects the text `replicas: 8` after the second apply. An imperative `kubectl scale` that never updates the file will fail the check.

Image `nginx:1.27-alpine`. Name `hello`. Start at 3 replicas, apply, then change the file to 8 and apply again. Wait until 8 Pods are Ready.

## Finished when

The file sets `replicas: 8` and Deployment `hello` has 8 ready replicas on `nginx:1.27-alpine`.

Docs: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment
