Drain `node01` so it will not accept new Pods and so existing workload Pods are evicted. Leave DaemonSet Pods running, and allow removal of Pods that are not managed by a controller. If drain stops on emptyDir data, allow that data to be deleted.

`node01` should stay unschedulable at the end of this step.
