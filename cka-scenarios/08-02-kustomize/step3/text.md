Create `/root/kustomize/pod.yaml` for a Pod named `nginx` with image `nginx:1.27-alpine` and no namespace.

Add a Kustomize configuration that sets namespace `t012` on that Pod.

Render the result to `/root/rendered.yaml`. Do not apply it.

## Details

`/root/kustomize/kustomization.yaml` should set `namespace: t012` and list `pod.yaml`. `kubectl kustomize /root/kustomize > /root/rendered.yaml` renders without applying. The rendered Pod spec must still say `nginx:1.27-alpine`.

## Finished when

`/root/rendered.yaml` contains `namespace: t012`, `name: nginx`, and `nginx:1.27-alpine`.

Docs: https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/
