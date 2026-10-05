Create the namespace `apps` and a ServiceAccount named `api-access` in that namespace.

Create a ClusterRole named `api-clusterrole` and a ClusterRoleBinding named `api-clusterrolebinding`. The binding should map `api-access` in `apps` to `get`, `list`, and `watch` on `pods`. Do not grant delete.
