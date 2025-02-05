### **1️⃣ Latency**  
📌 **Definition**: Time taken for a request to travel from source to destination and back.  
📌 **Types**:  
   - **Network Latency** (time for data to travel over the network)  
   - **Disk Latency** (time for storage I/O operations)  
   - **Application Latency** (processing delay in app logic)  

✅ **AWS Example**:  
- Use **AWS Global Accelerator** to reduce network latency by routing traffic to the nearest AWS edge location.  
- Enable **CloudFront caching** for static content to reduce page load times.  

---

### **2️⃣ Throughput**  
📌 **Definition**: The amount of data that can be processed in a given time (measured in Mbps, RPS, or transactions per second).  

✅ **AWS Example**:  
- **EBS Provisioned IOPS** volumes provide high throughput for databases.  
- **Amazon Kinesis** handles high-throughput streaming data ingestion.  

---

### **3️⃣ IOPS (Input/Output Operations Per Second)**  
📌 **Definition**: Measures storage performance in terms of read/write operations per second.  
📌 **Formula**: `IOPS = Total IO operations / Time (seconds)`  

✅ **AWS Example**:  
- **Amazon EBS gp3** (General Purpose SSD) allows configuring IOPS separately from storage size.  
- **Provisioned IOPS (io1/io2)** volumes guarantee high IOPS for databases like MySQL and PostgreSQL.  

---

### **4️⃣ Failover**  
📌 **Definition**: The ability to switch to a **backup system** automatically when the primary system fails.  

✅ **AWS Example**:  
- **AWS Route 53 Health Checks** redirect traffic to a backup instance in another region when the primary instance goes down.  
- **Amazon RDS Multi-AZ** provides automatic failover to a standby replica if the primary database instance fails.  

---

### **5️⃣ Fault Tolerance**  
📌 **Definition**: The system’s ability to continue operating even when **components fail**.  
📌 **Difference from High Availability**: Fault tolerance ensures **zero downtime**, whereas high availability minimizes downtime.  

✅ **AWS Example**:  
- **Auto Scaling Groups (ASG)** automatically replace failed EC2 instances.  
- **Multi-Region Disaster Recovery (DR)** strategies in AWS ensure workloads remain operational even if an entire region fails.  

---

### **6️⃣ Fault Injection**  
📌 **Definition**: A testing method that **intentionally introduces failures** to check system resilience.  

✅ **AWS Example**:  
- **AWS Fault Injection Simulator (FIS)** can inject network delays, CPU stress, or instance terminations to test failover mechanisms.  
- **Chaos Engineering** tools like **LitmusChaos** for Kubernetes test resilience under failures.  

---

### **7️⃣ Redundancy**  
📌 **Definition**: Duplication of components to increase reliability and avoid failures.  

✅ **AWS Example**:  
- **Amazon S3 stores data redundantly** across multiple Availability Zones.  
- **EBS Snapshots** provide data redundancy for disaster recovery.  

---

### **8️⃣ High Availability (HA)**  
📌 **Definition**: Ensuring a system is **operational with minimal downtime**. Typically achieved through redundancy, load balancing, and auto-scaling.  

✅ **AWS Example**:  
- **AWS Elastic Load Balancer (ALB, NLB)** distributes traffic across multiple EC2 instances for HA.  
- **Multi-AZ RDS Deployment** ensures database HA with automatic failover.  

---

### **9️⃣ Scalability**  
📌 **Definition**: The ability to **increase or decrease** resources to handle demand.  

#### **Horizontal Scaling (Scale-Out & Scale-In)**
✅ Adding or removing instances to increase capacity.  
✅ Preferred for **distributed systems** like Kubernetes, microservices, and stateless applications.  

👉 **Example**:  
- **Auto Scaling Groups (ASG)** scale EC2 instances based on demand.  
- **EKS Cluster Autoscaler** adds or removes nodes dynamically.  

#### **Vertical Scaling (Scale-Up & Scale-Down)**
✅ Increasing or decreasing resources (CPU, RAM) of an existing instance.  
✅ Works for **monolithic apps** or **databases** that can’t easily be distributed.  

👉 **Example**:  
- Upgrading an **EC2 instance** from t3.medium (2 vCPU, 4GB RAM) to m5.large (4 vCPU, 8GB RAM).  
- **Amazon RDS Scaling** allows increasing database instance size (e.g., db.t3.micro → db.m5.large).  

---

### **🔟 Durability**  
📌 **Definition**: The ability to **preserve data over time** without loss.  

✅ **AWS Example**:  
- **Amazon S3** provides **99.999999999% (11 9s) durability**, meaning data loss is extremely rare.  
- **EBS Snapshots & S3 Cross-Region Replication** provide additional durability for backups.  

---

### **1️⃣1️⃣ Reliability**  
📌 **Definition**: The ability of a system to **function correctly over time** without failure.  

✅ **AWS Example**:  
- **AWS Well-Architected Framework** provides reliability best practices.  
- **DynamoDB offers 99.99% reliability** with automatic replication.  

---

### **1️⃣2️⃣ Performance**  
📌 **Definition**: The speed and efficiency of a system.  

✅ **AWS Example**:  
- **Amazon CloudFront** improves performance by caching content at edge locations.  
- **AWS Nitro System** improves EC2 performance by offloading virtualization tasks.  

---

### **1️⃣3️⃣ Cost Optimization**  
📌 **Definition**: Reducing cloud costs while maintaining performance and availability.  

✅ **AWS Example**:  
- **EC2 Spot Instances** reduce compute costs by up to 90%.  
- **S3 Intelligent-Tiering** automatically moves infrequently accessed data to cheaper storage.  
- **AWS Compute Savings Plans** provide discounts on long-term EC2 usage.  

---

## **📌 Summary Table**
| Concept | Definition | AWS Example |
|---------|-----------|-------------|
| **Latency** | Response time for a request | AWS Global Accelerator, CloudFront |
| **Throughput** | Data processed per second | EBS, Kinesis |
| **IOPS** | Storage speed (reads/writes per sec) | EBS gp3, Provisioned IOPS |
| **Failover** | Auto-switching to backup system | Route 53 Health Checks, RDS Multi-AZ |
| **Fault Tolerance** | System operates despite failure | Auto Scaling, Multi-Region DR |
| **Fault Injection** | Simulating failures for testing | AWS FIS, Chaos Engineering |
| **Redundancy** | Duplicating components | S3 Cross-Region Replication |
| **High Availability** | Minimal downtime | ALB, Multi-AZ RDS |
| **Scalability** | Expanding/shrinking capacity | Auto Scaling, RDS Scaling |
| **Durability** | Long-term data retention | S3 (11 9s durability), EBS Snapshots |
| **Reliability** | Consistent operation over time | DynamoDB, AWS Well-Architected Framework |
| **Performance** | Speed & efficiency | AWS Nitro, CloudFront |
| **Cost Optimization** | Reducing costs efficiently | EC2 Spot Instances, Savings Plans |

---

### **🚀 Next Steps for You**
✅ Implement **Auto Scaling & Load Balancing** in your projects.  
✅ Use **AWS Cost Optimization Tools** like Compute Savings Plans & S3 Lifecycle Policies.  
✅ Experiment with **AWS Fault Injection Simulator** for failure testing.  
