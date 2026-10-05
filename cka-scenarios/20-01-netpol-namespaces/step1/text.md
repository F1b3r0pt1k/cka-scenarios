Create a NetworkPolicy in `team-alpha` that selects `app=alpha-app` and allows egress only to namespace `team-beta`, plus DNS on port 53.

Create a NetworkPolicy in `team-beta` that selects `app=beta-app` and allows ingress only from namespace `team-alpha` on TCP port 80. Deny other ingress by not allowing it.

`alpha-app` should be able to fetch `http://beta-app.team-beta.svc`. It should not be able to open a connection to `1.1.1.1` port 80. `outsider` should not be able to fetch the beta Service.

## Details

These objects are already running:

| Namespace | Labels | Pod | Image |
| --- | --- | --- | --- |
| `team-alpha` | `team=alpha` | `alpha-app` | busybox, sleeps |
| `team-beta` | `team=beta` | `beta-app` | nginx on port 80, Service `beta-app` port 80 |
| `default` | none | `outsider` | busybox, sleeps |

Policy in `team-alpha` selects `app=alpha-app`, policy type Egress:

- allow traffic to namespaces labeled `team=beta`
- allow TCP and UDP 53 anywhere, so CoreDNS still works

Policy in `team-beta` selects `app=beta-app`, policy type Ingress:

- allow TCP 80 only from namespaces labeled `team=alpha`

A policy that selects the Pod and does not list a direction denies that direction.

Try from `alpha-app`: `wget` of `http://beta-app.team-beta.svc` should show the nginx page. `wget` of `http://1.1.1.1` should time out. From `outsider`, the beta Service should time out.

## Finished when

The check can fetch nginx from `alpha-app`, and both the public address and `outsider` fail to connect.

Docs: https://kubernetes.io/docs/concepts/services-networking/network-policies/
