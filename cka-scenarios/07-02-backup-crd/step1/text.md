Apply `/root/backup-crd.yaml` and read the CRD so you can see the stored version and the `spec` properties.

Create a custom resource named `nginx-backup` in the `default` namespace with:

- `cronExpression`: `0 0 * * *`
- `podName`: `nginx`
- `path`: `/usr/local/nginx`
