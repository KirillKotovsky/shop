# Devops practices and tools (Graduation work)
This project demonstrates the deployment of a micro service application https://github.com/GoogleCloudPlatform/microservices-demo in kubernetes <p>
Kubernetes cluster deployment automation is performed using terraform for yandex cloud <p>
Helm 3 is used as a configuration management tool for Kubernetes <p>
CI\CD process based on Gitlab<p>
Application monitoring is performed using Istio, Prometheus, visualization in Kiali, Grafana <p>

To start the project, you need: <p>
1. Connect to Yandex Cloud account<p> 

2. Create cluster and group resourses <p>
Go to the terraform directory and pre-fill in the provider and resource section in main.tf .
Rename terraform.tfvars.example to terraform.tfvars and fill in the variables according to your yandex cloud parameters.
Execute "terraform apply`
In the process, a cluster and a resource group will have to be created.

3. Deploying GitLab <p>
   Deploy a virtual machine with Gitlab CI using the code in the terraform directory (see terraform/gitlab/readme)<p>

4. Integration with GitLab <p>
   Integrate Gitlab CI with the kubernetes cluster (in the current project - operations - Kubernetes, connect to the cluster):
   
   4.1 Use the address output in the following command
 
 ``` kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}' ```

   4.2  ``` kubectl get secrets```  Use the secret output in the following command, substituting your token value to get the certificate

   4.3 ``` kubectl get secret default-token-9qdr9 -o jsonpath="{['data']['ca\.crt']}" | base64 --decode  ```

   4.4 Apply settings from a file in the repository ``` kubectl apply -f gitlab_k8s_integation/gitlab-admin-service-account.yaml ```
    
   4.5 Get token ``kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep gitlab | awk '{print $1}') ``
 
   4.6 On the Application tab, add gitlab-runner to the cluster </p>

5. Deployment Istio <p>
   Install Istio according to [instructions]( https://istio.io/latest/docs/setup/getting-started/). 
   Run the following command ``` kubectl apply -f ./mesh_monitoring  ```

6. Install NGINX Controller <p>
   Install nginx by running the command ``helm install nginx nginx-ingress-controller -n istio-system``

7. Deployment the Shop application <p>
   Go to helmcharts_shop and run the command ``helm install shop ./shop/ -f value.yml``

8. GitLab CI SHOP<p>
   
   Transfer the application code from the helmshop directory to the gitlab ci repository 
   
   In section ``Operations - k8s - Applications`` set ``install Gitlab Runners`` for install RUNNER 
   
  Start the pipeline in manual mode, on the selected environment, the name of the environment corresponds to the name of the namespace in which it will start

   You can check the result by going to the istio-ingressgateway address http://external-ip. You can find the ip address by running the command ``kubctl get svc -n istio-system `` 
9. Deployment monitoring system (kiali, prometheus, grafana) <p>
   Go to ``istiorelease`` and run ``kubeclt apply -f .``
   kubectl get pods -n istio-system 
10. Deployment EFK <p>
    Go to ``efk``, run ``helm upgrade --install efk -n efk .``
11. Check the result <p>
    To access monitoring systems, make entries in the hosts of your operating system

   ``<external-ip nginx> prometheus``
   ``<external-ip nginx> grafana``
   ``<external-ip nginx> kiali``
   ``<external-ip nginx> kibana``
   ``<external-ip nginx> shop``
   
  Go to http://shop/
