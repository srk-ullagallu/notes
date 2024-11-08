# 06-05-2024

**Infrastructure Components**: Servers, network, storage, database, load balancer, auto-scaling group.

**Manual Approach**:
- Time-consuming
- Follow sequence: VPC → SG → EC2 → DB
- Error-prone
- Manual inventory maintenance
- Difficult to replicate across environments
- No cost analysis

**Infrastructure as Code (IaC)**:
- **Benefits**:
  - Versioning
  - Collaboration
  - Code review
  - Replication across environments
  - CRUD operations
  - Cost analysis
  - Code reuse with modules
  - State file management
  - Cloud agnostic
  - Automatic dependency resolution
- **Terraform**:
  - Uses HCL for defining resources
  - **Components**:
    - Provider
    - Variables
    - Outputs
    - Resources
  - **Commands**:
    - `init`: Download plugins
    - `init -reconfigure`
    - `init upgrade`
    - `fmt`: Format code
    - `validate`: Check syntax
    - `plan`: List resources to create
    - `apply`: Create resources
    - `destroy`: Delete resources
  - **Data Types**:
    - `string`, `list`, `map`, `number`


**Quiz**:
1. Ansible communication: SSH
2. Ansible playbook: List of tasks
3. Ansible role: Predefined tasks, files, variables
4. Ansible inventory file: Hosts and groups
5. Include variable file: `vars_file: myvars.yaml`
6. Vault in Ansible: Encrypt data
7. Task condition: `when`
8. Remove user: `user: name: myuser state: absent`
9. Enable service: `service: name=my_service enabled=yes`
10. Idempotent playbook: Consistent state
11. Configuration management architecture: Push
12. `ignore_errors`: Ignores errors and continues
13. Schedule task: `crontab -e`

# 07-05-2024
### Terraform Functions

1. **`merge()`**: Combines multiple maps into a single map.

2. **`element()`**: Retrieves an element from a list by its index.

3. **`join()`**: Concatenates elements of a list into a single string, separated by a specified delimiter.

4. **`split()`**: Divides a string into a list of substrings based on a specified delimiter.

5. **`length()`**: Returns the size/count of elements in a list or the number of characters in a string.

6. **`concat()`**: Combines multiple strings or lists into a single string or list.

7. **`startswith()`**: Checks if a string starts with a specified prefix, useful for validating string patterns.

8. **`lookup()`**: Retrieves a value from a map using a specified key, with an optional default value if the key does not exist.

**Tagging Strategy**:
1. Resource name
2. Project
3. Module
4. Environment
5. Creator
6. Date

**`terraform.tfvars`**:
1. Use for overriding default values

**Terraform Commands**:
1. `-var="instance_type=t3.medium"`

**Environment Variables**:
1. `export TERRA_VAR<variable_name>=<value>`

**Conditions**:
1. `expression ? <true> : <false>`

**Loops**:
1. `count`, `for`, `dynamic`

**map & block**:

`map={}`   `block {}`


Here’s a well-organized version of your notes for **08-05-2024**:

# 08-05-2024

### Variables
- **Comments:** Add comments when defining variables to clarify their purpose and usage.

### Interpolation
- **Example:** `"Hello, ${var.instance_name}"`
  - Use interpolation to dynamically embed variable values within strings.

### Locals
- **Definition:** Locals are key-value pairs similar to variables.
- **Usage:** Use locals to store expressions or configurations, enhancing readability and reducing repetition.
- **Benefits:** Centralizes calculations and allows referencing variables for more versatile configurations.
- **Note:** `count` and `count.index` cannot be used within a `locals` block.

### Data Sources
- **Purpose:** Query and filter resources using data source blocks in Terraform.
- **Example:** Automatically fetch the latest AMI ID for instances.
- **Collaboration:** Facilitates integration by allowing teams to use resources managed by others, avoiding duplication of effort.


# 09-05-2024: Terraform State Management and Best Practices

#### **Terraform Overview**
- **Terraform**: Infrastructure as Code (IaC) tool that uses a **Declarative** approach.
- **Declarative**: Define the desired state of infrastructure, and Terraform will ensure that the actual state matches this.
- **Imperative vs. Declarative**: 
  - **Shell**: Imperative, specifying exact commands to achieve a result.
  - **Terraform**: Declarative, specifying *what* should be created, not *how*.

#### **Idempotency**
- **Idempotent**: Running Terraform scripts multiple times will result in the same infrastructure state without creating duplicates or errors.

#### **State Management**
- **Declared State**: Defined in Terraform files.
- **Actual State**: Resources managed by the provider (e.g., AWS).
- **State File**: `terraform.tfstate` tracks the actual infrastructure.

**Workflow:**
1. **Initial Run**: Terraform compares the declared state with the actual state and creates resources as needed.
2. **Subsequent Runs**: Terraform detects changes by comparing the state file to the declared state.
   - **No Changes**: Terraform will output "No changes are required."
   - **Drift Detection**: If resources are manually deleted or modified outside Terraform, running `terraform plan` or `terraform apply` will refresh the state file and detect these changes.

#### **Local vs. Remote State**
- **Local State**:
  - **Potential Issues**:
    - Duplicate resources if multiple users modify the local state.
    - Inconsistencies across infrastructure due to local changes.

- **Remote State**:
  - **Benefits**:
    - **Storage**: State file is stored in a remote location like S3.
    - **Locking**: Prevents concurrent modifications by using a DynamoDB table with a LockID.
    - **Versioning**: Track changes by storing versions in S3.
    - **Collaboration**: Enables multiple users to work on the same infrastructure without conflicts.

#### **Best Practices**
- **Use `count` with Lists**: Efficiently manage multiple similar resources.
- **Use `for_each` with Maps**: Iterate over complex data structures.
- **Access Elements**:
  - `each.key` and `each.value` for accessing map elements in `for_each`.
- **Dynamic Blocks**: Use within resources to loop and create configurations dynamically.


# 10-05-2024


### S3 Backend for Terraform

#### **Multiple Buckets for Different Environments**
- **Recommendation**: Use different S3 buckets for different environments (e.g., dev, qa, prod) to maintain isolation and avoid conflicts.

#### **Terraform Workspaces**
- **Purpose**: Allows you to use the same Terraform code for different environments by creating isolated workspaces.
- **Functionality**: Each workspace maintains its own state file, so changes in one environment do not affect others.
- **Advantages**:
  - **Less Code**: Use the same configuration across environments with different workspaces.
- **Disadvantages**:
  - **Caution Required**: Greater risk of errors if variables and `tfvars` files are not handled carefully, especially in production environments.

#### **Provisioners**
- **Types**:
  1. **`local-exec`**:
     - **Purpose**: Executes commands on the local machine where Terraform is running.
     - **Use Case**: Ideal for scripts or commands that need to be run locally during resource creation.
  2. **`remote-exec`**:
     - **Purpose**: Executes commands on the remote machine that Terraform is provisioning.
     - **Use Case**: Suitable for configuring resources once they are created.

- **Behavior**:
  - Provisioners run **during resource creation** but do not re-run after the resource has been created.
  - They are intended for post-creation configuration or setup tasks.

#### **Best Practices**
- **Separate Repositories**: Consider using different repositories for each environment to further isolate configurations and manage changes more effectively.


# Notes for 14-05-2024

#### What is a Module?

A module is a reusable, self-contained unit of code that defines a set of resources in Terraform. It helps in organizing and managing infrastructure code efficiently.

#### Module Development
**DRY Principle: Don't Repeat Yourself**

- **Code Reuse**: Modules allow you to reuse code across different projects or environments, reducing redundancy.
- **Best Practices**: Encapsulates best practices, ensuring they are consistently applied.
- **Maintainability**: Simplifies updates and maintenance by isolating changes to one place.
- **Guidelines**: Modules can enforce company-specific standards and restrictions.

**Roles**:
- **Module Developers**: Create Terraform code with best practices.
- **Module Users**: Utilize the pre-defined modules in their projects.

# 16-05-2024
1. Use `sudo find / -user <username> -type f -exec du -ch {} + | grep total$` to find total disk space used by a user.

2. Use `sudo lsof -i :<port>` to identify the process listening on a specific port.

3. Terraform modules are a collection of Terraform resources grouped together.



















# 22-05-2024
- For each and every module have seperate git repo there

state == storage

very difficult to retrieve data from stateful app

HA,LB,Backup cloud responsibility in RDS

# 23-05-2024
In AWS for managed services there is no SSH connection

# ["id1","id2"] terraform format
# id1,id2 aws format

1. join() [convert list to string list]
2. split() [convert stringlist to list]
3. element() [get the value based on index in list]

# 24-05-2024

Client
Delivery Manager
Team Leads
Team Memebers
HTTP response codes

# 27-05-2024

Deployment:
  stop the server
  remove old code
  download the new code
  restart the server

  there is downtime from stop to start the server

# 28-05-2024

Project Architecture
App Architecture

openvpnas = username

openvpn

How can i calucalted each and every componet billing using tags

# 29-05-2024

`userdata` once ec2 instance created aws will run userdata script

1. we have to login inside instance and check the logs of userdata
2. once userdata is changed aws will not update EC2


`null resource` will not create any resource unlike other resources aws_instance aws_vpc this was used to exectue provisioners like local-exec and remote-exec


# 30-05-2024
Bench Mark testing and load testing was decided by architects 
# 31-05-2024
HTTP methods
# 03-06-2024
*ShiftLeft*
- clone
- compile
- unit testing
- Scans
  - sonarqube[source code analysis]
  - owasp[libs scan]
  - SAST
  - DAST
- Docker build
- Deploy to Dev
- Functional Testing

- Do in Dev Instead of Prod

- We implemented ShiftLeft In devops project
- Istead of Quality checking, scans in prod we do it in early stage

GitOps --> Everything should be inside git no manual process




