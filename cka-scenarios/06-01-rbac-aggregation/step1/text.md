Create a ClusterRole named `service-view` that allows `get` and `list` on `services`.

In the `development` namespace, create a RoleBinding named `devuser-service-view` that maps the user `devuser` to that ClusterRole.

Create a ClusterRole named `combined` whose rules are aggregated from every ClusterRole labeled `rbac.example.com/aggregate=true`. Do not put rules directly on `combined`.

Do not put the aggregation label on `service-view`.

Confirm, as `devuser`, whether that user can list Services in `development`. Write `yes` or `no` to `/root/list-services.txt`.

## Details

A client certificate for `devuser` is already installed. The kubeconfig context is `devuser-context`. You can also impersonate the user with `--as=devuser` while you are still the admin.

The RoleBinding lives in `development` and its `roleRef.kind` must be `ClusterRole`, not `Role`. `service-view` must not have the label `rbac.example.com/aggregate=true`. `combined` should start with no rules of its own and an `aggregationRule` that selects that label. Until something carries the label, `combined` has an empty rule list. That is expected.

Namespaces `development` and `production` already exist.

## Finished when

- ClusterRole `service-view` allows `get` and `list` on `services`.
- RoleBinding `devuser-service-view` in `development` binds user `devuser` to that ClusterRole.
- ClusterRole `combined` selects `rbac.example.com/aggregate=true`.
- `/root/list-services.txt` contains `yes`.

Docs: https://kubernetes.io/docs/reference/access-authn-authz/rbac/
