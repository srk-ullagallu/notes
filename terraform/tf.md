### 1. **Resource Block**
Defines a resource to be created, such as an EC2 instance.

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

---

### 2. **Variable Block**
Declares inputs that can be used across your configuration.

```hcl
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}
```

---

### 3. **Output Block**
Displays values after the Terraform apply phase.

```hcl
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
```

---

### 4. **Local Block** (with expressions)
Defines local values, often using expressions to simplify calculations or complex configurations.

```hcl
locals {
  env_prefix    = "dev"
  instance_name = "${local.env_prefix}-instance"
  subnet_id     = "subnet-abc123"
}
```

---

### 5. **Data Block**
Fetches data from existing resources, useful when you need details about something outside of your configuration.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

---

### 6. **Dynamic Block**
Creates nested blocks dynamically based on a list or map.

```hcl
resource "aws_security_group" "example" {
  name = "example-sg"

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

---

### **Functions**

### 7. **count**
Used to create multiple instances of a resource. Suitable for simple list-based configurations.

```hcl
resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

---

### 8. **for_each**
Creates instances for each item in a map or set, enabling more granular control and named instances.

```hcl
resource "aws_instance" "example" {
  for_each      = { web = "t2.micro", app = "t2.small", db = "t2.medium" }
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value
  tags = {
    Name = each.key
  }
}
```

---

### 9. **Conditional Expression (ternary operator)**
Inline conditions, often used to set values based on a condition.

```hcl
resource "aws_instance" "example" {
  instance_type = var.is_production == frontend ? "t3.medium" : "t2.micro"
  ami           = "ami-0c55b159cbfafe1f0"
}
```

var "is_production"{
  default = ["frontend,"backend","db"]
}

---

### 10. **Using `.tfvars`**
You can define variable values in a `.tfvars` file, commonly named `terraform.tfvars`, for automatic loading during execution.

**terraform.tfvars**
```hcl
instance_count = 3
is_production  = true
```

**main.tf**
```hcl
variable "instance_count" { type = number }
variable "is_production" { type = bool }
```
### 1. `count`
- **Purpose**: Creates a specific number of identical resource instances.
- **Usage**: It’s ideal when you know the exact number of resources needed and don't need to assign unique keys to each instance.
- **Index-Based**: Resources are accessed via index (e.g., `aws_instance.example[0]`).
- **Limitations**: Less flexible than `for_each` because it doesn’t support mapping with custom keys.

#### Example
Creating 3 identical EC2 instances:
```hcl
resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-123456"
  instance_type = "t2.micro"
}

# Access example:
# aws_instance.example[0], aws_instance.example[1], aws_instance.example[2]
```

### 2. `for_each`
- **Purpose**: Creates instances based on a map or set of unique keys.
- **Usage**: Preferred when you need more control over each instance, especially if each one has unique identifiers or configurations.
- **Key-Based**: Resources are accessed via a unique key (e.g., `aws_instance.example["web"]`).
- **Flexible**: Ideal for creating resources with different configurations, based on input maps or sets.

#### Example
Creating instances with specific names:
```hcl
resource "aws_instance" "example" {
  for_each = {
    web    = "ami-123456"
    db     = "ami-234567"
    backend = "ami-345678"
  }

  ami           = each.value
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}

# Access example:
# aws_instance.example["web"], aws_instance.example["db"], aws_instance.example["backend"]
```

### Key Differences
| Feature            | `count`                          | `for_each`                           |
|--------------------|----------------------------------|--------------------------------------|
| **Input**          | Integer                          | Map or Set                           |
| **Access**         | Index-based `[0]`                | Key-based `["key"]`                  |
| **Use Case**       | Identical instances              | Instances with unique attributes     |
| **Modification**   | Reordering causes recreation     | Keys remain stable, fewer changes    |
| **Flexibility**    | Limited customization            | Highly customizable per instance     |

=======
# Access example:
# aws_instance.example[0], aws_instance.example[1], aws_instance.example[2]
```

### 2. `for_each`
- **Purpose**: Creates instances based on a map or set of unique keys.
- **Usage**: Preferred when you need more control over each instance, especially if each one has unique identifiers or configurations.
- **Key-Based**: Resources are accessed via a unique key (e.g., `aws_instance.example["web"]`).
- **Flexible**: Ideal for creating resources with different configurations, based on input maps or sets.

#### Example
Creating instances with specific names:
```hcl
resource "aws_instance" "example" {
  for_each = {
    web    = "ami-123456"
    db     = "ami-234567"
    backend = "ami-345678"
  }

  ami           = each.value
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}

# Access example:
# aws_instance.example["web"], aws_instance.example["db"], aws_instance.example["backend"]
```

### Key Differences
| Feature            | `count`                          | `for_each`                           |
|--------------------|----------------------------------|--------------------------------------|
| **Input**          | Integer                          | Map or Set                           |
| **Access**         | Index-based `[0]`                | Key-based `["key"]`                  |
| **Use Case**       | Identical instances              | Instances with unique attributes     |
| **Modification**   | Reordering causes recreation     | Keys remain stable, fewer changes    |
| **Flexibility**    | Limited customization            | Highly customizable per instance     |

**Summary**: Use `count` when creating identical resources based on a number, and use `for_each` when you need unique instances with individual attributes.



### Difference between ansible and terraform

Here's a brief comparison of **Ansible** and **Terraform**:

### 1. **Purpose and Use Case**:
   - **Ansible**: Primarily a configuration management tool. It automates the setup, configuration, and management of systems (e.g., installing packages, updating configuration files, managing services).
   - **Terraform**: An infrastructure provisioning tool. It focuses on building, changing, and versioning infrastructure safely and efficiently (e.g., creating virtual machines, setting up networks, and managing cloud resources).

### 2. **How They Work**:
   - **Ansible**: Uses **agents**-less architecture, executing tasks over SSH or using WinRM. It uses a declarative approach but is procedural in task execution.
   - **Terraform**: Uses a **declarative** approach. You define the desired end state of infrastructure, and Terraform determines the steps needed to achieve that state.

### 3. **State Management**:
   - **Ansible**: Stateless. It doesn't maintain a state file. It executes tasks and relies on the current status of the system to know if changes are needed.
   - **Terraform**: Maintains a **state file** that keeps track of the current state of infrastructure. This state file is essential for managing updates and changes efficiently.

### 4. **Idempotency**:
   - **Ansible**: Idempotency is achieved through carefully crafted playbooks. If designed well, tasks will only make changes when necessary.
   - **Terraform**: Built-in idempotency. It ensures that the desired infrastructure state is maintained automatically.

### 5. **Main Use Cases**:
   - **Ansible**: Configuration management, application deployment, orchestration of software configurations.
   - **Terraform**: Provisioning infrastructure on cloud platforms like AWS, Azure, GCP, and managing resources like VMs, networking, and databases.

### 6. **Language**:
   - **Ansible**: Uses **YAML** for writing playbooks.
   - **Terraform**: Uses **HCL** (HashiCorp Configuration Language).

### 7. **Execution**:
   - **Ansible**: Executes tasks sequentially on target machines and can handle ad-hoc tasks easily.
   - **Terraform**: Plans infrastructure changes and then applies them in a calculated manner, showing what will change before actually doing it.

### 8. **Agent Requirements**:
   - **Ansible**: **Agentless**. Only requires Python and SSH on the managed nodes.
   - **Terraform**: Also **agentless**, but it interacts directly with cloud providers' APIs to manage resources.

### **Summary**:
- **Ansible** is best for configuration management, while **Terraform** is ideal for infrastructure provisioning.
- They complement each other well: you can use Terraform to set up infrastructure and Ansible to configure it. 


### Declarative

**Declarative** refers to a programming or configuration approach where you specify *what* you want to achieve, not *how* to achieve it. 

### Key Points:
1. **Focus on Desired State**: In a declarative model, you define the desired state or end result, and the system handles the process to get there. 
   - Example: In infrastructure provisioning, you specify that you need a virtual machine with a certain configuration, and the tool (like Terraform) takes care of the steps needed to create and configure it.

2. **Simplified Management**: You don't have to outline the exact steps or procedures to reach the end state. This simplifies management and reduces the risk of errors.

3. **Examples**:
   - **Terraform**: You write code to define the desired infrastructure, like specifying that you want an EC2 instance in AWS. Terraform determines the sequence of actions to make that happen.
   - **Kubernetes**: You declare the desired state of your applications (e.g., how many replicas you want running), and Kubernetes ensures that this state is maintained.

### **Declarative vs. Imperative**:
- **Declarative**: Focuses on *what* you want.
  - Example: "Ensure there are 3 web servers running."
- **Imperative**: Focuses on *how* to achieve it.
  - Example: "Create a server, configure it, install the web server software, and repeat this process two more times."

### **Benefits of Declarative Approach**:
1. **Simplicity**: Easier to read and write because it abstracts the procedural details.
2. **Idempotency**: Re-running the configuration will not result in unintended changes because the desired state is always maintained.
3. **Automation-Friendly**: Well-suited for automation tools, which can ensure the system always matches the declared state.

