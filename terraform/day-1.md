# Day-1
### Before IAC
### After IAC
### What is Terraform and it's features

### Without IaC (Manual Infrastructure Management)
- **Provisioning**: Infrastructure is manually set up through the AWS console, CLI, or other cloud providers' interfaces.
- **Consistency**: There's a high risk of inconsistency across environments (development, staging, production) as configurations are manually applied.
- **Reusability**: Difficult to replicate the same infrastructure setup in different environments or regions. Any change requires manual intervention.
- **Error-prone**: Human error is more likely because steps are done manually.
- **Scaling**: Scaling infrastructure is slow and prone to mistakes since it requires manual intervention every time.
- **Auditability**: Tracking changes can be challenging since there are no clear records of changes made to the infrastructure.

### With IaC (Infrastructure as Code)
- **Provisioning**: Infrastructure is defined in code, typically in configuration files (e.g., JSON, YAML, or HCL for Terraform). This allows you to automate provisioning, reducing manual effort.
- **Consistency**: Code can be version-controlled and shared, ensuring that environments (development, staging, production) are identical.
- **Reusability**: You can reuse the same code to provision infrastructure in multiple environments or regions, providing better consistency and scalability.
- **Error-free**: Automation reduces human error, ensuring that infrastructure setup is done in a predictable manner.
- **Scalability**: You can easily scale infrastructure up or down by modifying the code and applying changes. This is faster and less error-prone.
- **Auditability**: With IaC, changes are tracked in version control systems (like Git), providing a clear record of who made what change and when.

### With Terraform (Specifically)
- **Declarative Language**: Terraform uses HCL (HashiCorp Configuration Language) to define infrastructure. You describe what you want, and Terraform figures out how to achieve it.
- **State Management**: Terraform keeps track of the current state of infrastructure, making it easy to manage and update.
- **Multi-cloud**: Terraform supports multiple cloud providers (AWS, GCP, Azure) and allows you to define infrastructure across different environments.
- **Plan & Apply**: You can run `terraform plan` to see what changes will be made before actually applying them, reducing the risk of unintended changes.
- **Idempotence**: Running the same Terraform script multiple times ensures the infrastructure matches the defined state, regardless of changes that may have occurred.
- **Modularity**: You can use modules in Terraform to reuse common configurations across projects and environments.
- **Collaboration**: Terraform allows teams to collaborate on infrastructure definitions and track changes through version control.

