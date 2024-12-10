# 3-tier vm setup[expense]
TargetEnvironment: Ec2 instances
DB: RDS
InfraCreation: Terraform
Observability: CloudWatch 

# ECS Project[instana]
TargetEnvironment: ECS
Observability: CloudWatch
InfraCreation: Terraform
CI/CD: GitHubActions

# Single page application[3-tier]
TargetEnvironment: frontend[s3],backend[ECS],DB[RDS]
Observability: CloudWatch
InfraCreation: Terraform
CI/CD: GithubActions

# k8s project[MicroServices]
TargetEnvironment: EKS
Nof-Microservices: 11
Monitoritng: Prometheus&Grafana
Logging: EFK
InfraCreation: Terraform
CI: Jenkins,GithubActions
CD: ArgoCD
Traces: Kiali&Jaegar
Mesh: Istio




