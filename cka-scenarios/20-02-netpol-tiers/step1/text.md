In `shop`, create these NetworkPolicies.

`database-policy` selects `tier=database` and allows ingress only from `tier=backend` on TCP port 6379.

`backend-policy` selects `tier=backend`. Allow ingress from `tier=frontend` on TCP port 80. Allow egress to `tier=database` on TCP port 6379, and allow DNS on port 53.

Create a default deny-all ingress policy that selects every Pod in `shop`.

Check the paths: frontend reaches `http://backend`, frontend does not reach `database:6379`, and backend does reach `database:6379`.

## Details

Namespace `shop` is already populated:

- `database`, label `tier=database`, Redis on 6379, Service `database` port 6379
- `backend`, label `tier=backend`, busybox `httpd` on port 80, Service `backend` port 80
- `frontend`, label `tier=frontend`, busybox sleeping

Create:

1. `database-policy` selecting `tier=database`. Ingress only from `tier=backend` on TCP 6379.
2. `backend-policy` selecting `tier=backend`. Ingress from `tier=frontend` on TCP 80. Egress to `tier=database` on TCP 6379, plus TCP and UDP 53 for DNS.
3. A default deny ingress policy whose `podSelector` is empty (every Pod) and whose policy types include `Ingress`, with no ingress rules.

Probes:

- `frontend` can `wget http://backend`
- `frontend` cannot open TCP `database:6379`
- `backend` can open TCP `database:6379` (`nc -z -w 4 database 6379`)

## Finished when

Those three connectivity results hold and the two named policies exist.

Docs: https://kubernetes.io/docs/concepts/services-networking/network-policies/
