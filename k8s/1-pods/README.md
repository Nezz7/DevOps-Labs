# Lab 1: Kubernetes Pods

## What is a Pod?
Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

A Pod is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers

[Kubernetes docs Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
## Exercises

### Create a Pod
```bash
kubectl run mypod --image=nginx
kubectl get pods --watch -o wide
kubectl describe pod mypod
kubectl exec -it mypod -- sh
$ exit
kubectl delete pod mypod
```

### Create a Pod with Wrong Image tag
```bash 
kubectl run mypod --image=nginx:wrongtag
kubectl get pods --watch
kubectl describe pod mypod
kubectl edit pod mypod
kubectl delete pod mypod
```

### Create a Pod with Wrong args to trigger CrashLoopBackOff
```bash
kubectl run mypod --image=nginx -- wrong-args
kubectl get pods --watch
kubectl describe pod mypod
kubectl logs mypod
kubectl delete pod mypod
kubectl run mypod --image=nginx --restart=Never -- wrong-args
kubectl get pods --watch
kubectl delete pod mypod
```
### Pod with Environment Variables
```bash
kubectl apply -f pod-with-env.yaml
kubectl exec env-pod -- env
```

###  Pod with Resource Limits
```bash
kubectl apply -f pod-with-resources.yaml
kubectl describe pod resource-pod
```

### Pod with Multiple Containers
```bash
kubectl run --help # check --dry-run option
kubectl run --image=nginx multi-container-pod --dry-run=client -o  yaml > my-multi-container-pod.yaml
```
Open the generated file and modify it to include a second container as shown below:
```yaml
  - name: ubuntu
    image: ubuntu:latest
    command: ['sh', '-c', 'while true; do echo "Server is running"; sleep 30; done']
```
```bash
kubectl apply -f multi-container-pod.yaml
kubectl get pods
kubectl describe pod multi-container-pod
kubectl exec -it multi-container-pod -c ubuntu -- sh
# apt update && apt install curl -y
# curl http://localhost:80
# ....
# <h1>Welcome to nginx!</h1>
```

Containers in the same Pod share the same network namespace, which means they share:
- The same IP address
- The same network interfaces
- The same ports
### Pod with Init Container
```bash
kubectl apply -f init-container-pod.yaml
kubectl get pods
kubectl describe pod myapp
# Events:
#   Type    Reason     Age   From               Message
#   ----    ------     ----  ----               -------
#   Normal  Scheduled  47s   default-scheduler  Successfully assigned default/myapp to enicarthage-worker
#   Normal  Pulling    47s   kubelet            Pulling image "ubuntu:latest"
#   Normal  Pulled     46s   kubelet            Successfully pulled image "ubuntu:latest" in 1.37s (1.37s including waiting). Image size: 28871138 bytes.
#   Normal  Created    46s   kubelet            Created container: run-db-migration
#   Normal  Started    46s   kubelet            Started container run-db-migration
#   Normal  Pulling    35s   kubelet            Pulling image "nginx:latest"
#   Normal  Pulled     33s   kubelet            Successfully pulled image "nginx:latest" in 1.831s (1.831s including waiting). Image size: 58257398 bytes.
#   Normal  Created    33s   kubelet            Created container: myapp
#   Normal  Started    33s   kubelet            Started container myapp
kubectl logs myapp -c run-db-migration
```
