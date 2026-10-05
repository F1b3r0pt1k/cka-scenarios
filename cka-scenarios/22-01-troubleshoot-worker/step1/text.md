Identify everything that stops `node01` from accepting Pods and fix it.

`node01` must be Ready and schedulable.

Create a Pod named `node-check` using `nginx:1.27-alpine` and pin it to `node01` with `nodeName`. It must be Running.
