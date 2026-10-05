Create a Pod named `share` with two containers, both using `alpine:3.21`. Name them `first` and `second`. Give each a command that sleeps forever.

Add an `emptyDir` volume. Mount it at `/etc/a` in `first` and at `/etc/b` in `second`.

In `first`, create the directory `/etc/a/data` and the file `/etc/a/data/hello.txt` containing `Hello World`.

In `second`, read `/etc/b/data/hello.txt`.
