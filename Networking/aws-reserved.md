AWS reserves **5 IP addresses** in every **subnet** you create within a **VPC** to ensure the proper functioning and management of networking services. These reserved IPs are not available for allocation to EC2 instances or other resources.

---

### **Details of the Reserved IPs**
In every subnet, the **first 4 IP addresses** and the **last IP address** in the CIDR block are reserved. Here’s what they are used for:

1. **First IP Address (Network Address)**:
   - **Purpose**: Identifies the subnet itself (network ID).
   - **Example**: For a subnet `10.0.0.0/24`, the first IP is **10.0.0.0**.

2. **Second IP Address**:
   - **Purpose**: Reserved for the **VPC router**.
   - This IP is used for routing traffic between subnets within the VPC and for communication with other networks, including the internet.
   - **Example**: For a subnet `10.0.0.0/24`, the second IP is **10.0.0.1**.

3. **Third IP Address**:
   - **Purpose**: Reserved for the **AWS DNS server**.
   - This IP is used to provide DNS resolution for instances in the subnet.
   - **Example**: For a subnet `10.0.0.0/24`, the third IP is **10.0.0.2**.
   - Note: Instances configured to use the AWS-provided DNS resolver (default behavior) query this IP.

4. **Fourth IP Address**:
   - **Purpose**: Reserved for **future use by AWS**.
   - This IP is held for potential internal or operational needs.

5. **Last IP Address (Broadcast Address)**:
   - **Purpose**: Although broadcast traffic is not supported in AWS, the last IP in the subnet is reserved to maintain compatibility with standard networking practices.
   - **Example**: For a subnet `10.0.0.0/24`, the last IP is **10.0.0.255**.

---

### **Subnet Size and Usable IPs**
- The total number of IP addresses in a subnet is determined by the **CIDR block**. For example:
  - `10.0.0.0/24` = 256 IPs (2^8).
  - After reserving 5 IPs, **251 usable IPs remain** for your instances or services.

- Smaller subnets have fewer usable IPs due to the fixed 5 reserved addresses. For instance:
  - `10.0.0.0/28` = 16 IPs (2^4).
  - After reserving 5 IPs, **11 usable IPs remain**.

---

### **Why These Reservations Are Important**
1. **Networking Standards**:
   - Reserving specific IPs ensures compatibility with common networking practices.

2. **AWS Services**:
   - AWS needs certain reserved IPs to provide internal services like routing and DNS resolution.

3. **Scalability and Future-Proofing**:
   - Reserving additional IPs allows AWS to introduce new features or services in the future without impacting customer workloads.

---

### **Example in Action**
If you create a subnet with the CIDR block `10.0.1.0/24`:
- Total IPs: `256`.
- Reserved IPs:
  - **10.0.1.0**: Network address.
  - **10.0.1.1**: Router.
  - **10.0.1.2**: DNS resolver.
  - **10.0.1.3**: Reserved for future use.
  - **10.0.1.255**: Broadcast address.
- **Usable IPs**: `251` (from `10.0.1.4` to `10.0.1.254`).
