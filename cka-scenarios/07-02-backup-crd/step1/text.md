Apply `/root/backup-crd.yaml` and read the CRD so you can see the stored version and the `spec` properties.

Create a custom resource named `nginx-backup` in the `default` namespace with:

- `cronExpression`: `0 0 * * *`
- `podName`: `nginx`
- `path`: `/usr/local/nginx`

## Details

`/root/backup-crd.yaml` defines kind `Backup`, group `example.com`, plural `backups`. The stored schema fields under `spec` are `cronExpression`, `podName`, and `path`. The cron value is five fields: minute, hour, day of month, month, day of week.

## Finished when

`backup/nginx-backup` exists with cron `0 0 * * *`, pod name `nginx`, and path `/usr/local/nginx`.

Docs: https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/
