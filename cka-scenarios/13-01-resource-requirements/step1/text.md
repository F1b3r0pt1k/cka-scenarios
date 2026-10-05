Create a Pod named `hello` from a YAML manifest.

- Image: `nginx:1.27-alpine`
- Container port: 3000
- An `emptyDir` volume mounted at `/var/log`

Requests:

- CPU `100m`
- Memory `500Mi`
- Ephemeral storage `1Gi`

Limits:

- Memory `500Mi`
- Ephemeral storage `2Gi`

Do not set a CPU limit. Wait until the Pod is running and note which node it landed on.

## Details

Pod name `hello`, image `nginx:1.27-alpine`, `containerPort: 3000`. Add an `emptyDir` volume and mount it at `/var/log`.

Requests: cpu `100m`, memory `500Mi`, ephemeral-storage `1Gi`.
Limits: memory `500Mi`, ephemeral-storage `2Gi`.
Do not set a CPU limit. The check fails if `limits.cpu` is present.

The Pod schedules onto `node01` because the control plane is tainted. `kubectl get pod hello -o wide` shows the node.

## Finished when

The Ready Pod has exactly those requests and limits and a mount at `/var/log`.

Docs: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
