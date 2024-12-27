**Kubeadm Kubernetes Cluster Setup Guide**

### **1. Launch 3 Ubuntu Servers**
- Launch three servers with the instance type `t3a.medium`
- Operating System: Ubuntu

---

### **2. Install containerd, CNI Plugin, runc, kubeadm, kubelet, and kubectl (on all nodes)**

**Enable IP Forwarding:**
```bash
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system
```

**Install containerd:**
```bash
wget https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-amd64.tar.gz
tar xvf containerd-2.0.0-linux-amd64.tar.gz
```

**Install runc:**
```bash
wget https://github.com/opencontainers/runc/releases/download/v1.2.1/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
```

**Install CNI Plugins:**
```bash
wget https://github.com/containernetworking/plugins/releases/download/v1.6.0/cni-plugins-linux-amd64-v1.6.0.tgz
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.6.0.tgz
```

**Move binaries to the correct location:**
```bash
sudo mv bin/* /usr/local/bin/
```

**Configure containerd:**
```bash
sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

**Enable containerd service:**
```bash
sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
sudo systemctl daemon-reload
sudo systemctl start containerd
sudo systemctl enable containerd
sudo systemctl status containerd
```

**Install Kubernetes Packages:**
```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
```

---

### **3. Initialize Kubernetes Cluster (Master Node Only)**
Run the following command on the **master node**:
```bash
sudo kubeadm init
```

You will receive a **kubeadm join command** after successful initialization. Save this command.

**Set up kubeconfig (for non-root user):**
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

**For root user:**
```bash
export KUBECONFIG=/etc/kubernetes/admin.conf
```

**Join Worker Nodes:**
Run the following on each **worker node**:
```bash
kubeadm join <master-node-ip>:6443 --token <token> \
    --discovery-token-ca-cert-hash sha256:<hash>
```

---

### **4. Install Calico Network Plugin**
Install the Calico plugin for networking:
```bash
curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/calico.yaml -O
kubectl apply -f calico.yaml
```

---

### **5. Label Worker Nodes**
Assign roles to the worker nodes:
```bash
kubectl label node <node-name> node-role.kubernetes.io/worker=worker
kubectl label node <node-name> node-role.kubernetes.io/worker=worker
```

---

### **6. Commands Reference**
- Kubernetes Command Reference: [Kubernetes Docs](https://kubernetes.io/docs/reference/kubectl/quick-reference/)

**Alias for kubectl:**
```bash
alias k='kubectl'
```

**Common Commands:**
- Check Cluster Nodes: `kubectl get nodes`
- Get Cluster Info: `kubectl cluster-info`
- Check Pod Status: `kubectl get pods -A`

---

### **Your Kubernetes Cluster is Ready!** 🚀


