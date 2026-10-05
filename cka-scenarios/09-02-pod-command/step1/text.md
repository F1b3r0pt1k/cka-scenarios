In namespace `web`, create a Pod named `loop` from a YAML manifest. Use image `busybox:1.36` and this command:

`for i in 1 2 3 4 5 6 7 8 9 10; do echo "Welcome $i times"; done`

Wait until the Pod has finished and note its phase.
