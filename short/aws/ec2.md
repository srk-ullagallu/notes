# EC2

# EBS
EBS (Elastic Block Store) is a storage service in AWS that provides block-level storage for EC2 instances. It is used for storing data, applications, and system files.  

Types of EBS Volumes:  

1. gp2 (General Purpose SSD)  
   - Balances cost and performance.  
   - Performance depends on volume size (3 IOPS per GB, up to 16,000 IOPS).  
   - Suitable for general workloads like web servers and dev environments.  

2. gp3 (General Purpose SSD - Next Gen)  
   - Offers consistent performance, independent of volume size.  
   - Minimum 3,000 IOPS and 125 MB/s, scalable up to 16,000 IOPS.  
   - Cheaper and more efficient than gp2.  

3. io1 (Provisioned IOPS SSD)  
   - High-performance storage for mission-critical workloads.  
   - Allows manual IOPS configuration (up to 64,000 IOPS).  
   - Suitable for databases like Oracle, MySQL, and SAP.  

4. io2 (Provisioned IOPS SSD - Enhanced)  
   - More durable (99.999% durability).  
   - Supports up to 64,000 IOPS.  
   - Ideal for high-performance databases and enterprise apps.  

5. st1 (Throughput Optimized HDD)  
   - Optimized for big data, data warehouses, and log processing.  
   - Provides high throughput (not IOPS-based).  
   - Best for workloads requiring sequential read/write.  

6. sc1 (Cold HDD)  
   - Low-cost storage for infrequently accessed data.  
   - Best for archival storage and long-term backups.  

Each type serves different needs. Choose based on performance, durability, and cost. 

Provisioned IOPS SSD (io1 and io2) support Multi-Attach, meaning a single EBS volume can be attached to multiple EC2 instances within the same Availability Zone.

Key Points About Multi-Attach:

- Only io1 and io2 volumes support Multi-Attach.
- Multiple EC2 instances can read/write to the same EBS volume at the same time.
- The application must handle concurrent writes to prevent data corruption (e.g., using a clustered file system like OCFS2 or Amazon FSx for Lustre).
- Maximum 16 instances can be attached to a single Multi-Attach enabled volume.

Other volume types like gp2, gp3, st1, and sc1 do not support Multi-Attach.

Encrypting an EBS volume means securing its data using AWS-managed encryption keys. This ensures data at rest, data in transit between EC2 and EBS, and snapshots are protected.

Scenarios of Encrypted Volumes:  

1. Encrypted Volume to New Volume  
   - If you create a new volume from an encrypted volume or its snapshot, the new volume remains encrypted.  

2. Unencrypted Volume to Encrypted Volume  
   - Direct conversion is not possible.  
   - You must create a snapshot of the unencrypted volume, copy the snapshot with encryption enabled, and then create a new encrypted volume from it.  

3. Copying an Encrypted Snapshot  
   - The copied snapshot stays encrypted.  
   - You can re-encrypt it with a different KMS key if needed.  

4. Restoring from an Encrypted Backup  
   - If an EC2 instance uses an encrypted root volume, any new instance launched from its AMI will also have encrypted root storage.  

Encryption helps with data security and compliance in AWS.


# EFS
EFS (Elastic File System) is a fully managed, scalable file storage service in AWS that allows multiple EC2 instances to access shared data over NFS (Network File System).  

Key Features of EFS:  
- Fully managed, AWS handles provisioning, scaling, and maintenance  
- Auto-scaling, grows and shrinks automatically based on storage needs  
- Multi-AZ availability, data is stored across multiple Availability Zones  
- Shared access, multiple EC2 instances can mount and use the same file system  
- Encryption, supports encryption at rest (AWS KMS) and in transit (TLS)  
- Performance modes, General Purpose (default) and Max I/O for high throughput  

Use Cases:  
- Shared storage for applications running on multiple EC2 instances  
- Storing logs, backups, and large datasets  
- Machine learning and analytics workloads that need high throughput

# Images

# LoadBalancing

# AutoScaling

# Networking&Security