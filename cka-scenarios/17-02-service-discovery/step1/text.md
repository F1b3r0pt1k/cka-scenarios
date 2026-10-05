Create a Deployment named `database` with 1 replica of `busybox:1.36`. Run a shell loop that listens on TCP port 3306 (`nc -l -p 3306` in a loop is enough). Label the Pods `app=database`.

Create a ClusterIP Service named `database-service` that selects those Pods and exposes port 3306.

Create a Deployment named `frontend` with 2 replicas of `busybox:1.36`. Label the Pods `app=frontend`. Run:

`while true; do nc -z -w 3 database-service 3306 && echo connected; sleep 5; done`

The frontend logs should show successful connections.
