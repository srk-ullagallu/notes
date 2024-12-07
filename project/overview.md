# 3-tier vm setup[expense]

- create infrastructure using terraform
  - vpc
  - sg
  - Ec2
  - ALB
  - ASG
  - ACM
  - R53
  - CF
  - CW
  - RDS
- Write Modules for above all services
- packer 

# ECS Project[instana]

- containerize application
- create infra structure using terraform
- create extra modules like
  - ECS and use above all modules that are required for ECS project setup

# Single page application

- containerize backend
- frontend[s3]
- backend[ECS]
- DB[RDS]

# k8s project

- EKS
- create EKS cluster 
- deploy expense and instana project

# CI/CD

- create CI/CD pipelines to deploy application on ECS and EKS



