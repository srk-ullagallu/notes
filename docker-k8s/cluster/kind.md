### 📝 **Notes on Docker, KIND, and Kubernetes Setup**

---

## 🚀 **Docker Installation**

1. **Install Required Tools:**  
   ```bash
   dnf install -y git docker tmux tree
   ```
   - Installs `git`, `docker`, `tmux`, and `tree`.

2. **Start Docker Service:**  
   ```bash
   systemctl start docker
   ```

3. **Add User to Docker Group:**  
   ```bash
   usermod -aG docker ec2-user
   ```
   - Allows the `ec2-user` to run Docker commands without `sudo`.

4. **Install Docker Compose:**  
   ```bash
   curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   chmod +x /usr/local/bin/docker-compose
   ```
   - Downloads the latest version of Docker Compose.
   - Makes it executable.

---

## 🛠️ **kubectl Installation**

1. **Download kubectl Binary:**  
   ```bash
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   ```

2. **Make Binary Executable:**  
   ```bash
   chmod +x kubectl
   ```

3. **Move Binary to Path:**  
   ```bash
   sudo mv kubectl /usr/local/bin/
   ```
   - Ensures `kubectl` is accessible globally.

4. **Verify Installation:**  
   ```bash
   kubectl version --client
   ```

---

## ⚙️ **KIND Installation**

1. **Download KIND Binary:**  
   ```bash
   curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
   ```

2. **Make Binary Executable:**  
   ```bash
   chmod +x ./kind
   ```

3. **Move Binary to Path:**  
   ```bash
   sudo mv ./kind /usr/local/bin/kind
   ```

4. **Verify Installation:**  
   ```bash
   kind version
   ```

---

## 📝 **KIND Cluster Configuration**

Create a file named `kind-config.yaml` with the following content:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
networking:
  podSubnet: "192.168.0.0/16"
  serviceSubnet: "10.96.0.0/12"
```

- **Control Plane:** 1 Node  
- **Workers:** 2 Nodes  
- **Networking:** Configured with specific pod and service subnets.

---

## 📦 **Create KIND Cluster**

1. **Create Cluster with Config:**  
   ```bash
   kind create cluster --config kind-config.yaml
   ```

2. **Verify Nodes:**  
   ```bash
   kubectl get nodes
   ```

---

## ✅ **Verify Cluster and Networking**

1. **Check Node Status:**  
   ```bash
   kubectl get nodes
   ```

2. **Test Pod Network Connectivity:**  
   ```bash
   kubectl run test-pod --image=busybox --restart=Never --command -- sleep 3600
   kubectl exec test-pod -- ping google.com
   ```

---

## 🧹 **Cleanup (Optional)**

- Delete the KIND Cluster:  
   ```bash
   kind delete cluster
   ```

---

Let me know if you encounter any issues or need further assistance, Konka! 😊