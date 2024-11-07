# notes overview

## Linux

- File System
- Redirections
- Hard and Soft links
- User Management
- File Management
- SSH Management
- Log Management
- Process Management
- NetWork Management[ISO/OSI|Model|PROXY|Reverse|Forward]
- Disk Management
- Cron Jobs

## Bash Scripting

- SED|AWK|CUT|GREP
- Loops
- Conditions
- Special Variables
- Functions

## AWS

- VPC[VPC|Components|Peering|TG|SG|NACL'S|Endpoints|NAT|FlowLogs]
- EC2[BuyingOptions|ELB|EBS|ASG]
- IAM[Users|Roles|Groups|policies|AWSOrganizations]
- R53[RoutingPolicies|HostedZones|DomainRegistration]
- EFS
- S3[Features|]
- ECR,ECS,EKS
- CF[CDN],CW[Monitoring],CT[Logs|the|events|happend|in|the|aws|account]
- ACM[Certificate|Manager]
- RDS[Managed|DB|Service]
- Lambda[Server|less|compute]
- EventBridge
- API Gateway

## Git&GitHub[Repos|BranchProtectionRules|PR|Organizations]

- Why and What Git
- What is Github
- Branching Strategy
- Merge,Rebase,FastForward Merge,Cherry-Pick
- Reset,Revert,Tagging

## Python

- Loops
- Conditions
- Functions

## Packer
- 
## Terraform & Terraform Cloud

- What and Why Terraform
- Resource Blocks,Variables Blocks,Output Blocks,local Blocks,data block
- Count,dynamic block,for_each,condition[condition?true:false]
- Local state and Remote state
- Functions
- Provisioners
- Workspaces
- Import
- Taint/Replace
- How can we detect and avoid configuration drift

## Docker

- What is Docker
- Difference b/w vm and container
- Docker Architecture
- Dockerfile instructions
- Multistage Docker file
- Docker N/W,Volumes
- Docker Compose

## Kubernetes
- Labels&Selectors,Annotations,Namespaces,Init Containers,Side Car Container
- WorkLoads
  - Pods[PodLifeCycle]
  - ReplicaSet|ReplicationController
  - Deployment
  - StatefulSet
  - DaemonSet
  - Jobs
  - CronJobs
- Services[ClusterIP|NodePort|LoadBalancer|ExternalService|Headless]
- Storage[PV,PVC,SC,Static|Dynamic|Provisioning]
- Configuration Mangement
  - ConfigMap
  - Secrets
- Security
  - RBAC[R|RB|C|CRB|SA]

   
   ## Ingress

   ## ArGoCD

    GitOps is a modern approach to automating and managing infrastructure and application deployments using Git as the single source of truth. It allows operations and development teams to manage infrastructure and applications declaratively through version control, enabling continuous deployment, improved collaboration, and easier rollbacks.

    Here are the key principles of GitOps:

    1. **Declarative Infrastructure and Applications**: Infrastructure and application configuration are defined declaratively in Git repositories.
    2. **Git as the Single Source of Truth**: All changes to the system, including infrastructure and code, are tracked in Git, ensuring transparency and audibility.
    3. **Automated Syncing**: Tools (such as ArgoCD or Flux) automatically sync the desired state in Git to the actual state in the cluster.
    4. **Continuous Deployment**: Every change pushed to the Git repository triggers automatic deployment to the target environment.
    5. **Easy Rollbacks**: Version control allows teams to easily revert to previous stable states if issues arise.

   ## ISTIO

   ## HELM | Kustomization

   ## Karpenter | KEDA

## Jenkins|GitHubActions|GitLab-CI

## Monitoring[Metrics|Logs|Traces]

  ## Prometheus & Grafana

  ## Elastic Stack

  ## Jaegar & Kiali

## DevOps

## DevSecOps

## Agile Methodology | Waterfall Model

## GitOps

## CIntegration/CDeployment/CDelivary