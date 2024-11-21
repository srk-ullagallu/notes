kubeadm cluster create 
----------------------

1. Launch 3 servers t3a.medium[ubuntu]
2. Installing containerd,cni plugin,runc and kubeadm,kubelet,kubectl[all 3 nodes]

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

3. kubeadm init   [only on master node][run as root user]

You will get below info in your machine take kubeadm join command run all worker nodes

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

`To get kube config file in non-root user use below commands`
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:
`For root user just export`
  export KUBECONFIG=/etc/kubernetes/admin.conf


`Then you can join any number of worker nodes by running the following on each as root:`

kubeadm join 172.31.34.170:6443 --token djdvig.sc79zwpoj1lh9di5 \
        --discovery-token-ca-cert-hash sha256:421a53c051469c098f3bc1ea446ad948ec52bd47a5849d7113b00c2bc6063a2f

4. Install calico plugin[https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises]
curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/calico.yaml -O
kubectl apply -f calico.yaml
5. Assign the labels to the nodes
kubectl label node <node-name> node-role.kubernetes.io/worker=worker
kubectl label node <node-name> node-role.kubernetes.io/worker=worker
6. commands reference
https://kubernetes.io/docs/reference/kubectl/quick-reference/




