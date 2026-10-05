Create a ClusterRole named `service-view` that allows `get` and `list` on `services`.

In the `development` namespace, create a RoleBinding named `devuser-service-view` that maps the user `devuser` to that ClusterRole.

Create a ClusterRole named `combined` whose rules are aggregated from every ClusterRole labeled `rbac.example.com/aggregate=true`. Do not put rules directly on `combined`.

Do not put the aggregation label on `service-view`.

Confirm, as `devuser`, whether that user can list Services in `development`. Write `yes` or `no` to `/root/list-services.txt`.
