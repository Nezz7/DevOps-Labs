# Lab 3: Kubernetes Deployments

## What is a Deployment?
A Deployment manages a set of Pods to run an application workload, usually one that doesn't maintain state.
A Deployment provides declarative updates for Pods and ReplicaSets. It manages rolling updates, rollbacks, and scaling operations automatically.

[Kubernetes docs Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
## Exercises

### 1. Create a Simple Deployment
```bash
kubectl apply -f simple-deployment.yaml
kubectl get deployments
kubectl get rs
kubectl get pods
```

### 2. Scale a Deployment
```bash
kubectl apply -f simple-deployment.yaml
kubectl scale deployment nginx-deployment --replicas=5
kubectl get pods
```

### 3. Update Deployment Image
```bash
kubectl apply -f simple-deployment.yaml
kubectl set image deployment/nginx-deployment nginx=nginx:1.28
kubectl rollout status deployment/nginx-deployment
kubectl rollout history deployment/nginx-deployment
```

### 4. Rollback a Deployment
```bash
kubectl rollout undo deployment/nginx-deployment
kubectl rollout status deployment/nginx-deployment
```

### 5. Create Deployment with Strategy
`.spec.strategy` specifies the strategy used to replace old Pods by new ones. `.spec.strategy.type` can be "Recreate" or "RollingUpdate". "RollingUpdate" is the default value.

#### Recreate Deployment
All existing Pods are killed before new ones are created when `.spec.strategy.type==Recreate`.

#### Rolling Updates
Rolling updates allow Deployments' update to take place with zero downtime by incrementally updating Pods instances with new ones.

try with both strategies and see the difference in behavior:

```bash
kubectl apply -f deployment-with-strategy.yaml

kubectl describe deployment strategy-deployment
```


## Useful Commands
```bash
# List deployments
kubectl get deployments             
# Get detailed info
kubectl describe deployment <name>     
# Update image
kubectl set image deployment/<name> <container>=<image>  
# Scale
kubectl scale deployment <name> --replicas=<number>  
# Check rollout status
kubectl rollout status deployment/<name>  
# View rollout history
kubectl rollout history deployment/<name>  
# Rollback to previous version
kubectl rollout undo deployment/<name>    
# Delete deployment
kubectl delete deployment <name>         
```
