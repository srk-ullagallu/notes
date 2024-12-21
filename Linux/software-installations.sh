# ### **What is Idempotency in Scripts?**  
# An **idempotent script** ensures that repeated executions produce the same outcome without causing unintended side effects or repeated actions. For example:  
# - It skips already installed packages.  
# - It doesn’t download or extract files repeatedly if they’re already in place.  
# - It validates configurations before applying them again.  

# 1. **Check if Software is Already Installed:** Validate the presence of commands or files before attempting installation.  
# 2. **Use Conditional Statements (`if`, `command -v`, `[ -f ]`, etc.):** Ensure actions are performed only when necessary.  
# 3. **Avoid Duplicate File Downloads:** Check if files exist before downloading or extracting.  
# 4. **Service Validation:** Verify if services (e.g., Jenkins, Docker) are already active before starting them again.  

#!/bin/bash

set -e
set -o pipefail
set -u

# Define Colors for Logging
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Ensure Root Privileges
if [ "$EUID" -ne 0 ]; then
    error "Please run as root (use ."
fi

# --- Update System Packages ---
log "Updating system packages..."
dnf update -y

# --- Install Required Packages ---
PACKAGES=("git" "docker" "tmux" "tree" "perl" "libicu")

for package in "${PACKAGES[@]}"; do
    if ! rpm -q "$package" &>/dev/null; then
        log "Installing $package..."
        dnf install -y "$package"
    else
        log "$package is already installed."
    fi
done

# --- Terraform Setup ---
if ! command -v terraform &> /dev/null; then
    log "Installing Terraform..."
    yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    yum -y install terraform
else
    log "Terraform is already installed."
fi

# --- Packer Setup ---
if ! command -v packer &> /dev/null; then
    log "Installing Packer..."
    yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    yum -y install packer
else
    log "Packer is already installed."
fi

# --- Docker Setup ---
if ! command -v docker &> /dev/null; then
    log "Installing Docker..."
    dnf install -y docker
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user
else
    log "Docker is already installed."
fi

# --- Docker Compose Setup ---
if ! command -v docker-compose &> /dev/null; then
    log "Installing Docker Compose..."
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
else
    log "Docker Compose is already installed."
fi

# --- Add Current User to Docker Group ---
if ! groups ec2-user | grep -q '\bdocker\b'; then
    log "Adding ec2-user to the docker group..."
    usermod -aG docker ec2-user
    log "User added to docker group. Please log out and log back in to apply changes."
else
    log "ec2-user is already in the docker group."
fi

# --- .NET SDK ---
if [ ! -d "$HOME/dotnet" ]; then
    log "Installing .NET SDK..."
    wget -q https://dotnetcli.azureedge.net/dotnet/Sdk/9.0.100/dotnet-sdk-9.0.100-linux-x64.tar.gz -O dotnet-sdk.tar.gz
    mkdir -p $HOME/dotnet
    tar -xzf dotnet-sdk.tar.gz -C $HOME/dotnet/
    ln -sf $HOME/dotnet/dotnet /usr/local/bin/dotnet
fi
# --- Python & Pip ---
if ! command -v pip &> /dev/null; then
    log "Installing Pip..."
    curl -O https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py --user
    ln -sf ~/.local/bin/pip /usr/local/bin/pip
fi

# --- Ansible ---
if ! command -v ansible &> /dev/null; then
    log "Installing Ansible..."
    python3 -m pip install --user ansible
    ln -sf ~/.local/bin/ansible /usr/local/bin/ansible
fi

# --- NodeJS ---
if ! command -v node &> /dev/null; then
    log "Installing NodeJS..."
    curl -sL https://rpm.nodesource.com/setup_20.x | bash -
    dnf install nodejs -y
fi

# --- Java ---
if ! java -version &> /dev/null; then
    log "Installing Java 17..."
    yum install java-17-amazon-corretto-devel -y
fi

# --- Maven ---
if ! command -v mvn &> /dev/null; then
    log "Installing Maven..."
    wget -q https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
    tar -xzf apache-maven-3.9.9-bin.tar.gz
    mv apache-maven-3.9.9 /opt/maven
    ln -sf /opt/maven/bin/mvn /usr/local/bin/mvn
fi

# --- Jenkins ---
if ! systemctl is-active --quiet jenkins; then
    log "Installing Jenkins..."
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum install jenkins -y
    systemctl enable jenkins
    systemctl start jenkins
fi
systemctl status jenkins --no-pager

# --- kubectl ---
if ! command -v kubectl &> /dev/null; then
    log "Installing kubectl..."
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
    chmod +x kubectl
    mv kubectl /usr/local/bin/
fi

# --- k9s ---
if ! command -v k9s &> /dev/null; then
    log "Installing k9s..."
    curl -sS https://webinstall.dev/k9s | bash
    ln -sf ~/.local/bin/k9s /usr/local/bin/k9s
fi

# --- tfsec ---
if ! command -v tfsec &> /dev/null; then
    log "Installing tfsec..."
    wget -q https://github.com/aquasecurity/tfsec/releases/download/v1.28.11/tfsec-linux-amd64 -O tfsec
    chmod +x tfsec
    mv tfsec /usr/local/bin/
fi

if ! command -v kubectx &> /dev/null; then
    log "Installing kubectx and kubens..."
    git clone https://github.com/ahmetb/kubectx /opt/kubectx
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens
else
    log "kubectx and kubens are already installed."
fi

# --- GitHub Actions Runner Setup ---
log "Setting up GitHub Actions Runner..."

# Create the directory and download the GitHub Actions Runner
mkdir -p /home/ec2-user/actions-runner
cd /home/ec2-user/actions-runner
curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz

# Prompt for GitHub repository URL and token for authentication
read -p "Enter your GitHub repository URL (e.g., https://github.com/your-repo): " REPO_URL
read -p "Enter your GitHub Actions Runner token: " RUNNER_TOKEN

# Run the configuration script for GitHub Actions runner as ec2-user (non-root)
log "Configuring GitHub Actions runner as ec2-user..."
su - ec2-user -c "/home/ec2-user/actions-runner/config.sh --url '$REPO_URL' --token '$RUNNER_TOKEN'"

# Create GitHub Actions runner service
log "Creating GitHub Actions runner service..."
sudo tee /etc/systemd/system/github-runner.service <<EOF
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
EOF

# Reload systemd, enable and start the GitHub Actions runner service
sudo systemctl daemon-reload
sudo systemctl enable github-runner
sudo systemctl start github-runner

# Check the status of the GitHub Actions runner service
sudo systemctl status github-runner

log "GitHub Actions runner has been successfully configured and is running."
log "GitHub Actions runner has been successfully configured and is running."

log "${YELLOW}All installations are idempotent and complete!${NC}"

log "{GREEN} Check all software versions!${NC}"

packer -v || error "Packer installation failed."
terraform -v || error "Terraform installation failed."
tfsec --version
k9s version
kubectl version --client -o yaml
mvn --version
java --version
node -v && npm -v
ansible --version
pip --version
dotnet --version
docker --version || error "Docker installation failed."
docker-compose --version || error "Docker Compose installation failed."
