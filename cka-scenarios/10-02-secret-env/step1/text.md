Create a Secret named `db-credentials` with the literal `db-password=passwd`.

Create a Pod named `backend` using `nginx:1.27-alpine`. Set the environment variable `DB_PASSWORD` from the Secret key `db-password`.

Open a shell and print the environment. `DB_PASSWORD` should be `passwd`.

## Details

Create the Secret from the literal `db-password=passwd`. `kubectl get secret db-credentials -o yaml` shows the value base64-encoded. The Pod must not hardcode the password. Use `valueFrom.secretKeyRef` with name `db-credentials` and key `db-password`, and name the environment variable `DB_PASSWORD`.

Image: `nginx:1.27-alpine`. Pod name: `backend`.

## Finished when

Inside the Ready Pod, `printenv DB_PASSWORD` prints `passwd`, and the env var references that Secret key.

Docs: https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-environment-variables
