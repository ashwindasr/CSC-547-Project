# Horizontal autoscaling using Kubernetes and Flask

Autoscaling a flask app locally using Docker, Kubernetes and Flask. The flask app will return `Hello World!`. We will also enable horizontal autoscaling to handle increased load.

Step 1: Download Docker Desktop and enable Kubernetes in the settings. <br>
Step 2: Install kubernetes `kubectl`  <br>
Step 3: Clone this repository.<br>
Step 4: Create a docker build by using the command `docker build -f Dockerfile -t hello-world:latest .`<br>
Step 5: Switch kubernetes to use the docker context `kubectl config use-context docker-desktop`<br>
Step 6: Deploy a metrics-server using `kubectl apply -f components.yaml` and wait a couple of minutes for the server to get deployed. Check the status using `kubectl get deployment metrics-server -n kube-system
`<br>
Step 7: Deploy the application by running `kubectl apply -f deployment.yaml` <br>
Step 8: Enable horizontal autoscaler by running `kubectl autoscale deployment hello-world --cpu-percent=10 --min=1 --max=10`. Run `kubectl get hpa` or ``kubectl describe hpa`` to see the status. Wait a minute or two. <br>
Step 9: Get the ip address of the deployment by running `kubectl describe hello-world` and use that IP address to start a busybox server to test the autoscaling `kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- 10.104.209.144:9000; done"` <br>
Step 10: Run this command on a separate terminal to see the status `kubectl get hpa hello-world --watch`
