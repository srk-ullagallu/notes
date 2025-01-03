**KOPS (Kubernetes Operations) Setup Guide**

### **1. Create IAM User and Attach Policies**
Create an IAM user with the following policies to manage Kubernetes clusters using KOPS:
- AmazonEC2FullAccess
- AmazonRoute53FullAccess
- AmazonS3FullAccess
- IAMFullAccess
- AmazonVPCFullAccess
- AmazonSQSFullAccess
- AmazonEventBridgeFullAccess

---

### **2. Create S3 Bucket**
Create an S3 bucket to store the Kubernetes cluster state.
```bash
aws s3 mb s3://kops-lerndevops.online
```

---

### **3. Create Route53 Zone**
Create a Route53 hosted zone for your domain.

---

### **4. Launch EC2 Instance**
Launch an EC2 instance to act as your KOPS management workstation.

---

### **5. Install KOPS and kubectl**
Install KOPS and kubectl on the EC2 instance.

**Install KOPS:**
```bash
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/
```

**Install kubectl:**
```bash
curl -Lo kubectl https://dl.k8s.io/release/$(curl -s -L https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

---

### **6. Configure AWS CLI**
Configure AWS CLI with your IAM credentials:
```bash
aws configure --profile <your-profile>
```

Set the KOPS state store:
```bash
export KOPS_STATE_STORE="s3://kops-lerndevops.online"
```

---

### **7. Create Kubernetes Cluster with KOPS**
Run the following command to create your Kubernetes cluster:
```bash
kops create cluster \
    --cloud=aws \
    --name="app.lerndevops.online" \
    --node-count=2 \
    --node-size="t3a.small" \
    --node-volume-size=20 \
    --control-plane-count=1 \
    --control-plane-size="t3a.medium" \
    --control-plane-volume-size=20 \
    --zones="ap-south-1a" \
    --control-plane-zones="ap-south-1a" \
    --state="s3://kops-lerndevops.online" \
    --dns=public \
    --dns-zone="lerndevops.online" \
    --networking="calico"
```

Verify cluster creation:
```bash
kops get cluster --state="s3://kops-lerndevops.online"
```

---

### **8. Edit Cluster Configuration**
Edit cluster settings if needed:
```bash
kops edit cluster app.lerndevops.online --state="s3://kops-lerndevops.online"
kops edit ig --name=app.lerndevops.online nodes-ap-south-1a --state="s3://kops-lerndevops.online"
kops edit ig --name=app.lerndevops.online control-plane-ap-south-1a --state="s3://kops-lerndevops.online"
```

Update configurations directly in YAML:
```bash
kops get cluster --name="app.lerndevops.online" --state="s3://kops-lerndevops.online" -o yaml > cluster.yaml
sed -i '/instanceGroup: control-plane-ap-south-1a/a \ \ \ \ \ \ volumeSize: 3' cluster.yaml
```

Apply updates:
```bash
kops update cluster --name app.lerndevops.online --yes --admin --state="s3://kops-lerndevops.online"
```

---

### **9. Validate Cluster**
Validate the cluster to ensure everything is working as expected:
```bash
kops validate cluster --wait 10m
```

List nodes:
```bash
kubectl get nodes --show-labels
```

---

### **10. SSH into Control-Plane Node**
SSH into the control-plane node:
```bash
ssh -i ~/.ssh/id_rsa ubuntu@api.app.lerndevops.online
```
*Note: Use the appropriate user based on your OS.*

---

### **11. Delete Cluster**
To delete the cluster:
```bash
kops delete cluster --name="app.lerndevops.online" --yes --state="s3://kops-lerndevops.online"
```

---

### **12. Additional Suggestions**
- List clusters: `kops get cluster`
- Edit cluster: `kops edit cluster app.lerndevops.online`
- Edit node group: `kops edit ig --name=app.lerndevops.online nodes-ap-south-1a`
- Edit control-plane group: `kops edit ig --name=app.lerndevops.online control-plane-ap-south-1a`

Set KUBECONFIG:
```bash
export KUBECONFIG=/etc/kubernetes/admin.conf
```

For addons, visit: [KOPS Addons Documentation](https://kops.sigs.k8s.io/addons/)

---

