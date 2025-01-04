# Day-4
# Terraform vairable precedence
    1️⃣ **Environment Variables (`TF_VAR_`)**  
    2️⃣ **Command-Line Flags (`-var` or `-var-file`)**  
    3️⃣ **Terraform.tfvars or .auto.tfvars**  
    4️⃣ **Variable Definition Files (`*.tfvars`)**  
    5️⃣ **Default Value in Configuration (`variable` block)**  
---

### **Terraform Variable Precedence**

Terraform allows you to define variables in different ways, and it uses a predefined order to determine which value to use when multiple sources provide a value for the same variable. Here’s the precedence order from highest to lowest:

---

### **1️⃣ Environment Variables (`TF_VAR_`)**

   - **Concept:**  
     Environment variables take the highest precedence. You can set variables using the prefix `TF_VAR_` followed by the variable name. This method is useful for passing variables into Terraform from the environment where Terraform is running, such as during CI/CD pipelines or local shell sessions.
   
   - **Example:**  
     To set the `instance_type` variable using an environment variable, you would use:
   ```bash
   export TF_VAR_instance_type="t2.micro"
   ```
   - **Usage:**  
     This value will override all other variable sources below it, including `-var`, `-var-file`, `terraform.tfvars`, and the default in the `variable` block.

---

### **2️⃣ Command-Line Flags (`-var` or `-var-file`)**

   - **Concept:**  
     When running Terraform commands, you can specify values for variables using the `-var` flag or by specifying a variable file with `-var-file`. These command-line arguments are evaluated after environment variables, but before `.tfvars` files.
   
   - **Examples:**
     - Using `-var` flag:
       ```bash
       terraform apply -var="instance_type=t2.micro"
       ```
     - Using `-var-file` to specify a file:
       ```bash
       terraform apply -var-file="prod.tfvars"
       ```
     - The `-var-file` method allows you to load a file containing multiple variable assignments (typically `.tfvars` files).

---

### **3️⃣ `terraform.tfvars` or `.auto.tfvars`**

   - **Concept:**  
     Terraform automatically loads any `terraform.tfvars` or `.auto.tfvars` files in the working directory. These files contain variable assignments and are loaded automatically by Terraform.
   
   - **Example:**
     ```hcl
     # terraform.tfvars
     instance_type = "t2.micro"
     ```
     - You don’t need to specify the `-var-file` flag if the `.tfvars` file is named `terraform.tfvars` or ends in `.auto.tfvars`; Terraform will load them automatically.

---

### **4️⃣ Variable Definition Files (`*.tfvars`)**

   - **Concept:**  
     Any other `.tfvars` files that you manually specify using the `-var-file` flag are evaluated after `terraform.tfvars` and `.auto.tfvars`, but before the `variable` block's default value.
   
   - **Example:**
     ```bash
     terraform apply -var-file="custom_vars.tfvars"
     ```
     - In this case, the values in `custom_vars.tfvars` would be used. You can have multiple `.tfvars` files, and you can specify them in any order.

---

### **5️⃣ Default Value in Configuration (`variable` block)**

   - **Concept:**  
     The default values in the `variable` block are used when no value is provided through the higher precedence methods (like environment variables, command-line flags, or `.tfvars` files). These default values are specified in the configuration file itself.
   
   - **Example:**
     ```hcl
     variable "instance_type" {
       type    = string
       default = "t2.micro"
     }
     ```
     - If no other value is set through the methods mentioned above, Terraform will fall back to using the default value defined in the `variable` block.

---

### **Summary of Precedence Order (Highest to Lowest)**

1. **Environment Variables (`TF_VAR_`)**  
   - Environment variables override all other sources.
2. **Command-Line Flags (`-var`, `-var-file`)**  
   - Values provided via command-line flags take precedence over `.tfvars` files and default values.
3. **`terraform.tfvars` or `.auto.tfvars`**  
   - Automatically loaded `.tfvars` files are used unless overridden by command-line flags or environment variables.
4. **Variable Definition Files (`*.tfvars`)**  
   - Manually specified `.tfvars` files are considered after `.auto.tfvars` files.
5. **Default Value in `variable` Block**  
   - Default values are used if no other value is provided.

