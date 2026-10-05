Inspect the rollout history, then roll the Deployment back to revision 1.

Running Pods must use `nginx:1.27.0-alpine` again.

## Details

Roll back to revision 1, not to the previous image by editing the manifest yourself. `kubectl rollout undo deployment/nginx --to-revision=1` is the operation this step is practicing. Wait until the rollout completes.

## Finished when

The Deployment template image is `nginx:1.27.0-alpine` and the rollout is complete.
