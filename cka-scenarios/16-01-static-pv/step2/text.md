Delete the `nginx` Pod and create it again from the same manifest, still mounting `logs-pvc` at `/var/log/nginx`.

The file `my-nginx.log` should still be there.
