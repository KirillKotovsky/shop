# shop
otus project
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install --set name=grafana monitoring prometheus-community/kube-prometheus-stack -f values.yaml
