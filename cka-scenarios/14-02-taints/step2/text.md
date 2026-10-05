Add a taint to the node recorded in `/root/pod-node.txt`.

- Key: `exclusive`
- Value: `yes`
- Effect: `NoExecute`

The Pod does not tolerate that taint, so it should disappear.

## Details

Taint the node named in `/root/pod-node.txt`:

`exclusive=yes:NoExecute`

`NoExecute` evicts Pods that do not already tolerate the taint. Tolerations cannot be added to a running Pod, so `web` is deleted by the eviction. Wait until `kubectl get pod web` says NotFound before you press Check.

## Finished when

The recorded node has taint `exclusive=yes:NoExecute` and Pod `web` is gone.

Docs: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
