Create a NetworkPolicy in `team-alpha` that selects `app=alpha-app` and allows egress only to namespace `team-beta`, plus DNS on port 53.

Create a NetworkPolicy in `team-beta` that selects `app=beta-app` and allows ingress only from namespace `team-alpha` on TCP port 80. Deny other ingress by not allowing it.

`alpha-app` should be able to fetch `http://beta-app.team-beta.svc`. It should not be able to open a connection to `1.1.1.1` port 80. `outsider` should not be able to fetch the beta Service.
