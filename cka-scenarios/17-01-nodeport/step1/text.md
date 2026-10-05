Create a Deployment named `webapp` with 3 replicas of `nginx:1.27-alpine`. Label the Pods `app=webapp`.

Create a Service named `webapp-service` of type `NodePort` that selects those Pods.

- Port name `web`: Service port 80, target port 80, node port 30080
- Port name `metrics`: Service port 9090, target port 9090

From the control plane, request `http://node01:30080` and confirm the nginx welcome page.

## Details

Deployment `webapp`, 3 replicas, image `nginx:1.27-alpine`, Pod label `app=webapp`. The Service selector must use that label.

Service `webapp-service`, type `NodePort`:

| name | port | targetPort | nodePort |
| --- | --- | --- | --- |
| web | 80 | 80 | 30080 |
| metrics | 9090 | 9090 | any free port is fine if you only pin `web` |

The nginx container listens on 80 only. Port 9090 is declared so you practice a multi-port Service. It does not have to answer.

From the control plane, `curl http://172.30.2.2:30080` should return the nginx welcome page. `node01` resolves to that address.

## Finished when

3 replicas are ready, the Service is `NodePort` with node port `30080` on the port named `web`, the metrics port is `9090`, three endpoints exist, and the curl returns the welcome page.

Docs: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
