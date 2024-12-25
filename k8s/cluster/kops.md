# kops[kubernets operations]
1. Create IAM user attach below policies
    AmazonEC2FullAccess
    AmazonRoute53FullAccess
    AmazonS3FullAccess
    IAMFullAccess
    AmazonVPCFullAccess
    AmazonSQSFullAccess
    AmazonEventBridgeFullAccess 

3. create S3 bucket
4. Create R53 zone
Take Ec2 instance 
6. Install kops and kubectl

curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/

curl -Lo kubectl https://dl.k8s.io/release/$(curl -s -L https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


7. aws configure --profile 

export KOPS_STATE_STORE="s3://prac.kops-lerndevops.online"

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

kops get cluster --state="s3://kops-lerndevops.online"
kops edit cluster app.lerndevops.online --state="s3://kops-lerndevops.online"
kops edit ig --name=app.lerndevops.online nodes-ap-south-1a  --state="s3://kops-lerndevops.online"
kops edit ig --name=app.lerndevops.online control-plane-ap-south-1a --state="s3://kops-lerndevops.online"



kops get cluster --name="app.lerndevops.online" --state="s3://kops-lerndevops.online" -o yaml > cluster.yaml

sed -i '/instanceGroup: control-plane-ap-south-1a/a \ \ \ \ \ \ volumeSize: 3' cluster.yaml

rm -rf cluster.yaml

kops update cluster --name app.lerndevops.online --yes --admin --state="s3://kops-lerndevops.online"

kops delete cluster --name="app.lerndevops.online" --yes --state="s3://kops-lerndevops.online"




Suggestions:
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster app.lerndevops.online
 * edit your node instance group: kops edit ig --name=app.lerndevops.online nodes-ap-south-1a
 * edit your control-plane instance group: kops edit ig --name=app.lerndevops.online control-plane-ap-south-1a

 Suggestions:
 * validate cluster: kops validate cluster --wait 10m
 * list nodes: kubectl get nodes --show-labels
 * ssh to a control-plane node: ssh -i ~/.ssh/id_rsa ubuntu@api.app.lerndevops.online
 * the ubuntu user is specific to Ubuntu. If not using Ubuntu please use the appropriate user based on your OS.
 * read about installing addons at: https://kops.sigs.k8s.io/addons.

export KUBECONFIG=/etc/kubernetes/admin.conf
