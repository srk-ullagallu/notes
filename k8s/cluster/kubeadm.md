cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system



wget https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-amd64.tar.gz
tar xvf containerd-2.0.0-linux-amd64.tar.gz

wget https://github.com/opencontainers/runc/releases/download/v1.2.1/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc


wget https://github.com/containernetworking/plugins/releases/download/v1.6.0/cni-plugins-linux-amd64-v1.6.0.tgz

mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.6.0.tgz


sudo mv bin/* /usr/local/bin/

sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml


sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service


sudo systemctl daemon-reload

sudo systemctl start containerd

sudo systemctl enable containerd

sudo systemctl status containerd

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet


curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/calico.yaml -O





kubectl label node ip-172-31-32-122 node-role.kubernetes.io/worker=worker
kubectl label node ip-172-31-43-213 node-role.kubernetes.io/worker=worker




kubectl get|describe|logs|exec|events pods


kubectl api-resources

kubectl events ip-172-31-32-12


kubeadm cluster create 
----------------------

1. Installing containerd
2. runc installing
3. 