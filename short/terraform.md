# Configuration Drift
Configuration Drift - A situation where the actual infrastructure configuration differs from the desired or defined state over time.

Causes of Configuration Drift:
- Manual changes in infrastructure
- Untracked updates outside automation tools
- Software updates or patches applied inconsistently

How to Prevent Configuration Drift:
- Use Infrastructure as Code (IaC) tools like Terraform, Ansible, or CloudFormation
- Implement CI/CD pipelines for consistent deployments
- Regularly perform drift detection using tools like Terraform plan, AWS Config, or Ansible --check
- Enforce immutable infrastructure, replacing resources instead of modifying them
