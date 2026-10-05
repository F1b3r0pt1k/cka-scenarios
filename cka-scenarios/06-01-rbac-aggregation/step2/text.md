Create a ClusterRole named `deployment-modify` that allows `create`, `delete`, `patch`, and `update` on `deployments`. Label it `rbac.example.com/aggregate=true` so `combined` picks it up.

Confirm, as `devuser`, whether that user can watch Deployments in `production`. Write `yes` or `no` to `/root/watch-deployments.txt`.
