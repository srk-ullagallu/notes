# EBS[Elastic Block Store]
---
#### **1. What is EBS Volume?**
- **EBS (Elastic Block Store)** is a block-level storage service provided by AWS (Amazon Web Services).
- It provides persistent storage volumes that can be attached to EC2 instances.
- EBS volumes are network-attached, meaning they are independent of the lifecycle of an EC2 instance.
- They are highly available and reliable, with automatic replication within an Availability Zone (AZ).
- EBS volumes can be used as primary storage for databases, file systems, or applications.
---
#### **2. What is EBS Snapshots?**
- **EBS Snapshots** are point-in-time backups of EBS volumes.
- Snapshots are stored in Amazon S3, making them durable and cost-effective.
- They are incremental, meaning only the changes made after the last snapshot are saved.
- Snapshots can be used to:
  - Create new EBS volumes.
  - Restore data.
  - Migrate data across regions or AZs.
- Snapshots are region-specific but can be copied to other regions.
---
#### **3. Types of EBS Volumes**
AWS offers several types of EBS volumes optimized for different use cases:
1. **General Purpose SSD (gp2/gp3):**
   - **gp2**: Balanced price and performance for a wide range of workloads.
     - Baseline performance: 3 IOPS per GB, up to 16,000 IOPS.
   - **gp3**: Latest generation, allows independent scaling of IOPS and throughput.
     - Baseline performance: 3,000 IOPS and 125 MB/s throughput by default, scalable.
   - Use cases: Boot volumes, small to medium-sized databases, development, and test environments.
2. **Provisioned IOPS SSD (io1/io2):**
   - Designed for I/O-intensive workloads requiring high performance.
   - **io1**: Up to 64,000 IOPS and 1,000 MB/s throughput per volume.
   - **io2**: Higher durability and more IOPS (up to 256,000 IOPS per volume).
   - Use cases: Critical applications, large databases, and workloads requiring low latency.
3. **Throughput Optimized HDD (st1):**
   - Designed for large, sequential workloads requiring high throughput.
   - Low cost per GB.
   - Use cases: Big data, data warehouses, log processing.
4. **Cold HDD (sc1):**
   - Lowest-cost HDD volume for infrequently accessed data.
   - Use cases: Cold data storage, backup archives.
---
#### **4. Features of EBS Volumes**
- **Durability and Availability:**
  - Automatically replicated within an AZ for high availability.
  - Snapshots provide cross-AZ and cross-region durability.
- **Scalability:**
  - Resize volumes on the fly (with some limitations).
  - Increase IOPS and throughput independently (gp3 and io2).
- **Performance:**
  - SSD volumes offer low latency and high IOPS.
  - HDD volumes provide high throughput for sequential workloads.
- **Encryption:**
  - Supports encryption at rest using AWS Key Management Service (KMS).
- **Snapshot Management:**
  - Create, copy, and share snapshots for backup and migration.
- **Cost-Effective:**
  - Pay only for what you use (no upfront costs).
---
#### **5. Difference Between EBS Volumes and Instance Store Volumes**
| **Feature**               | **EBS Volumes**                                                                 | **Instance Store Volumes**                                              |
|---------------------------|---------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| **Persistence**           | Persistent storage; data persists after instance termination.                  | Ephemeral storage; data is lost when the instance is stopped or terminated. |
| **Performance**           | Network-attached, so slightly slower than instance store.                      | Directly attached to the instance, providing very high performance.     |
| **Scalability**           | Can be resized dynamically.                                                    | Fixed size based on the instance type.                                  |
| **Cost**                  | Pay for provisioned storage and IOPS.                                          | Included in the cost of the EC2 instance.                               |
| **Use Cases**             | Databases, critical applications, and workloads requiring persistence.         | Temporary storage, cache, and high-performance workloads.               |
| **Durability**            | Highly durable with automatic replication within an AZ.                        | Not durable; data is lost if the instance fails.                        |
| **Snapshot Support**      | Supports snapshots for backup and migration.                                   | No snapshot support.                                                    |
---
### Summary
- **EBS Volumes** are persistent, network-attached block storage for EC2 instances.
- **EBS Snapshots** provide incremental backups for EBS volumes.
- **Types of EBS Volumes** include General Purpose SSD, Provisioned IOPS SSD, Throughput Optimized HDD, and Cold HDD.
- **Features** include scalability, encryption, durability, and cost-effectiveness.
- **EBS vs. Instance Store**: EBS is persistent and scalable, while instance store is ephemeral and high-performance.

