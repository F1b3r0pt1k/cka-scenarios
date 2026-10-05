Create a Deployment named `webapp` with 3 replicas of `nginx:1.27-alpine`. Label the Pods `app=webapp`.

Create a Service named `webapp-service` of type `NodePort` that selects those Pods.

- Port name `web`: Service port 80, target port 80, node port 30080
- Port name `metrics`: Service port 9090, target port 9090

From the control plane, request `http://node01:30080` and confirm the nginx welcome page.
