Find the failing control plane component, repair it, and wait until its Pod is Ready.

Create a Deployment named `test-app` with 3 replicas of `nginx:1.27-alpine`. All three Pods must become Ready, which only happens after the scheduler is healthy.

## Details

New Pods stay Pending because the scheduler static Pod is not running a real image. Static Pod manifests are in `/etc/kubernetes/manifests` on the control plane. Compare `kube-scheduler.yaml` with `kube-scheduler.yaml.backup` in that directory, or with the image tag on `kube-apiserver.yaml`.

The broken tag is `v1.99.0`. Restore the original image line. Kubelet recreates the static Pod when the file changes. Wait until `kube-scheduler` in `kube-system` is Ready. Do not delete the manifest.

Then create Deployment `test-app`, image `nginx:1.27-alpine`, 3 replicas. They stay Pending until the scheduler is back.

## Finished when

The scheduler Pod is Ready and is not using `v1.99.0`, and `test-app` has 3 ready replicas.

Docs: https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/#inspect-kubernetes-node-objects
