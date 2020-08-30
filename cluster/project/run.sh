#!/usr/bin/env bash

set -e 

ansible-galaxy role install -r /runner/project/requirements.yml

ansible-galaxy collection install -r /runner/project/requirements.yml

ansible-runner run -p "$RUNNER_PLAYBOOK" /runner
