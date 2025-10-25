# Lab 2: Kubernetes ReplicaSets

## What is a ReplicaSet?

A ReplicaSet ensures a specified number of pod replicas are running at all times. It provides high availability and fault tolerance for your applications.

[Kubernetes ReplicaSets Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

## How ReplicaSets Work

ReplicaSets use **labels** and **selectors** to manage pods:

- **Labels**: Key-value pairs attached to pods (like `app=nginx`, `version=v1`)
- **Selectors**: Queries that match pods with specific labels

The ReplicaSet continuously monitors pods matching its selector and automatically creates or deletes pods to maintain the desired replica count.

## Controller Pattern

Kubernetes controllers implement control loops that continuously watch cluster state and make changes to achieve the desired state.

**Key Concepts**:
- Controllers monitor resources through the Kubernetes API
- Each resource has a `spec` (desired state) and `status` (current state)  
- Controllers work to reconcile current state with desired state

[Controller Pattern Documentation](https://kubernetes.io/docs/concepts/architecture/controller/)

## Hands-On Exercises

### 1. Create a ReplicaSet
```bash
kubectl apply -f replicaset.yaml
kubectl get rs
kubectl get pods
kubectl describe rs nginx-replicaset
```

### 2. Test Self-Healing
```bash
kubectl apply -f simple-replicaset.yaml
kubectl get pods
kubectl delete pod <pod-name>
kubectl get pods -w  # Watch automatic pod recreation
```

### 3. Scale ReplicaSet
```bash
# Scale up
kubectl scale rs nginx-replicaset --replicas=5
kubectl get pods

# Scale down
kubectl scale rs nginx-replicaset --replicas=2
kubectl get pods
```

### 4. Create Pod with Labels Matching ReplicaSet Selector
```bash
kubectl apply -f pod.yaml
kubectl get pods
kubectl describe rs nginx-replicaset
```

**Question**: What happened to the created pod?
