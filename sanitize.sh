#!/usr/bin/env bash

set -eou pipefail

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CONTAINER_CMD=${CONTAINER_CMD:-docker}
ANSIBLE_RUNNER_IMAGE=${ANSIBLE_RUNNER_IMAGE:-quay.io/kameshsampath/kubernetes-spices-ansible-runner:v0.1.2}
KUBECONFIG=${KUBECONFIG:-~/.kube/config}

export KUBECONFIG

KUBECONFIG="$KUBECONFIG:$CURRENT_DIR/.kube/config"

kubectl config view --flatten > "$CURRENT_DIR/.kube/config"

all_contexts=()
while IFS='' read -r line; do all_contexts+=("$line"); done < <(kubectl config get-contexts -o=name | sort -n)

echo "${all_contexts[*]}"

for c in "${all_contexts[@]}"
do
  echo "Checking context $c"
  out=$(kubectl --context="$c" --request-timeout='3s' cluster-info | grep -im1 'kubernetes control plane') 
  if [ -z "$out" ];
  then
	kubectx -d "$c"
  fi
done 