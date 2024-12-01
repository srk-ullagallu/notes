# Work station setup
- Launch EC2 instance and type is amazon linux 3
- Softwares need to install
**Docker and Docker Compose**
sudo dnf install -y git docker tmux tree perl libicu
sudo systemctl start docker
sudo usermod -aG docker ec2-user

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

newgrp docker

chmod +x /usr/local/bin/docker-compose
docker version
docker-compose 

**dotnet installation**
wget https://dotnetcli.azureedge.net/dotnet/Sdk/9.0.100/dotnet-sdk-9.0.100-linux-x64.tar.gz -O dotnet-sdk-9.0.100-linux-x64.tar.gz
mkdir -p $HOME/dotnet
tar -xvzf dotnet-sdk-9.0.100-linux-x64.tar.gz -C $HOME/dotnet
echo 'export DOTNET_ROOT=$HOME/dotnet' >> ~/.bashrc
echo 'export PATH=$DOTNET_ROOT:$PATH' >> ~/.bashrc
source ~/.bashrc
dotnet --version

**Python**
- python already installed so you just type python3 --version

- install pip

curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

**ansible installation**
python3 -m pip install --user ansible
**NodeJS**
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc
fnm use --install-if-missing 20
node -v
npm -v 
**Java**
sudo yum install java-11-amazon-corretto-devel
**Maven**
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
mvn --version
**Terraform**
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform -v
**Packer**
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install packer
**kubectl**
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin
**kubens and kubectx**
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
**k9s**
curl -sS https://webinstall.dev/k9s | bash
**github runner**
- create github organization
- go to settings of organization
- one the left you can find `actions` and expand it select new `runner` and runner image `linux`
- you can find `Donwload` and `Configure` sections copy all the commands in a notepad
- Go to workstation install one by one step for example

Download Section of your commands
----------------------------------
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz

Configure Sections of your commands
-----------------------------------
sudo ./config.sh --url https://github.com/srk-ullagallu --token AMIYWKOFVKJ3A6JGCN2QHRLHJPIPQ  once you enter this it will prompt

Enter the name of the runner group to add this runner to: [press Enter for Default] press enter here

Enter the name of runner: [press Enter for ip-172-31-80-171]  <please give your desired name> for example: my_runner

This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip] utility

Enter name of work folder: [press Enter for _work] press enter here

that's it

once it is completed 

add github runner as a system service

sudo nano /etc/systemd/system/github-runner.service
[Unit]
Description=GitHub Actions Runner
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/actions-runner
ExecStart=/home/ec2-user/actions-runner/run.sh
Restart=always

[Install]
WantedBy=multi-user.target


Replace /home/ec2-user/actions-runner with the path where your GitHub Actions Runner is installed.

sudo systemctl daemon-reload
sudo systemctl enable github-runner
sudo systemctl start github-runner
sudo systemctl status github-runner

then go to you github organization settings --> actions --> runner see that your your runner is idle state











