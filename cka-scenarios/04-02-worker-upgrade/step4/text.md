Make `node01` schedulable again.

Both nodes must be Ready, and neither node should be cordoned.

## Details

`kubectl uncordon node01` clears the unschedulable mark left by the drain. Both nodes must report Ready. Do not leave `controlplane` cordoned.

## Finished when

`controlplane` and `node01` are Ready and schedulable.
