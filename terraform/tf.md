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
