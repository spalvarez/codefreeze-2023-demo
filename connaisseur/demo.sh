helm install connaisseur helm --atomic --create-namespace --namespace connaisseur

kubectl run demo --image=docker.io/securesystemsengineering/testimage:unsigned

kubectl run demo --image=docker.io/securesystemsengineering/testimage:signed

kubectl delete pod demo