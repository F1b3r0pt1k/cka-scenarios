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
