Create a Deployment named `nginx` with 1 replica and image `nginx:1.27-alpine`.

On the container set:

- CPU request: `100m`
- Memory request: `128Mi`
- Memory limit: `128Mi`

Create an `autoscaling/v2` HorizontalPodAutoscaler named `nginx-hpa` that targets that Deployment. Minimum replicas 3, maximum replicas 8. Scale on average CPU utilization of 75% and average memory utilization of 60%.

Give the HPA a moment to read metrics, then describe it and note the current replica count.

## Details

Metrics Server is already running. The Deployment must declare the resource requests the HPA metrics use, or utilization stays unknown.

Container resources:

- requests: cpu `100m`, memory `128Mi`
- limits: memory `128Mi`

HPA `nginx-hpa`, API `autoscaling/v2`, `scaleTargetRef` kind Deployment name `nginx`. `minReplicas: 3`, `maxReplicas: 8`. Two resource metrics:

- cpu, Utilization, `averageUtilization: 75`
- memory, Utilization, `averageUtilization: 60`

`kubectl describe hpa nginx-hpa` shows targets once metrics arrive. The replica count may move toward the minimum. The check validates the spec, not a particular replica count.

## Finished when

The Deployment has those resource values and the HPA spec matches the min, max, target, and both utilization thresholds.

Docs: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
