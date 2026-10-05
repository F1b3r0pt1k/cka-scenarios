Create a Pod named `app` in `persistence` using `alpine:3.21`. Keep the container running. Mount `db-pvc` at `/mnt/data`.

Wait until the Pod is Running. A PersistentVolume should now exist and the claim should be Bound.

Create `/mnt/data/test.db` containing `ok`.
