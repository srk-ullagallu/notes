# ECS Project[instana]
TargetEnvironment: ECS
Observability: CloudWatch
InfraCreation: Terraform
CI/CD: GitHubActions

# 3-tier vm setup[expense]
TargetEnvironment: Ec2 instances
DB: RDS
InfraCreation: Terraform
Observability: CloudWatch 

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



### **Introduction**  
 
*"Throughout my career, I've had the opportunity to work on diverse projects ranging from traditional VM setups to advanced Kubernetes-based microservices architecture. Each project has enhanced my skills in cloud infrastructure, automation, observability, and CI/CD pipelines."*

---

### **Project Categories and Highlights**  
1. **Legacy and VM-Based Infrastructure:**  
   - *"I worked on a 3-tier VM setup for an expense management system, where I deployed applications on EC2 instances, set up RDS as the database, and automated the infrastructure with Terraform. CloudWatch was instrumental for observability."*

2. **Cloud-Native Architectures:**  
   - *"I also designed a 3-tier architecture for a single-page application, hosting the frontend on S3, backend on ECS, and database on RDS. I integrated CI/CD pipelines with GitHub Actions and used CloudWatch for monitoring and troubleshooting."*

3. **Microservices and Kubernetes:**  
   - *"My most challenging and rewarding project was deploying 11 microservices on EKS. This included setting up Terraform for infrastructure, Prometheus and Grafana for monitoring, and the EFK stack for centralized logging. I leveraged Jenkins and GitHub Actions for CI, ArgoCD for CD, and integrated service mesh capabilities using Istio. Distributed tracing with Jaeger and Kiali ensured deep observability."*

---

### **Key Skills Demonstrated**  
- *"These projects allowed me to showcase my expertise in cloud platforms like AWS, infrastructure as code with Terraform, container orchestration with Kubernetes, and robust CI/CD pipelines. Additionally, I gained hands-on experience with observability tools, logging stacks, and advanced networking with service meshes."*

---

### **Conclusion**  
End by connecting your experience to the role you're applying for:  
*"I'm confident that the skills and experiences I’ve gained from these projects align perfectly with the requirements of this role. I’m eager to bring the same level of commitment and expertise to your team."*

**Project Overview:**  
I worked on a Kubernetes-based microservices project on Amazon EKS, managing 11 microservices.  

**Key Contributions:**  
- Automated infrastructure with Terraform.  
- Set up CI/CD pipelines using Jenkins, GitHub Actions, and ArgoCD.  
- Implemented monitoring with Prometheus and Grafana, and centralized logging with EFK.  
- Enhanced observability using Jaeger and Kiali for tracing.  
- Deployed Istio as a service mesh for traffic management and security.  

**Outcome:**  
The project improved system scalability, observability, and deployment efficiency.  










# Deployment Methods
1. Manual Deployment → Manually copying files or running scripts.
2. Automated Deployment → Using CI/CD tools like GitHub Actions, Jenkins, or ArgoCD.
3. Rolling Deployment → Updating services gradually to avoid downtime.
4. Blue-Green Deployment → Running two versions (Blue = old, Green = new) to ensure zero-downtime.
5. Canary Deployment → Deploying to a small percentage of users before full rollout.







