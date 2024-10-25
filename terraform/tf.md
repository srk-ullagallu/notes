Here are examples of each Terraform block, function, and concept, along with a brief comparison between `for_each` and `count`.

---

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
  instance_type = var.is_production ? "t3.medium" : "t2.micro"
  ami           = "ami-0c55b159cbfafe1f0"
}
```

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

---

### **Difference Between `for_each` and `count`**

- **`count`**: Suitable for creating multiple instances of a resource in a simple list (e.g., `count = 3`). Instances are referenced by index (e.g., `aws_instance.example[0]`).
  
- **`for_each`**: Better for working with maps or sets, allowing instances to be identified by keys (e.g., `each.key`). More flexible than `count`, it enables configurations where resources are identified by meaningful names (e.g., `aws_instance.example["web"]`).

