### ELB (Elastic Load Balancer) Components in AWS

AWS Elastic Load Balancer (ELB) is a fully managed service that automatically distributes incoming traffic across multiple targets, such as EC2 instances, containers, and IP addresses. AWS offers **three main types of ELBs**: **Application Load Balancer (ALB)**, **Network Load Balancer (NLB)**, and **Classic Load Balancer (CLB)**.

Each type of ELB has its components and use cases:

---

### 1. **Application Load Balancer (ALB)** – Layer 7 Load Balancer  
- **Purpose**: Designed for content-based routing and advanced request routing. Ideal for web applications.
- **Components**:
  
1. **Listeners**  
   - Define the protocol and port on which the ALB listens for incoming traffic (HTTP, HTTPS).
   - Can route requests to multiple target groups.

2. **Target Groups**  
   - Group of targets (EC2 instances, containers, IP addresses) to which requests are routed.
   - Supports **Health Checks** to monitor target availability.

3. **Rules**  
   - Provide request routing logic based on **URL path**, **HTTP header**, and **host conditions**.

4. **Security Groups**  
   - Control inbound and outbound traffic to the ALB.
  
5. **DNS Name**  
   - ALBs have a public DNS name (e.g., `my-alb-123456789.us-west-2.elb.amazonaws.com`) which is registered in Route 53.

---

### 2. **Network Load Balancer (NLB)** – Layer 4 Load Balancer  
- **Purpose**: Designed for high performance and TCP/UDP traffic. Ideal for TCP-heavy workloads and low latency applications.
- **Components**:

1. **Listeners**  
   - Define the port and protocol (TCP/UDP) where the NLB listens for traffic.

2. **Target Groups**  
   - Route traffic to EC2 instances or IP addresses.
   - Conduct **Health Checks** at the TCP/UDP layer.

3. **IP Address Types**  
   - You can choose between **IPv4** and **IPv6** addresses.

4. **Security Groups**
   - Control inbound and outbound traffic.

5. **DNS Name**  
   - Similar to ALB, it has a public DNS name registered in Route 53.

---

### 3. **Classic Load Balancer (CLB)** – Legacy Load Balancer  
- **Purpose**: Older version of ELB, suitable for **TCP and HTTP/HTTPS traffic**, but offers fewer advanced features than ALB and NLB.
- **Components**:

1. **Listeners**  
   - Define protocols (TCP or HTTP/HTTPS) and ports.

2. **Instances**  
   - Targets are usually **EC2 instances** rather than target groups.

3. **Health Checks**  
   - Monitor the health of EC2 instances to ensure traffic is only routed to healthy instances.

4. **Security Groups**
   - Attached to control inbound and outbound traffic.

5. **DNS Name**  
   - Public DNS name similar to the other load balancers.

---

### **Common Components Across All ELBs**
- **VPC Integration**  
  - ELBs operate within your Virtual Private Cloud (VPC) and integrate with subnets.

- **Security Groups**  
  - Every ELB can have **security groups** to control traffic flow.

- **Route 53 Integration**  
  - You can use **AWS Route 53** to map domain names to your ELB’s DNS name.

- **CloudWatch Metrics**  
  - AWS ELBs provide **CloudWatch metrics** for monitoring availability, latency, request count, error rates, etc.

- **IAM Roles & Policies**  
  - ELBs integrate with **IAM roles** for access control and security policies.

---

### **Choosing the Right ELB**
| **Load Balancer** | **Layer** | **Best Use Case** |
|---------------------|-----------|-------------------------|
| **ALB**            | Layer 7   | Web applications, HTTP/HTTPS traffic, URL-based routing |
| **NLB**            | Layer 4   | TCP-heavy applications, Low latency, High performance |
| **CLB**            | Layer 4/7 | Legacy applications, Simple TCP/HTTP traffic |

If you're hosting modern applications, **ALB** or **NLB** is generally recommended over CLB due to better scalability and advanced routing options.