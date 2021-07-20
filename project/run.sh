#!/usr/bin/env bash

set -eou pipefail

RUNNER_PLAYBOOK=${RUNNER_PLAYBOOK:-playbook.yml}

ansible-runner run -p "$RUNNER_PLAYBOOK" /runner

# Merge all kubeconfigs to /home/.kube/config
export KUBECONFIG
while IFS= read -r -d '' file
do
  if [ -f "$file" ];
  then
    # echo "KUBECONFIG file $file"
    KUBECONFIG="$KUBECONFIG:$file"
  fi
done <   <(find /home/runner/.kube -name 'config' -type f -print0)

kubectl config view --flatten > /home/runner/.kube/config