Recreate `web` with a toleration that matches `exclusive=yes:NoExecute` using the `Equal` operator. It should run on the tainted node.

Then remove that taint from the node. The Pod should keep running, and the node should no longer have the `exclusive` taint.
