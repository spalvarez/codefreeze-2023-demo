kubectl --namespace=falco port-forward svc/falco-falcosidekick-ui 2802

# Use this to trigger an alert
# kubectl create configmap aws-creds --from-literal aws_access_key_id=AKES20LNOA
