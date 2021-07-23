# shop

helm repo add bitnami https://charts.bitnami.com/bitnami </p>
helm install nginx  bitnami/nginx-ingress-controller </p>
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts </p>
helm install --set name=grafana monitoring prometheus-community/kube-prometheus-stack -f values.yaml </p>
