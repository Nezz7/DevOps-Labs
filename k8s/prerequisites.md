# Prerequisites for Kubernetes Labs

Before starting the Kubernetes labs, you need to install the following tools:

## 1. Docker

Docker is required to run containers and is a dependency for Kind.

### Installation

**macOS:**
```bash
brew install --cask docker
```
Or download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop)

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```


**Windows:**
Download and install Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop)

### Verify Installation
```bash
docker --version
docker run hello-world
```

## 2. Kind (Kubernetes in Docker)

Kind is a tool for running local Kubernetes clusters using Docker containers.

### Installation

**macOS:**
```bash
brew install kind
```

**Linux:**
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

**Windows (PowerShell):**
```powershell
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.30.0/kind-windows-amd64
Move-Item .\kind-windows-amd64.exe c:\some-dir-in-your-PATH\kind.exe
```
You can check directories in your PATH by running in PowerShell:
``` PowerShell
echo $env:PATH
```
Example directories that are typically in your PATH:
```
C:\Users\<YourUsername>\AppData\Local\Programs
C:\Program Files
C:\Program Files (x86)
```

Documentation for Kind installation can be found [here](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).

### Verify Installation
```bash
kind --version
```

## 3. kubectl

kubectl is the Kubernetes command-line tool for interacting with clusters.

### Installation

**macOS:**
```bash
brew install kubectl
```

**Linux:**
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

**Windows (PowerShell):**
```powershell
curl.exe -LO "https://dl.k8s.io/release/v1.34.0/bin/windows/amd64/kubectl.exe"
```

Documentation for kubectl installation can be found [here](https://kubernetes.io/docs/tasks/tools/#kubectl).

### Verify Installation
```bash
kubectl version --client
```


## Pull Required Docker Images

Before starting the labs, pull the necessary Docker images:

```bash
docker pull kindest/node@sha256:7416a61b42b1662ca6ca89f02028ac133a309a2a30ba309614e8ec94d976dc5a
````