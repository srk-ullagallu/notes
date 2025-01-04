# Day-3
# Terraform commands
   - init
   - fmt
   - validate
   - plan
   - apply
   - destroy
   - state list
   - import
### **1. `terraform init`**
   - **Purpose:**  
     Initializes the working directory for Terraform. This command downloads the necessary provider plugins and sets up the backend configuration.
   - **Use Case:**  
     Run this command when you first start working with a Terraform configuration or when you add new provider dependencies.
   - **Example:**
   ```bash
   terraform init
   ```
   - This command must be run before any other Terraform commands to set up your working environment.

---

### **2. `terraform fmt`**
   - **Purpose:**  
     Formats the Terraform configuration files according to Terraform’s style conventions, improving readability.
   - **Use Case:**  
     You can use this command to automatically format `.tf` files to maintain consistency in the code.
   - **Example:**
   ```bash
   terraform fmt
   ```
   - This will format all `.tf` files in the current directory and subdirectories.

---

### **3. `terraform validate`**
   - **Purpose:**  
     Validates the Terraform configuration files to ensure they are syntactically correct and that there are no obvious errors.
   - **Use Case:**  
     Use this command to check if the configuration is ready to be applied.
   - **Example:**
   ```bash
   terraform validate
   ```
   - This command checks if your `.tf` files are syntactically valid, but it doesn’t connect to any cloud provider or validate the resources.

---

### **4. `terraform plan`**
   - **Purpose:**  
     Creates an execution plan, showing you what actions Terraform will take to achieve the desired state (based on your configuration and current state).
   - **Use Case:**  
     Before applying any changes, you can run `terraform plan` to review the changes Terraform will make (e.g., which resources will be created, updated, or destroyed).
   - **Example:**
   ```bash
   terraform plan
   ```
   - The output will show what changes are going to be made to your infrastructure, and you can confirm whether those changes are what you intended before applying them.

---

### **5. `terraform apply`**
   - **Purpose:**  
     Applies the changes required to reach the desired state of the configuration, making the changes to your infrastructure.
   - **Use Case:**  
     After reviewing the plan, you can run `terraform apply` to actually implement the changes.
   - **Example:**
   ```bash
   terraform apply
   ```
   - Terraform will prompt for confirmation before applying the changes. You can also specify the `-auto-approve` flag to skip confirmation.

---

### **6. `terraform destroy`**
   - **Purpose:**  
     Destroys the infrastructure managed by Terraform, effectively tearing down the resources you have provisioned.
   - **Use Case:**  
     When you no longer need the infrastructure (e.g., when cleaning up test environments), use this command to remove all resources.
   - **Example:**
   ```bash
   terraform destroy
   ```
   - This command will prompt for confirmation before destroying the resources. You can skip confirmation by using the `-auto-approve` flag.

---

### **7. `terraform state list`**
   - **Purpose:**  
     Lists all the resources that are managed by Terraform in the current state file. This command helps you view what resources Terraform is currently aware of.
   - **Use Case:**  
     Use this command to see the resources Terraform has created and is currently managing.
   - **Example:**
   ```bash
   terraform state list
   ```
   - This will list all the resources that exist in the state file. You can use this list for resource-specific commands (like `terraform state show`).

---

### **8. `terraform import`**
   - **Purpose:**  
     Imports an existing resource into Terraform management. This is useful when you want to manage an existing infrastructure that was created manually or by another tool.
   - **Use Case:**  
     Use `terraform import` to import resources that are already provisioned outside of Terraform (e.g., a manually created EC2 instance) into Terraform’s state management.
   - **Example:**
   ```bash
   terraform import aws_instance.example i-1234567890abcdef0
   ```
   - In this example, you import an existing EC2 instance (with ID `i-1234567890abcdef0`) into Terraform’s state, and it will now be managed by Terraform as `aws_instance.example`.
