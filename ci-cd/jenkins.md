### **What is Jenkins?**
Jenkins is an open-source automation server used to implement Continuous Integration (CI) and Continuous Delivery (CD). It automates building, testing, and deploying applications and supports integration with various tools through plugins.

---

### **Advantages**:
- **Free and Open Source**: Cost-effective.
- **Extensible**: Large plugin ecosystem for integrations.
- **Cross-Platform**: Runs on multiple OS.
- **Scalable**: Supports distributed builds.
- **Community Support**: Active community for troubleshooting.

### **Disadvantages**:
- **Maintenance Overhead**: Requires manual setup and updates.
- **Complexity**: Can be challenging to manage in large-scale environments.
- **Resource Intensive**: High resource usage with complex pipelines.

---

### **Jenkins Master-Slave Setup**
- **Master**: Handles job scheduling, UI, and job distribution.
- **Slave (Agent)**: Executes jobs assigned by the master.

---

### **Benefits of Master-Slave Setup**:
1. **Scalability**: Distributes workloads across multiple nodes.
2. **Performance**: Offloads job execution to slaves, freeing up master resources.
3. **Flexibility**: Run different jobs on specific agents tailored to the environment.
4. **Fault Tolerance**: Isolates failures to individual agents without affecting the master.
