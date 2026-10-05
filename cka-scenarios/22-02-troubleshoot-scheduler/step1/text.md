Find the failing control plane component, repair it, and wait until its Pod is Ready.

Create a Deployment named `test-app` with 3 replicas of `nginx:1.27-alpine`. All three Pods must become Ready, which only happens after the scheduler is healthy.
