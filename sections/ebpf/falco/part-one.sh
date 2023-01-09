helm repo add falcosecurity https://falcosecurity.github.io/charts

helm repo update

helm upgrade --install falco falcosecurity/falco --namespace falco \
--set falcosidekick.enabled=true \
--set falcosidekick.webui.enabled=true \
--set auditLog.enabled=true

kubectl get pods --namespace falco

