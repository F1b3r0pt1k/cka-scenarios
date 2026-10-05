Create a Deployment named `database` with 1 replica of `busybox:1.36`. Run a shell loop that listens on TCP port 3306 (`nc -l -p 3306` in a loop is enough). Label the Pods `app=database`.

Create a ClusterIP Service named `database-service` that selects those Pods and exposes port 3306.

Create a Deployment named `frontend` with 2 replicas of `busybox:1.36`. Label the Pods `app=frontend`. Run:

`while true; do nc -z -w 3 database-service 3306 && echo connected; sleep 5; done`

The frontend logs should show successful connections.

## Details

This is service discovery, not a real database. `database` is `busybox:1.36` listening on TCP 3306. A listener that exits after one connection will flap. Keep it in a loop:

`while true; do nc -l -p 3306; done`

Label those Pods `app=database`. Service `database-service` is `ClusterIP`, port `3306`, selector `app=database`.

`frontend` has 2 replicas of `busybox:1.36`, label `app=frontend`, command:

`while true; do nc -z -w 3 database-service 3306 && echo connected; sleep 5; done`

The Pods resolve `database-service` in the same namespace. Logs should print `connected`.

## Finished when

Both Deployments are rolled out, the Service is ClusterIP port 3306 with an endpoint, and a frontend Pod log contains `connected`.

Docs: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
