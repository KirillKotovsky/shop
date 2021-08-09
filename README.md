# Проектная работа в рамках обучающего курса Otus -</p> "Devops практики и инструменты".
Данный проект демонстрирует развертывание микросервисного приложения https://github.com/GoogleCloudPlatform/microservices-demo в kubernetes <p>
Автоматизация развертывания kubernetes cluster выполнена при помощи terraform для yandex cloud <p>
В качестве менеджера установки приложения в kubernetes используются helm 3 <p>
Деплой приложения в кластер осуществляется c помощью gitlab ci <p>
Мониторинг приложения производится с использованием Istio, Prometheus, визуализация в Kiali, Grafana <p>

Для запуска проекта необходимо: <p>
1. Подключение к Yandex Cloud<p>
   Подключитесь к аккаунту ндекс облака. 

2. Создание класстера и группы ресурсов. <p>
   Перейти в каталог terraform предвариельно заполнить секцию provider и resource в main.tf.
   Переименовать terraform.tfvars.example в terraform.tfvars и заполнить переменные согласно вашим параметрам яндекс облака.
   Выполните terraform apply 
   В процессе должен будет создаться класстер и группа ресурсов.

3. Рарзвертывание GitLab <p>
   Развернуть виртуальную машину с Gitlab CI, используя кода в директории terraform (см. terraform/gitlab/readme )<p>

4. Интеграция с GitLab <p>
   Произвести интеграцию Gitlab CI c кластером kubernetes (в текущем проекте - операции - Kubernetes, подключиться к кластеру ):
   
   4.1 Вывести адрес для подключения
 
 ``` kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}' ```

   4.2  ``` kubectl get secrets```  Вывод секрета использовать в следующей команде, подставив свое значение токена для получения сертификата

   4.3 ``` kubectl get secret default-token-9qdr9 -o jsonpath="{['data']['ca\.crt']}" | base64 --decode  ```

   4.4 Применить настройки из файла в репозитории ``` kubectl apply -f gitlab_k8s_integation/gitlab-admin-service-account.yaml ```
    
   4.5 Получить токе ``kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab | awk '{print $1}') ``
 
   4.6 На вкладке Aplication добавить gitlab-runner в кластер </p>

5. Развертывание Istio <p>
   Установить Istio согласно [инструкции]( https://istio.io/latest/docs/setup/getting-started/). 
   Выполнить ```sh kubectl apply -f ./mesh_monitoring  ```

6. Установка NGINX Controller <p>
   Установить nginx выполнив команду ``helm install nginx nginx-ingress-controller -n istio-system``

7. Развертывание приложения Shop <p>
   Перейти в hemcharts_shop и выполнить команду helm install shop ./shop/ -f value.yml

8. GitLab CI SHOP<p>
   
   Передать код приложения из дериектории helmshop в репозиторий gitlab ci 
   
   В разделе Operations - k8s - Applications установите install Gitlab Runners для установки RUNNDER
   
   Запустить pipline в ручном режиме, на выбранном окружении, название окружения соответствует названию namespace, в котором он запустится

   Проверить результат можно перейдя на http://external-ip адресс балансировщика istio-ingressgateway. Найти ip адрес можно выполнив команду kubctl get svc -n istio-system  
9. Развертывание системы мониторинга kiali, protheus, grafana <p>
   Перейти в istiorelease и выполнить kubeclt apply -f .
   kubectl get pods -n istio-system 
10. Развертывание EFK
    Перейти в efk, выполнить helm upgrade --install efk -n efk .
11. Проверка работоспособности <p>
    Для доступа к системам мониторинга внести записи в hosts вашей операционной системы 

   <external-ip nginx> prometheus
   <external-ip nginx> grafana
   <external-ip nginx> kiali
   <external-ip nginx> kibana
   <external-ip nginx> shop

   Перейти в браузере, к примеру http://shop/
