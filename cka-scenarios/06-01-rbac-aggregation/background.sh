#!/bin/bash
set -euo pipefail
for _ in $(seq 1 60); do
  kubectl get nodes >/dev/null 2>&1 && break
  sleep 2
done
kubectl wait --for=condition=Ready nodes --all --timeout=240s
mkdir -p /root/certs
openssl genrsa -out /root/certs/devuser.key 2048
openssl req -new -key /root/certs/devuser.key -out /root/certs/devuser.csr -subj "/CN=devuser/O=developers"
openssl x509 -req -in /root/certs/devuser.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /root/certs/devuser.crt -days 365
cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
kubectl config set-credentials devuser --client-certificate=/root/certs/devuser.crt --client-key=/root/certs/devuser.key
kubectl config set-context devuser-context --cluster="$cluster" --user=devuser
kubectl create namespace development --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace production --dry-run=client -o yaml | kubectl apply -f -
touch /tmp/setup-done
