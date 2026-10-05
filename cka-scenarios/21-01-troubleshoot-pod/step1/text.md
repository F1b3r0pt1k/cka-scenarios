Inspect `recorder`. Read its logs and open a shell if you need to confirm the missing path.

Change the Pod so the write to `/var/log/app/marker.txt` succeeds and the log prints `WRITE_OK`. The file should contain `started`.

## Details

Pod `recorder` is already applied from `/root/recorder.yaml`. The container command writes `/var/log/app/marker.txt`, echoes `WRITE_OK` or `WRITE_FAILED`, then sleeps. The directory does not exist, so the log says `WRITE_FAILED`. You can exec in and confirm `/var/log/app` is missing.

A directory you create with `mkdir` inside the container is not in the manifest. Replace the Pod so the path is writable from the spec. An `emptyDir` mounted at `/var/log/app` is enough. Keep the same command so the log still prints `WRITE_OK` and the file contains `started`.

## Finished when

The Pod is Ready, `/var/log/app/marker.txt` contains `started`, and the logs contain `WRITE_OK`.

Docs: https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/
