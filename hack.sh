#!/usr/bin/env bash

set -eou pipefail

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CONTAINER_CMD=${CONTAINER_CMD:-docker}
ANSIBLE_RUNNER_IMAGE=${ANSIBLE_RUNNER_IMAGE:-quay.io/kameshsampath/kubernetes-spices-ansible-runner:v0.1.2}
KUBECONFIG=${KUBECONFIG:-~/.kube/config}
RUNNER_PLAYBOOK=playbook.yml

# uncomment this force pull
# $CONTAINER_CMD pull "$ANSIBLE_RUNNER_IMAGE" &> /dev/null

export KUBECONFIG

mkdir -p "$CURRENT_DIR/.kube"

pushd "$CURRENT_DIR/project" &>/dev/null

if command -v fzf &>/dev/null; then
  RUNNER_PLAYBOOK=$(fzf +i -q "playbook | cloud")
  pushd -1 &>/dev/null
fi

kubectl config view --flatten > "$CURRENT_DIR/.kube/config"

$CONTAINER_CMD run --name="kubernetes-spice-ansible-runner" \
  -it --rm --net=host \
  -v "$CURRENT_DIR/project:/runner/project:z" \
  -v "$CURRENT_DIR/inventory:/runner/inventory:z" \
  -v "$CURRENT_DIR/env:/runner/env:z" \
  -v "$CURRENT_DIR/.kube:/home/runner/.kube:z" \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -e "RUNNER_PLAYBOOK=$RUNNER_PLAYBOOK" \
  "$ANSIBLE_RUNNER_IMAGE" /runner/project/run.sh

if [ -f "$CURRENT_DIR/.kube/config" ];
then
  chmod 0644 "$CURRENT_DIR/.kube/config"
fi

KUBECONFIG="$KUBECONFIG:$CURRENT_DIR/.kube/config"
