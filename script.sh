#!/bin/bash

# Install Docker
wget -O docker.sh https://get.docker.com/
bash docker.sh
sudo usermod -aG docker vagrant
newgrp docker

REGISTRY_URL="https://index.docker.io/v1/"
USERNAME="sibsiewibsie"
PASSWORD="Siebe2004."

docker login $REGISTRY_URL -u $USERNAME -p $PASSWORD

# Install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install kubectl
sudo apt-get update
sudo apt-get install -y ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install Git
sudo apt-get install -y git

# Clone your Git repository
git clone https://github.com/GiosSiebe/MeanStack.git

cd MeanStack

# Create Kubernetes cluster
kind create cluster --config=kindconfig.yml

# Apply Ingress-NGINX deployment
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

# Pause to allow Ingress-NGINX to start
sleep 120

# Apply other Kubernetes resources
kubectl apply -f apache-service.yaml
kubectl apply -f apache-deployment.yaml
kubectl apply -f nodejs-service.yaml
kubectl apply -f nodejs-deployment.yaml
kubectl apply -f postgresql-service.yaml
kubectl apply -f postgresql-deployment.yaml

# Pause to allow other resources to start
sleep 360

# Apply Ingress resources
kubectl apply -f ingress.yml
kubectl apply -f ingress2.yml

# Print success message
echo "Kubernetes setup completed!"
