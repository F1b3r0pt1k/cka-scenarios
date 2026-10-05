Create the namespace `apps` and a ServiceAccount named `api-access` in that namespace.

Create a ClusterRole named `api-clusterrole` and a ClusterRoleBinding named `api-clusterrolebinding`. The binding should map `api-access` in `apps` to `get`, `list`, and `watch` on `pods`. Do not grant delete.

## Details

Use a ClusterRoleBinding, not a RoleBinding, so the account can read Pods in every namespace. The subject is a ServiceAccount, so set `namespace: apps` on that subject. Leave `delete` off the verb list.

## Finished when

- ServiceAccount `apps/api-access` exists.
- ClusterRole `api-clusterrole` allows `get`, `list`, and `watch` on `pods` and does not allow `delete`.
- ClusterRoleBinding `api-clusterrolebinding` references that ServiceAccount.

Docs: https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions
