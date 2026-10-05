Create a Pod named `app` in `persistence` using `alpine:3.21`. Keep the container running. Mount `db-pvc` at `/mnt/data`.

Wait until the Pod is Running. A PersistentVolume should now exist and the claim should be Bound.

Create `/mnt/data/test.db` containing `ok`.

## Details

Pod `app` in `persistence`, image `alpine:3.21`, command that sleeps forever, claim `db-pvc` mounted at `/mnt/data`. Wait until the Pod is Running. The provisioner then creates a PersistentVolume and the claim becomes `Bound`.

Write `/mnt/data/test.db` containing `ok`.

## Finished when

The Pod is Ready, the claim is `Bound` to a PersistentVolume, and `test.db` contains `ok`.
