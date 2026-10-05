Apply `/root/limitrange.yaml`.

Create Pod `pod-without-requests` in `limited` with no resource fields. Inspect it and see which CPU values were filled in.

Try to create Pod `pod-too-much-cpu` in `limited` with a CPU request of `400m` and a CPU limit of `1500m`. It should be rejected.

Create Pod `pod-within-range` in `limited` with a CPU request of `350m` and a CPU limit of `400m`. It should be running.

## Details

Apply `/root/limitrange.yaml` before creating Pods. It creates namespace `limited` and LimitRange `cpu-limit-range`:

- min cpu `200m`
- max cpu `500m`
- default request `200m`
- default limit `500m`

Image for every Pod: `nginx:1.27-alpine`.

`pod-without-requests` has no `resources` block. Admission fills in the defaults.

`pod-too-much-cpu` requests `400m` and limits `1500m`. `1500m` is above the max, so the API server rejects it. It must not exist afterward.

`pod-within-range` requests `350m` and limits `400m`. Both values sit inside the range, so the Pod runs.

## Finished when

- The Pod with no resources shows cpu request `200m` and limit `500m`.
- `pod-too-much-cpu` does not exist.
- `pod-within-range` is Ready with request `350m` and limit `400m`.

Docs: https://kubernetes.io/docs/concepts/policy/limit-range/
