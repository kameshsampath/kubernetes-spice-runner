ENV_FILE := .env
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
CURRENT_DIR = $(shell pwd)
ANSIBLE_RUNNER_IMAGE := quay.io/kameshsampath/ansible-runner-extras

# For local provision use the value relative
KUBECONFIG := $(CURRENT_DIR)/.kube/config

.PHONY: kubeconfig_dir
kubeconfig_dir:
	@mkdir -p "$(CURRENT_DIR)/.kube"

.PHONY: provision
provision:	kubeconfig_dir
	@minikube start -p "$(PROFILE_NAME)" \
  --embed-certs \
  --memory="$(MEMORY)" \
  --cpus="$(CPUS)" \
  --disk-size=50g \
  --insecure-registry='10.0.0.0/24'
	@minikube profile "$(PROFILE_NAME)"
	@minikube addons enable registry
	@minikube addons enable registry

.PHONY: configure
configure:
	@docker run -it  \
   -v $(CURRENT_DIR)/project:/runner/project:z \
   -v $(CURRENT_DIR)/inventory:/runner/inventory:z \
   -v $(CURRENT_DIR)/env:/runner/env:z \
   -v $(CURRENT_DIR)/.kube:/runner/.kube:z \
   -e MINIKUBE_IP=$(shell minikube -p $(PROFILE_NAME) ip) \
   --env-file $(CURRENT_DIR)/.env \
   $(ANSIBLE_RUNNER_IMAGE) /runner/project/run.sh

.PHONY: unprovision
unprovision:
	@minikube -p $(PROFILE_NAME) delete