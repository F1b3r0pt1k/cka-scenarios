Recreate `web` with a toleration that matches `exclusive=yes:NoExecute` using the `Equal` operator. It should run on the tainted node.

Then remove that taint from the node. The Pod should keep running, and the node should no longer have the `exclusive` taint.

## Details

Create `web` again with this toleration:

- key `exclusive`
- operator `Equal`
- value `yes`
- effect `NoExecute`

It should be scheduled back onto the tainted node, because the control plane has a different taint and this worker is the only other node.

Then remove the taint. The minus is part of the taint syntax and goes after the effect. The running Pod stays. Removing a taint does not reschedule anything.

## Finished when

Pod `web` is Ready on the node recorded in `/root/pod-node.txt`, it has the matching toleration, and that node no longer has `exclusive=yes:NoExecute`.
