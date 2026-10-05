Create a Secret named `db-credentials` with the literal `db-password=passwd`.

Create a Pod named `backend` using `nginx:1.27-alpine`. Set the environment variable `DB_PASSWORD` from the Secret key `db-password`.

Open a shell and print the environment. `DB_PASSWORD` should be `passwd`.
