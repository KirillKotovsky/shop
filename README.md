# Проектная работа в рамках обучающего курса Otus - "Devops практики и инструменты".
Данный проект демонстрирует развертывание микросервисного приложения https://github.com/GoogleCloudPlatform/microservices-demo в kubernetes </p>
Автоматизация развертывания kubernetes cluster выполнена при помощи terraform для yandex cloud </p>
В качестве менеджера установки приложения в kubernetes используются helm 3 </p>
Деплой приложения в кластер осуществляется c помощью gitlab ci </p>
Мониторинг приложения производится с использованием Prometheus, визуализация в Grafana </p>

Для запуска проекта необходимо: </p>
1. Подключиться к вашему яндекс облаку </p>
2. Выполнить код из директории terraform </p> 
>terraform apply </p>
3. Развернуть виртуальную машину с Gitlab CI </p>
4. Произвести интеграцию Gitlab CI c кластером kubernetes </p>
5. Передать код приложения из дериектории helmcharts_shop в репозиторий gitlab ci (деплой приложения в kubernetes будет выполнен автоматически) </p>
6. Доступ к приложению можно получить перейдя на external ip адресс. Найти ip адрес можно выполнив команду </p>
>kubctl get svc -n <namespace>  </p>
8. Запуск системы мониторинга производится из официального репозитория prometheus, для запуска необходимыми параметрами используйте values.yaml </p>

>helm repo add bitnami https://charts.bitnami.com/bitnami </p>
>helm install nginx  bitnami/nginx-ingress-controller </p>
>helm repo add prometheus-community https://prometheus-community.github.io/helm-charts </p>
>helm install --set name=grafana monitoring prometheus-community/kube-prometheus-stack -f values.yaml </p>
