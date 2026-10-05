Create a Pod named `share` with two containers, both using `alpine:3.21`. Name them `first` and `second`. Give each a command that sleeps forever.

Add an `emptyDir` volume. Mount it at `/etc/a` in `first` and at `/etc/b` in `second`.

In `first`, create the directory `/etc/a/data` and the file `/etc/a/data/hello.txt` containing `Hello World`.

In `second`, read `/etc/b/data/hello.txt`.

## Details

Pod name `share`. Containers `first` and `second`, both `alpine:3.21`, both running a command that does not exit (`sleep infinity` works).

One `emptyDir` volume, mounted at `/etc/a` on `first` and `/etc/b` on `second`. The two mount names must be the same volume.

In `first`, create directory `/etc/a/data` and file `hello.txt` whose contents include `Hello World`. Read `/etc/b/data/hello.txt` from `second`.

## Finished when

The check execs into `second` and finds `Hello World` in that file.

Docs: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir
