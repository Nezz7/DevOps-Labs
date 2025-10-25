# Lab 4: Kubernetes Services

## What is a Service?
A Service is an abstraction that defines a logical set of Pods and a policy to access them. Services enable loose coupling between dependent Pods and provide stable networking.

## Service Types
- **ClusterIP**: Default type, exposes service on cluster-internal IP
- **NodePort**: Exposes service on each Node's IP at a static port
- **LoadBalancer**: Exposes service externally using cloud provider's load balancer
- **ExternalName**: Maps the Service to the contents of the externalName field (for example, to the hostname api.foo.bar.example). The mapping configures your cluster's DNS server to return a CNAME record with that external hostname value. No proxying of any kind is set up.

[Kubernetes docs Services](https://kubernetes.io/docs/concepts/services-networking/service/)

## Endpoint in Kubernetes
An Endpoint is a list of IP addresses (and ports) that represent the Pods behind a Service.

Example: If a Service points to 3 Pods, the Endpoint object will list those 3 Pods’ IPs.

## EndpointSlice:
An EndpointSlice is a newer, more scalable version of Endpoints.
Instead of putting all Pod IPs in one big list, Kubernetes splits them into smaller slices (chunks).
This helps improve performance when you have many Pods.
[Guide on endpoints and endpoint slices](https://medium.com/@muppedaanvesh/a-hands-on-guide-to-kubernetes-endpoints-endpointslices-%EF%B8%8F-1375dfc9075c)

## Exercises

Note in this lab we will create resources in demo namespace. Make sure to create it first:
```bash
kubectl create namespace demo
```
Set kube-system as the default namespace

```bash
kubectl config set-context --current --namespace demo
```
### 1. Create ClusterIP Service
```bash
kubectl apply -f deployment-for-service.yaml
kubectl apply -f clusterip-service.yaml
kubectl get svc
kubectl describe svc clusterip-service
```

### 2. Create NodePort Service

```bash
kubectl apply -f deployment-for-service.yaml
kubectl apply -f nodeport-service.yaml
kubectl get svc
# Access via: http://<node-ip>:<node-port>
```
For more details on how to configure a NodePort service in Kind refer to [this guide](https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings).

### 3. Test Service Discovery
### DNS in Kubernetes

Each Service gets a DNS name
Example: `my-service` in namespace `demo` will get `my-service.demo.svc.cluster.local` domain.

- Pods can use this name instead of an IP to communicate. (IP may change when pods are recreated)
- DNS resolves to the Service IP

The DNS name points to the Service’s ClusterIP.
and traffic is routed to the backend Pods via `kube-proxy`.

The cluster DNS (CoreDNS) provides DNS resolution for Services and Pods.

All Pods use CoreDNS automatically to resolve names.


```bash
kubectl apply -f deployment.yaml
kubectl apply -f clusterip-service.yaml
kubectl run test-pod --image=nicolaka/netshoot  -it --rm -- sh
# Inside the pod:
# curl app.demo.svc.cluster.local
# nslookup app.demo.svc.cluster.local
```
### Check the POD CIDR and Service CIDR
```bash
kubectl -n kube-system get configmap kube-proxy -o yaml | grep clusterCIDR

# Inside the controlPlane node run:

ps -ef | grep kube-apiserver | grep service-cluster-ip-range


``` 
## Useful Commands
```bash
kubectl get svc                     
# List services
# Get detailed info
kubectl describe svc <name>         
# List service endpoints
kubectl get endpoints               
# Delete service
kubectl delete svc <name>           
```
