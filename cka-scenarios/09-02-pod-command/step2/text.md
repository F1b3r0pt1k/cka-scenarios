Replace `loop` so the container runs an endless loop that prints the current date on each iteration.

The Pod should stay Running.

## Details

Replace the Pod. The new command must print the date on every pass and must not exit. `while true; do date; sleep 2; done` satisfies the check. The Pod should become Ready and stay that way.

## Finished when

Pod `web/loop` is Ready and its command or args contain `date` and a loop (`while` or `sleep`).
