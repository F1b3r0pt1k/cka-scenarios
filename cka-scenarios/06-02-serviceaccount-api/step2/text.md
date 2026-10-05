Create namespace `temporary`.

In `apps`, create a Pod named `operator` using `nginx:1.27-alpine`, container port 80, and the ServiceAccount `api-access`.

In `temporary`, create a Pod named `disposable` using `nginx:1.27-alpine`. Do not assign `api-access` to it.

From a shell in `operator`, call the API to list Pods in `temporary`. Write the HTTP status code to `/root/list-pods.status`.

From the same Pod, call the API to delete `disposable`. Write that HTTP status code to `/root/delete-pod.status`.

The ServiceAccount token and CA certificate are mounted in the Pod. `disposable` must still exist when you finish.
