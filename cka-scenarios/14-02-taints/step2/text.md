Add a taint to the node recorded in `/root/pod-node.txt`.

- Key: `exclusive`
- Value: `yes`
- Effect: `NoExecute`

The Pod does not tolerate that taint, so it should disappear.
