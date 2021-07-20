# Kubernetes Spice Runner

The directory structure follows the [Ansible Runner Directory](https://ansible-runner.readthedocs.io/en/stable/intro.html#runner-input-directory-hierarchy) structure.

The ansible parameters for the playbooks is detailed in [Kubernetes Spices Collection](https://kameshsampath.github.io/kubernetes_spices/ansible-kubernetes-spices/index.html).

Check [how to run the playbooks](https://kameshsampath.github.io/kubernetes_spices/ansible-kubernetes-spices/running.html)

## Populate kubectx.yml

The [`inventory/kubectx.yml`](./inventory/kubectx.yml) accepts a list that maps to the kube contexts to which you wish to apply the kube components.

To get list of available kube contexts run:

```shell
kubectl config get-contexts -o name
```

Select the kube contexts to which you wish to apply the config and build the kubectx.yml like:

```yaml
plugin: kameshsampath.kubernetes_spices.kubectx
use_contexts:
   - name: cloud-1
   - name: cloud-2
```

Now you can run `./hack.sh` to setup your Kube clusters.

__IMPORTANT__: When ever you delete the context, make sure to set `current_context` otherwise the kubectx inventory will fail to build the inventory. Run `kubectl config use-context` to set a different context as `current_context`

To clean up the stake context use `./sanitize.sh`.

You can find lot of example playbooks [here](https://github.com/kameshsampath/kubernetes_spices/tree/main/examples).
