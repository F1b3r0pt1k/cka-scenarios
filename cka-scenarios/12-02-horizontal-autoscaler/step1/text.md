Create a Deployment named `nginx` with 1 replica and image `nginx:1.27-alpine`.

On the container set:

- CPU request: `100m`
- Memory request: `128Mi`
- Memory limit: `128Mi`

Create an `autoscaling/v2` HorizontalPodAutoscaler named `nginx-hpa` that targets that Deployment. Minimum replicas 3, maximum replicas 8. Scale on average CPU utilization of 75% and average memory utilization of 60%.

Give the HPA a moment to read metrics, then describe it and note the current replica count.
