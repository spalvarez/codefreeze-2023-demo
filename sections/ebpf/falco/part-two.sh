#### shell into k3s first
# multipass shell k3s-leader

sudo mkdir -p /var/lib/rancher/audit
wget https://raw.githubusercontent.com/falcosecurity/evolution/master/examples/k8s_audit_config/audit-policy.yaml -P /var/lib/rancher/audit
FALCO_CLUSTER_IP=$(sudo  kubectl get service --namespace falco falco -o=jsonpath={.spec.clusterIP})
cat << EOF | sudo tee /var/lib/rancher/audit/webhook-config.yaml
apiVersion: v1
kind: Config
clusters:
- name: falco
  cluster:
    server: http://$FALCO_CLUSTER_IP:8765/k8s-audit
contexts:
- context:
    cluster: falco
    user: ""
  name: default-context
current-context: default-context
preferences: {}
users: []
EOF

