Replace the `nginx` Pod so its container has:

- `DB_URL=postgresql://mydb:5432`
- `DB_USERNAME=admin`

Open a shell in the container and list the working directory, then leave the shell. The Pod should still be running.

## Details

`env` on a running container cannot be patched. Delete the Pod and create it again in `web` with the same name, image, and port, plus:

- `DB_URL` = `postgresql://mydb:5432`
- `DB_USERNAME` = `admin`

`kubectl exec` into the container and run `ls -l` so you have seen the workdir. Leave the Pod running.

## Finished when

The Ready Pod has both environment variables set to those values.
