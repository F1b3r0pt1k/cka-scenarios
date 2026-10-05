In `shop`, create these NetworkPolicies.

`database-policy` selects `tier=database` and allows ingress only from `tier=backend` on TCP port 6379.

`backend-policy` selects `tier=backend`. Allow ingress from `tier=frontend` on TCP port 80. Allow egress to `tier=database` on TCP port 6379, and allow DNS on port 53.

Create a default deny-all ingress policy that selects every Pod in `shop`.

Check the paths: frontend reaches `http://backend`, frontend does not reach `database:6379`, and backend does reach `database:6379`.
