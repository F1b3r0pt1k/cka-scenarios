Uninstall the `frontend` release from the `monitoring` namespace.

The release must not remain installed.

## Details

Uninstall release `frontend` from namespace `monitoring`. Leaving the namespace behind is fine. The release itself must be gone.

## Finished when

`helm status frontend -n monitoring` fails because the release is not installed.
