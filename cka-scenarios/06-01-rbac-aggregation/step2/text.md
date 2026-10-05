Create a ClusterRole named `deployment-modify` that allows `create`, `delete`, `patch`, and `update` on `deployments`. Label it `rbac.example.com/aggregate=true` so `combined` picks it up.

Confirm, as `devuser`, whether that user can watch Deployments in `production`. Write `yes` or `no` to `/root/watch-deployments.txt`.

## Details

Aggregation is asynchronous. After you label `deployment-modify`, give the controller a few seconds and read `combined` again. The deployment verbs should show up there without you editing `combined`.

`devuser` has no binding that allows watching Deployments in `production`, so the answer is `no`.

## Finished when

- ClusterRole `deployment-modify` allows `create`, `delete`, `patch`, and `update` on `deployments` and has label `rbac.example.com/aggregate=true`.
- ClusterRole `combined` includes `deployments`.
- `/root/watch-deployments.txt` contains `no`.
