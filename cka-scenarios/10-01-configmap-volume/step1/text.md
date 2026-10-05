Create a ConfigMap named `app-config` from `/root/application.yaml`.

Create a Pod named `backend` using `nginx:1.27-alpine`. Mount the ConfigMap at `/etc/config`.

Open a shell in the Pod and read the file on that mount.
