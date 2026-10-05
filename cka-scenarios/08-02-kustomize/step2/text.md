Change `dir` in the ConfigMap manifest to `/etc/logs/traffic-log.txt` and apply that change.

Delete both objects with a single declarative command against the directory. Both the Pod and the ConfigMap should be gone. Leave the updated manifest on disk.

## Details

Edit the file on disk, apply that file, then delete the directory in one declarative command. The check reads `/root/manifests/configmap.yaml` after the objects are gone, so the new path has to be saved in the file.

## Finished when

- Pod `nginx` and ConfigMap `logs-config` are gone.
- The manifest still contains `/etc/logs/traffic-log.txt`.
