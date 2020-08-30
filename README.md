# Kubernetes Demo Project Template

The template project for all Kubernetes demos using minikube.

The project provides basic cluster setup for minikube. To configure the cluster with extra components
you can use the Ansible roles:

- [kameshsampath.k8s_app_spices](https://github.com/kameshsampath/ansible-role-kubernetes-spices)

If you are looking for provisioing for OpenShift, then use [OpenShift Spice Runner](https://github.com/kameshsampath/openshift-spice-runner)

## Pre-requsites

- [Docker](https://docs.docker.com/get-docker/) or [podman](https://podman.io/)
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)

__NOTE__: Based on your configuration you might need other tools like:

- [Tekton CLI](https://github.com/tektoncd/cli)
- [Knative Client](https://github.com/knative/client)
- [Argo CD CLI](https://argoproj.github.io/argo-cd/cli_installation/)

## Configuration

All configuration are done using $PROJECT_HOME/.cluster/.env:

| Variable | Description | Default
| -------- | ----------- | -------
| *KUBECONFIG* | The Kubeconfig file to be used with minikube  | /runner/.kube/config
| *RUNNER_PLAYBOOK* | The cluster configuration playbook, this file will be searched in $REPO_HOME/project folder. Just filename is suffice. | playbook.yml |
| *PROFILE_NAME* | The minikube profile name | my-demos |
| *MEMORY* | The memory to allocate for minikube |8192 |
| *CPUS*| The cpus to allocate for minikube | 5 |

__NOTE__:

- The *runner* is the directory that is mounted within the Ansible Runner, for local use point the KUBECONFIG to $PWD/.kube/config

## Make Targets

The [makefile](./cluster/Makefile) provides the following targets:

- *provision* - Creates a minikube cluster with profile name
- *configure* - Creates a minikube cluster with profile name
- *unprovision* - Deletes the created minikube cluster

### Examples

Copy the `$REPO_HOME/cluster/examples/knative.yml` to `$REPO_HOME/cluster/project/playbook.yml` and run:

To provision a cluster with Knative run:

```shell
cd $REPO_HOME/cluster
make provision && make configure
```

Copy the `$REPO_HOME/cluster/examples/knative_tekto_argo.yml` to `$REPO_HOME/cluster/project/playbook.yml` and run:

To provision a cluster with Tekton, Knative and Argo CD run:

```shell
cd $REPO_HOME/cluster
make provision && make configure
```

## Tutorials

Based on the installation the following Tutorials might be of of help:

- [Knative Tutorial](https://dn.dev/knative-tutorial)
- [Tekton Tutorial](https://dn.dev/tekton-tutorial)
