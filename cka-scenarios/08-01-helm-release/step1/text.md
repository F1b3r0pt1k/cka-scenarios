Add that repository under the name `podinfo` and update the local chart index.

Install chart `podinfo/podinfo` as a release named `frontend` in the namespace `monitoring`. Create the namespace as part of the install.

The release should appear in the list of installed releases for that namespace.

## Details

Helm is on the PATH. Repository URL: `https://stefanprodan.github.io/podinfo`. Add it under the name `podinfo`, then update the index.

Install chart `podinfo/podinfo` as release `frontend` in namespace `monitoring`. Create the namespace in the same install. The chart Service is named `frontend-podinfo` and listens on port 9898.

## Finished when

`helm status frontend -n monitoring` succeeds and the namespace has at least one Service.

Docs: https://helm.sh/docs/intro/using_helm/
