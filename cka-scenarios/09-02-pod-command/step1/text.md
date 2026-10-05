In namespace `web`, create a Pod named `loop` from a YAML manifest. Use image `busybox:1.36` and this command:

`for i in 1 2 3 4 5 6 7 8 9 10; do echo "Welcome $i times"; done`

Wait until the Pod has finished and note its phase.

## Details

Namespace `web` already exists. A command that ends moves the Pod to `Succeeded`. Use a shell so the `for` loop runs inside the container, for example command `sh` and args `-c` plus the loop. Image `busybox:1.36`.

The loop body is `echo "Welcome $i times"` for i from 1 through 10.

## Finished when

Pod `web/loop` exists and its phase is `Succeeded`.

Docs: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/
