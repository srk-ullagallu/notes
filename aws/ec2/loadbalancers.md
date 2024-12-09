# ELB
- Managed LB service
- It will take care of upgrades,patching,scalability and HA of LB's

- LB distribute incoming traffic to backend targets such as instances,lambda,ip's
- LB performans health checks and route traffic only healthy targets
- Elastic Load Balancing scales your load balancer capacity automatically in response to changes in incoming traffic

- using LB provides HA and fault tolerance of your applications
- You can also offload the work of encrytpion and decryption to your LB

**ELB** offers 3 types of LB
- ALB
- NLB
- GWLB

# ALB
- It is Layer 7 LB
- It is intelligent LB route traffic based on host based and path based requests
- A load balancer serves as the single point of contact for clients.
- HTTP,HTTPS and WEBSOCKET protocols

# NLB 
- It is Layer 4 LB
- It is designed to handle millions of requests for second
- It will supports static IP for each AZ because of its low level design it works in Layer 4 in ISO/OSI model
- We can easily whiltelisting and block listing the traffic
- TCP and UDP protocols


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


In an AWS Application Load Balancer (ALB), the incoming request typically includes the following components:

### Components of an Incoming Request to ALB
1. **Headers**: Includes metadata such as `Host`, `User-Agent`, `Authorization`, and other HTTP headers.
2. **Path**: The URL path of the request (e.g., `/api/v1/resource`).
3. **Query String**: Parameters sent in the URL (e.g., `?key=value`).
4. **Request Method**: HTTP method (e.g., `GET`, `POST`, `PUT`, `DELETE`).
5. **Body**: For methods like `POST` or `PUT`, the request may contain a payload in JSON, XML, or another format.
6. **Protocol**: Indicates whether the request is HTTP or HTTPS.
7. **Source IP**: The IP address of the client initiating the request.

---

### How ALB Handles Encryption and Decryption (TLS Offloading)
ALB provides **TLS (Transport Layer Security) offloading**, which simplifies the workload for backend servers by handling encryption and decryption at the ALB level.

#### Steps in TLS Offloading
1. **Incoming Encrypted Request (HTTPS)**:
   - When a client sends an HTTPS request, the request is encrypted using TLS.
   - The ALB terminates the TLS connection, decrypting the request.
   
2. **TLS Termination**:
   - ALB uses a **certificate** (stored in AWS Certificate Manager (ACM) or uploaded directly) to decrypt the request.
   - The decrypted data is passed to the backend targets over HTTP or HTTPS.

3. **Outgoing Encrypted Response (HTTPS)**:
   - If the response to the client needs to be encrypted (using HTTPS), ALB re-encrypts the data using the same certificate before sending it back.

#### Advantages of TLS Offloading with ALB
- **Reduced Load on Backend Servers**:
  - Backend servers don’t need to handle encryption and decryption, saving CPU and memory resources.
- **Centralized Certificate Management**:
  - Certificates are managed at the ALB level, simplifying updates and renewals.
- **Seamless Client Experience**:
  - The client interacts securely with the ALB over HTTPS without noticing any difference.

#### Communication Between ALB and Backend Targets
- **Unencrypted (HTTP)**:
  - ALB forwards requests as plain HTTP to the backend targets.
- **Encrypted (HTTPS)**:
  - If backend encryption is required, ALB forwards the decrypted request over HTTPS to the backend targets, re-encrypting the request.

### Example Use Case
You have an ALB set up for a web application with an HTTPS endpoint. The flow works like this:
1. A client makes an HTTPS request to `https://ullagallubuffellomilk.store`.
2. ALB decrypts the request using a certificate.
3. ALB forwards the request to a backend server (`backend` service in your Docker setup) using HTTP or HTTPS.
4. The backend server processes the request and sends the response back to ALB.
5. ALB re-encrypts the response (if required) and sends it back to the client.

This process offloads the computationally expensive tasks of TLS encryption and decryption from your backend services, improving performance and manageability.


Let me break it down with a simpler explanation and an example.

---

### **How Load Balancing Works Without Cross-Zone Load Balancing**
1. **Load Balancer Nodes**:
   - Each Availability Zone (AZ) in your AWS setup has one or more **load balancer nodes** when you enable that AZ.

2. **Traffic Distribution**:
   - Incoming traffic is **evenly distributed across the load balancer nodes** in each AZ.
   - However, each load balancer node only forwards traffic to **targets (e.g., EC2 instances, containers)** within the **same AZ** as that node.

3. **Issue**:
   - If one AZ has **fewer targets** than others, those targets will receive **more traffic per target**, leading to uneven load distribution.

---

### **Example Without Cross-Zone Load Balancing**

#### Setup:
- Assume you have:
  - **Two AZs**: `us-east-1a` and `us-east-1b`.
  - **Four targets** total:
    - 2 targets in `us-east-1a`.
    - 2 targets in `us-east-1b`.

- Traffic Distribution:
  - Traffic is evenly split between AZs.
  - Each load balancer node sends traffic **only to the targets in its own AZ**.

| AZ          | Number of Targets | % Traffic Per Target |
|-------------|-------------------|----------------------|
| us-east-1a  | 2                 | 50% ÷ 2 = 25% each  |
| us-east-1b  | 2                 | 50% ÷ 2 = 25% each  |

#### What Happens If Targets Are Uneven?
- Suppose `us-east-1a` has 2 targets, but `us-east-1b` has **1 target**.

| AZ          | Number of Targets | % Traffic Per Target |
|-------------|-------------------|----------------------|
| us-east-1a  | 2                 | 50% ÷ 2 = 25% each  |
| us-east-1b  | 1                 | 50% ÷ 1 = 50% total |

- The single target in `us-east-1b` receives **50% of the total traffic**, while targets in `us-east-1a` each handle only **25% of the total traffic**.
- This creates an **imbalance** in load distribution.

---

### **How Cross-Zone Load Balancing Fixes This**
1. **Traffic Distribution**:
   - Incoming traffic is still **evenly split across load balancer nodes** in all AZs.
   - However, each load balancer node can now **send traffic to targets in all AZs**, not just its own.

#### Example With Cross-Zone Load Balancing
- Using the same setup (2 targets in `us-east-1a` and 1 in `us-east-1b`):

| AZ          | Number of Targets | % Traffic Per Target |
|-------------|-------------------|----------------------|
| us-east-1a  | 2                 | 100% ÷ 3 = ~33.3%   |
| us-east-1b  | 1                 | 100% ÷ 3 = ~33.3%   |

- All targets now receive approximately the **same percentage of traffic** (33.3%), regardless of the AZ they are in.

---

### **Key Takeaway**
Without cross-zone load balancing:
- Each load balancer node can only send traffic to targets in its own AZ.
- Uneven numbers of targets in AZs result in **uneven traffic distribution**.

With cross-zone load balancing:
- Load balancer nodes can send traffic to targets in **any AZ**.
- Traffic is distributed evenly **across all targets**, solving the imbalance.

Does this help clarify the concept? Let me know if you’d like further examples or visualizations!


