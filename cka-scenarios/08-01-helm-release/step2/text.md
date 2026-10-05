The chart creates a Service named `frontend-podinfo` in `monitoring`. It listens on port 9898.

Port-forward local port 8080 to that Service port and open the application. Stop the port-forward when the page loads.

The check confirms the Service has ready endpoints. You do not need to leave the port-forward running.

## Details

Port-forward from the control plane:

local port `8080` to Service port `9898` in namespace `monitoring`.

Open the forwarded port from the exam desktop browser, or curl it from another terminal. Stop the port-forward when you are done. The check does not require the port-forward to keep running. It waits until a Service in `monitoring` has an endpoint address.

## Finished when

A Service in `monitoring` has a ready endpoint.
