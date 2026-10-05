Inspect `recorder`. Read its logs and open a shell if you need to confirm the missing path.

Change the Pod so the write to `/var/log/app/marker.txt` succeeds and the log prints `WRITE_OK`. The file should contain `started`.
