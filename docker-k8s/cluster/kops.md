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
aws s3 mb s3://practice.konkas.tech
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
export KOPS_STATE_STORE="s3://practice.konkas.tech"
```
---
### **7. Create Kubernetes Cluster with KOPS**
Run the following command to create your Kubernetes cluster:
```bash
kops create cluster \
    --cloud=aws \
    --name="practice.konkas.tech" \
    --node-count=2 \
    --node-size="t3a.small" \
    --node-volume-size=20 \
    --control-plane-count=1 \
    --control-plane-size="t3a.medium" \
    --control-plane-volume-size=20 \
    --zones="ap-south-1a" \
    --control-plane-zones="ap-south-1a" \
    --state="s3://practice.konkas.tech" \
    --dns=public \
    --dns-zone="konkas.tech" \
    --networking="calico"
```
Verify cluster creation:
```bash
kops get cluster --state="s3://practice.konkas.tech"
```
---
### **8. Edit Cluster Configuration**
Edit cluster settings if needed:
```bash
kops edit cluster practice.konkas.tech --state="s3://practice.konkas.tech"
kops edit ig --name=practice.konkas.tech nodes-ap-south-1a --state="s3://practice.konkas.tech"
kops edit ig --name=practice.konkas.tech control-plane-ap-south-1a --state="s3://practice.konkas.tech"
```
Update configurations directly in YAML:
```bash
kops get cluster --name="practice.konkas.tech" --state="s3://practice.konkas.tech" -o yaml > cluster.yaml
sed -i '/instanceGroup: control-plane-ap-south-1a/a \ \ \ \ \ \ volumeSize: 3' cluster.yaml
```
Apply updates:
```bash
kops update cluster --name practice.konkas.tech --yes --admin --state="s3://practice.konkas.tech"
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
ssh -i ~/.ssh/id_rsa ubuntu@api.practice.konkas.tech
```
*Note: Use the appropriate user based on your OS.*
---
### **11. Delete Cluster**
To delete the cluster:
```bash
kops delete cluster --name="practice.konkas.tech" --yes --state="s3://practice.konkas.tech"
```
---
### **12. Additional Suggestions**
- List clusters: `kops get cluster`
- Edit cluster: `kops edit cluster practice.konkas.tech`
- Edit node group: `kops edit ig --name=practice.konkas.tech nodes-ap-south-1a`
- Edit control-plane group: `kops edit ig --name=practice.konkas.tech control-plane-ap-south-1a`

Set KUBECONFIG:
```bash
export KUBECONFIG=/etc/kubernetes/admin.conf
```
For addons, visit: [KOPS Addons Documentation](https://kops.sigs.k8s.io/addons/)
---




# Kops Cluster Installation
- amazon ami comes with aws cli automatically other than aws ami install aws cli
1. Install ec2 instance
2. create IAM Role with below permissions and assign to the above ec2 machine
    - AmazonEC2FullAccess
    - AmazonEventBridgeFullAccess
    - AmazonRoute53FullAccess
    - AmazonS3FullAccess
    - AmazonSQSFullAccess
    - AmazonVPCFullAccess
    - IAMFullAccess
3. Create Route53 Hosted zone if you have use it
4. Create s3 bucket for kops it will store configuration of cluster in s3 also
5. install kops and kubectl,kubens,kubectx and helm,tmux,git,k9s
6. export KOPS_STATE_STORE="s3://practice.konkas.tech"
7. kops create cluster \
    --cloud=aws \
    --name="practice.konkas.tech" \
    --node-count=2 \
    --node-size="t3a.small" \
    --node-volume-size=20 \
    --control-plane-count=1 \
    --control-plane-size="t3a.medium" \
    --control-plane-volume-size=20 \
    --zones="ap-south-1a" \
    --control-plane-zones="ap-south-1a" \
    --state="s3://practice.konkas.tech" \
    --dns=public \
    --dns-zone="konkas.tech" \
    --networking="calico"

8.  kops get cluster --name="practice.konkas.tech"  -o yaml > cluster.yaml
    sed -i '/instanceGroup: control-plane-ap-south-1a/a \ \ \ \ \ \ volumeSize: 3' cluster.yaml
    kops replace -f cluster.yaml
9. kops update cluster --name practice.konkas.tech --yes --admin
10. kops delete cluster --name="practice.konkas.tech" --yes


# Automate with bash scripting and also use spot instance for data nodes

1. 
```bash
#!/bin/bash

CLUSTER_NAME="practice.konkas.tech"
KOPS_STATE_STORE="s3://practice.konkas.tech"
SPOT_ASG_MAX=2
SPOT_ASG_MIN=2
SPOT_INSTANCE_TYPE="t3a.medium"

NODE_COUNT=1
NODE_SIZE="t3a.medium"
NODE_VOLUME_SIZE=20
NODE_ZONES="ap-south-1a,ap-south-1b"
CONTROL_PLANE_COUNT=1
CONTROL_PLANE_SIZE="t3a.medium"
CONTROL_PLANE_VOLUME_SIZE=20
CONTROL_PLANE_ZONES="ap-south-1a"
DNS_ZONE="konkas.tech"
NETWORK_PLUGIN="calico"
ETCD_VOLUME_SIZE=3

print_message() {
    echo "=================================================================="
    echo "$1"
    echo "=================================================================="
}

print_message "Starting Cluster Creation"
if ! kops get cluster --name="$CLUSTER_NAME" --state="$KOPS_STATE_STORE" &>/dev/null; then
    kops create cluster \
        --cloud=aws \
        --name="$CLUSTER_NAME" \
        --node-count="$NODE_COUNT" \
        --node-size="$NODE_SIZE" \
        --node-volume-size="$NODE_VOLUME_SIZE" \
        --control-plane-count="$CONTROL_PLANE_COUNT" \
        --control-plane-size="$CONTROL_PLANE_SIZE" \
        --control-plane-volume-size="$CONTROL_PLANE_VOLUME_SIZE" \
        --zones="$NODE_ZONES" \
        --control-plane-zones="$CONTROL_PLANE_ZONES" \
        --state="$KOPS_STATE_STORE" \
        --dns=public \
        --dns-zone="$DNS_ZONE" \
        --networking="$NETWORK_PLUGIN"
    print_message "Cluster creation initiated."
else
    print_message "Cluster already exists. Skipping creation."
fi

# Ensure SSH key exists
if [ ! -f /home/ec2-user/.ssh/id_ed25519.pub ]; then
    ssh-keygen -t ed25519 -f /home/ec2-user/.ssh/id_ed25519 -N ""
fi

kops create secret sshpublickey admin -i /home/ec2-user/.ssh/id_ed25519.pub --name="$CLUSTER_NAME" --state="$KOPS_STATE_STORE"

kops get cluster --name="$CLUSTER_NAME" --state="$KOPS_STATE_STORE" -o yaml > cluster.yaml

if ! grep -q "volumeSize: 3" cluster.yaml; then
    sed -i '/instanceGroup: control-plane-ap-south-1a/a \ \ \ \ \ \ volumeSize: 3' cluster.yaml
fi

if ! grep -q "metricsServer:" cluster.yaml; then
    sed -i '/spec:/a \ \ metricsServer:\n    enabled: true' cluster.yaml
fi

if ! grep -q "certManager:" cluster.yaml; then
    sed -i '/spec:/a \ \ certManager:\n    enabled: true' cluster.yaml
fi

print_message "Updating the configuration......"

kops replace -f cluster.yaml

print_message "Cluster configuration updated."

rm -rf cluster.yaml 

print_message "Delete Configuration..."

kops get cluster --name="$CLUSTER_NAME" --state="$KOPS_STATE_STORE" -o yaml > cluster.yaml

print_message "Deleting Default Instance Groups"
for IG in nodes-ap-south-1a nodes-ap-south-1b; do
    if kops get ig "$IG" --state="$KOPS_STATE_STORE" --name="$CLUSTER_NAME" &>/dev/null; then
        kops delete ig "$IG" --state="$KOPS_STATE_STORE" --name="$CLUSTER_NAME" --yes
        print_message "Deleted $IG."
    else
        print_message "$IG already deleted or does not exist."
    fi
done

print_message "Creating Spot Instance Group"

if ! kops get ig spot-1 --name="$CLUSTER_NAME" &>/dev/null; then
    kops toolbox instance-selector "spot-1" \
        --usage-class spot --cluster-autoscaler \
        --base-instance-type $SPOT_INSTANCE_TYPE \
        --allow-list '^t3a.*' --gpus 0 \
        --node-count-max $SPOT_ASG_MAX --node-count-min $SPOT_ASG_MIN \
        --node-volume-size 20 \
        --name="$CLUSTER_NAME"
    print_message "Spot instance group created."
else
    print_message "Spot instance group already exists."
fi

print_message "Applying Cluster Changes"
kops update cluster --name="$CLUSTER_NAME" --state="$KOPS_STATE_STORE" --yes --admin

```
