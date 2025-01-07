# Day-1
### **Manual Infrastructure Provisioning Problems:**  
- Time-consuming and error-prone.  
- Inconsistent configurations across environments.  
- Difficult to scale and reproduce setups.  
- Lack of version control and collaboration.  

---

### **How IaC Solves These Issues:**  
- **Automation:** Reduces manual effort.  
- **Consistency:** Ensures uniform environments.  
- **Version Control:** Tracks changes via Git.  
- **Scalability:** Easily scales resources.  
- **Repeatability:** Infrastructure can be recreated reliably.  

---

### **What is Terraform?**  
- An **Infrastructure as Code (IaC)** tool by **HashiCorp**.  
- Manages and provisions infrastructure using **declarative configuration files**.  

**Key Features:**  
- **Platform Agnostic:** Supports multiple cloud providers (AWS, Azure, GCP).  
- **Declarative Syntax:** Define *"what"* you want, not *"how"*.  
- **State Management:** Tracks resource states in a state file.  
- **Modularity:** Reuse code with modules.  
- **Immutable Infrastructure:** Changes replace existing infra instead of modifying it.  


### 🚀 **Manual Infrastructure Provisioning Problems:**  
1. **Time-Consuming:** Setting up servers, networks, and storage manually takes significant time and effort.  
2. **Error-Prone:** Human errors in configuration can cause failures or inconsistencies.  
3. **Inconsistent Environments:** Hard to ensure the same setup across development, staging, and production.  
4. **Scalability Challenges:** Manually scaling resources is inefficient and slow.  
5. **No Version Control:** Hard to track changes and roll back to previous stable states.  

---

### ⚙️ **How Infrastructure as Code (IaC) Solves These Issues:**  
1. **Automation:** Tasks like provisioning, scaling, and configuring infrastructure are automated.  
2. **Consistency:** Uniform setups across all environments ensure stability.  
3. **Version Control:** Configuration files can be stored in **Git**, enabling tracking and rollback.  
4. **Scalability:** Resources can be scaled up or down quickly with simple configurations.  
5. **Repeatability:** Infrastructure can be recreated anytime using the same configuration files.  
6. **Collaboration:** Teams can collaborate better by sharing configuration files.  

---

### 🛠️ **What is Terraform?**  
- **Terraform** is an **open-source Infrastructure as Code (IaC) tool** developed by **HashiCorp**.  
- It uses **declarative configuration files** to define and manage infrastructure across **cloud providers** (e.g., AWS, Azure, GCP) and **on-premises solutions**.  

**✨ Key Features of Terraform:**  
1. **Platform Agnostic:** Supports multiple cloud providers and services.  
2. **Declarative Syntax:** You define *what* infrastructure should look like, and Terraform handles *how* to achieve it.  
3. **State Management:** Tracks infrastructure state using a **state file** (`terraform.tfstate`).  
4. **Modularity:** Use **modules** to create reusable infrastructure components.  
5. **Immutable Infrastructure:** Changes often involve replacing resources instead of modifying them, reducing drift and inconsistency.  
6. **Plan and Apply:** `terraform plan` shows changes before applying them with `terraform apply`.  



