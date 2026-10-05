echo "Preparing the two-node lab..."
while [ ! -f /tmp/setup-done ]; do sleep 1; done

alias k=kubectl
export do="--dry-run=client -o yaml"
export now="--force --grace-period=0"
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion bash) || true
  complete -o default -F __start_kubectl k || true
fi
echo "Lab environment is ready. k is kubectl. Continue with the task in this shell."
