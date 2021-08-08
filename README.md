# Проектная работа в рамках обучающего курса Otus - "Devops практики и инструменты".
Данный проект демонстрирует развертывание микросервисного приложения https://github.com/GoogleCloudPlatform/microservices-demo в kubernetes <p>
Автоматизация развертывания kubernetes cluster выполнена при помощи terraform для yandex cloud <p>
В качестве менеджера установки приложения в kubernetes используются helm 3 <p>
Деплой приложения в кластер осуществляется c помощью gitlab ci <p>
Мониторинг приложения производится с использованием Istio, Prometheus, визуализация в Kiali, Grafana <p>

Для запуска проекта необходимо: <p>
1. Подключиться к вашему яндекс облаку <p>
2. Выполнить код из директории terraform для создания кластера k8s <p> 
```sh 
terraform apply 
```
3. Развернуть виртуальную машину с Gitlab CI, в данном проекте использовали готовое решение от яндекс с предустановленным Gitlab<p>
4. Произвести интеграцию Gitlab CI c кластером kubernetes (в текущем проекте - операции - Kubernetes, подключиться к кластеру ):<p>
   
   4.1 Вывести адрес для подключения
 
 ```sh kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}' ```

   4.2  ```sh kubectl get secrets```  Вывод секрета использовать в следующей команде, подставив свое значение токена для получения сертификата

   4.3 ```sh kubectl get secret default-token-9qdr9 -o jsonpath="{['data']['ca\.crt']}" | base64 --decode  ```

   4.4 Применить настройки из файла в репозитории ```sh kubectl apply -f gitlab_k8s_integation/gitlab-admin-service-account.yaml ```
    
   4.5 Получить токе ```sh kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab | awk '{print $1}') ```
 
   4.6 На вкладке Aplication довать gitlab-runner в кластер </p>
   
5. Установить Istio согласно [инструкции]( https://istio.io/latest/docs/setup/getting-started/). Выполнить ```sh kubectl apply -f ./mesh_monitoring  ``` 

6. Передать код приложения из дериектории helmshop в репозиторий gitlab ci <p>
   6.1 Запустить pipline в ручном режиме, на выбранном окружении, название окружения соответствует названию namespace, в котором он запустится <p>
     
7. Доступ к приложению можно получить перейдя на external ip адресс. Найти ip адрес можно выполнив команду <p>
 
```sh
kubctl get svc -n istio-system  
```

