Create namespace `temporary`.

In `apps`, create a Pod named `operator` using `nginx:1.27-alpine`, container port 80, and the ServiceAccount `api-access`.

In `temporary`, create a Pod named `disposable` using `nginx:1.27-alpine`. Do not assign `api-access` to it.

From a shell in `operator`, call the API to list Pods in `temporary`. Write the HTTP status code to `/root/list-pods.status`.

From the same Pod, call the API to delete `disposable`. Write that HTTP status code to `/root/delete-pod.status`.

The ServiceAccount token and CA certificate are mounted in the Pod. `disposable` must still exist when you finish.

## Details

The token is at `/var/run/secrets/kubernetes.io/serviceaccount/token` and the API CA is beside it. From inside the Pod the API is `https://kubernetes.default.svc`.

List Pods:

`GET /api/v1/namespaces/temporary/pods`

Delete the Pod:

`DELETE /api/v1/namespaces/temporary/pods/disposable`

Write only the numeric status code into each file. A successful list is `200`. A delete without that verb is `403`, and `disposable` must still be there.

`curl -k` skips TLS verification. Prefer `--cacert` with the mounted CA if you want the exam-style call.

## Finished when

- Pod `operator` in `apps` is Ready and uses ServiceAccount `api-access`.
- Pod `disposable` in `temporary` still exists.
- `/root/list-pods.status` is `200` and `/root/delete-pod.status` is `403`.

Docs: https://kubernetes.io/docs/tasks/run-application/access-api-from-pod/
