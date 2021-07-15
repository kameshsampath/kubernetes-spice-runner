# Kubernetes Spice Runner

The directory structure follows the [Ansible Runner Directory](https://ansible-runner.readthedocs.io/en/stable/intro.html#runner-input-directory-hierarchy) structure.

The ansible parameters for the playbooks is detailed in [Kubernetes Spices Collection](https://kameshsampath.github.io/kubernetes_spices/ansible-kubernetes-spices/index.html).

All the variables that you need pass to the Ansible playbooks can be specified in `$PROJECT_HOME/hack/extravars`. Make a copy of `$PROJECT_HOME/hack/env/extravars.example` to `$PROJECT_HOME/hack/env/extravars`, and set the values as needed for the components that you wish to install from Kubernetes spices. e.g., If you wish to install Gloo Edge then your extra vars will look like

```yaml
kind_home_dir: /home/runner/.kube
cluster_name: gloo-edge-demo
kind_create: true
deploy_gloo_edge: true
# set gloo license key 
gloo_license_key:  my gloo license key
```

`kind_home_dir` ensures that the generated files for cluster are saved to `$PROJECT_HOME/hack/.kube/<cluster-name>`.

Typically, there will be two files:

* The `kubeconfig` file for the cluster
* The KinD configuration file

If [fzf](https://github.com/junegunn/fzf) is available as part of the system, the script will list the possible playbooks from the `$PROJECT_HOME/hack/project` directory.

Once the cluster is created it also sets and exports the `KUBECONFIG` to the local `$PROJECT_HOME/.kube/config`
