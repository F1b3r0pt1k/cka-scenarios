Delete the `nginx` Pod and create it again from the same manifest, still mounting `logs-pvc` at `/var/log/nginx`.

The file `my-nginx.log` should still be there.

## Details

Delete only the Pod, not the claim or the PV. Create the same Pod again from the same manifest so it mounts `logs-pvc` at `/var/log/nginx`. The file was written on the host path, so it is still there after the new Pod starts.

## Finished when

The new Pod is Ready and `my-nginx.log` still contains `hello from nginx`.
