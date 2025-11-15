# Kubernetes Cluster Setup
In this lab we will create a local Kubernetes cluster using Kind and explore its components.

## 1. Create a Kind Cluster
Create a multi-node cluster with 1 control plane and 1 worker node:
```bash
kind create cluster --config ./k8s/0-cluster-setup/cluster-config.yaml
```

## 2. Verify Cluster Configuration
View the kubeconfig file that stores cluster access information:
```bash
kubectl config view
```

Check the raw kubeconfig file:
```bash
cat ~/.kube/config
```

Get cluster endpoint and certificate info:
```bash
kubectl cluster-info
```

List all namespaces:
```bash
kubectl get namespace
```

## 3. Inspect Cluster Nodes
View nodes in the cluster:
```bash
kubectl get nodes
```

**Expected output:**
```
NAME                        STATUS   ROLES           AGE   VERSION
enicarthage-control-plane   Ready    control-plane   1m    v1.34.0
enicarthage-worker          Ready    <none>          1m    v1.34.0
```

## 4. Explore System Pods
View all pods across all namespaces:
```bash
kubectl get pods --all-namespaces
```

View system pods (Kubernetes core components):
- Kube-apiserver
- Kube-controller-manager
- Kube-scheduler
- Etcd
```bash
kubectl get pods -n kube-system
```

View pods with verbose API request logging:
```bash
kubectl get pods -n kube-system -v=7
```

View pods with additional details (IP, node):
```bash
kubectl get pods -n kube-system -o wide
```

## 5. Set Default Namespace
Set kube-system as the default namespace
```bash
kubectl config set-context --current --namespace kube-system
```

## 6. Explore the Control Plane Node
Access the control plane container:
```bash
# Get the control plane container ID and access it
export id=$(docker ps | grep control-plane | cut -d " " -f1)
docker exec -it $id sh
```

Inside the control plane container, explore Kubernetes components:
```bash
# Check kubelet service status
systemctl status kubelet

# View recent kubelet logs
journalctl -u kubelet -n 100

# List all running processes (see kube-apiserver, etcd, etc.)
ps aux

# List all containers managed by CRI
crictl ps -a

# exit container 
 exit
```

## Clean Up
Delete the cluster when finished:
```bash
kind delete cluster --name enicarthage
```