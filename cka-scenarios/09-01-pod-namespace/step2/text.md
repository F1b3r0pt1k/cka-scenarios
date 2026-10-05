Replace the `nginx` Pod so its container has:

- `DB_URL=postgresql://mydb:5432`
- `DB_USERNAME=admin`

Open a shell in the container and list the working directory, then leave the shell. The Pod should still be running.
