Apply `/root/limitrange.yaml`.

Create Pod `pod-without-requests` in `limited` with no resource fields. Inspect it and see which CPU values were filled in.

Try to create Pod `pod-too-much-cpu` in `limited` with a CPU request of `400m` and a CPU limit of `1500m`. It should be rejected.

Create Pod `pod-within-range` in `limited` with a CPU request of `350m` and a CPU limit of `400m`. It should be running.
