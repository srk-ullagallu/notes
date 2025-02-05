A **trust policy** in AWS is a JSON document that defines **which AWS accounts, users, roles, or services** are allowed to **assume a role**. This is a key part of setting up **IAM Roles** in AWS. 

Essentially, a trust policy specifies the **"trust relationship"** between the role and the entities (principals) that can assume it.

### Key Points:
1. **Attached to Roles**:
   - Trust policies are **not attached to users or groups** but to IAM roles. They decide **who** (principal) can assume the role.

2. **Structure**:
   - Trust policies have a similar format to IAM policies but are focused on **allowing access** to assume the role.
   
3. **Components**:
   - **Principal**: Specifies the entity that can assume the role (e.g., AWS account, user, role, or service).
   - **Effect**: Specifies whether the statement allows or denies access (usually `"Allow"`).
   - **Action**: Specifies what the entity can do (usually `"sts:AssumeRole"`).
   - **Condition** (Optional): Adds extra checks like MFA or source IP.

### Example Trust Policy
Here’s a sample trust policy that allows an EC2 instance to assume a role:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### Use Cases:
1. **Cross-Account Access**:
   - Allow an IAM role in one AWS account to be assumed by another account.

2. **Service Access**:
   - Allow AWS services (like Lambda, EC2, or ECS) to assume roles for performing actions on your behalf.

3. **Delegated Access**:
   - Allow a role or user within your account to assume another role with different permissions.

### Key Considerations:
- Always follow the principle of **least privilege** to minimize the scope of who can assume the role.
- Test trust policies thoroughly to ensure that only the intended entities can assume the role.

---
### Scanario
Let’s consider a **real-world scenario** to understand the use of a trust policy:

---

### Scenario:  
**Cross-Account Access for Backups**

You are working in **Account A** (your company's primary AWS account) and need to allow a backup service running in **Account B** (a third-party vendor's AWS account) to access an S3 bucket in **Account A** for backing up data.  

To achieve this, you will use **IAM Roles** and a **Trust Policy** to allow **Account B** to assume the role and gain access to the S3 bucket.

---

### Solution Steps:

#### 1. **Create an IAM Role in Account A**
   In **Account A**, create a role named `BackupAccessRole`. Attach a policy to allow access to the S3 bucket:
   
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": "s3:*",
         "Resource": "arn:aws:s3:::your-bucket-name/*"
       }
     ]
   }
   ```

---

#### 2. **Attach a Trust Policy to the Role**
   Add a trust policy to allow the vendor's **Account B** to assume the role. The trust policy would look like this:
   
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "AWS": "arn:aws:iam::123456789012:root" 
         },
         "Action": "sts:AssumeRole"
       }
     ]
   }
   ```

   - **`123456789012`** is the **Account ID** of Account B.
   - The **`root`** means any principal in that account can assume the role. You can narrow it down to a specific user or role in Account B for better security.

---

#### 3. **Grant the Vendor (Account B) Access**
   In **Account B**, the vendor will create a policy allowing their IAM user or service to assume the role in **Account A**:
   
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": "sts:AssumeRole",
         "Resource": "arn:aws:iam::111122223333:role/BackupAccessRole"
       }
     ]
   }
   ```

   - **`111122223333`** is the **Account ID** of Account A where the role resides.

---

#### 4. **Vendor Assumes the Role**
   The vendor in Account B will use the `sts:AssumeRole` API or CLI to assume the `BackupAccessRole`. Once assumed, they receive temporary credentials to access the S3 bucket.

#### **How Does the Vendor Do This?**
The vendor in **Account B** will run a command like this:

```bash
aws sts assume-role \
    --role-arn "arn:aws:iam::111122223333:role/BackupAccessRole" \
    --role-session-name "VendorSession"
```

Here’s what the parts mean:
- **`aws sts assume-role`**: This is the AWS command to assume a role.
- **`--role-arn`**: The ARN (Amazon Resource Name) of the role they want to assume. This ARN belongs to the IAM role (`BackupAccessRole`) in **Account A**.
- **`--role-session-name`**: A name for the session, used for tracking (can be any name like `"VendorSession"`).

---

#### **What Happens When They Run This Command?**
1. AWS checks the **trust policy** of the role in **Account A** to see if **Account B** is allowed to assume the role.
   - If the trust policy allows it (and it does in our case), AWS proceeds.

2. AWS generates **temporary security credentials** for the vendor. These credentials include:
   - **Access Key ID**
   - **Secret Access Key**
   - **Session Token**

   These credentials give the vendor the ability to perform actions specified in the **permissions policy** of the role.

3. The vendor uses these credentials to interact with AWS services (e.g., upload or download files from the S3 bucket).

---

#### **Example Output of the Command**
When the vendor runs the `aws sts assume-role` command, AWS responds with temporary credentials like this:

```json
{
  "Credentials": {
    "AccessKeyId": "ASIAEXAMPLE",
    "SecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    "SessionToken": "FQoGZXIvYXdzEEXAMPLE...",
    "Expiration": "2025-01-26T12:34:56Z"
  },
  "AssumedRoleUser": {
    "AssumedRoleId": "AROAEXAMPLE:VendorSession",
    "Arn": "arn:aws:sts::111122223333:assumed-role/BackupAccessRole/VendorSession"
  }
}
```

---

#### **How the Vendor Uses the Credentials**
The vendor will configure these temporary credentials in their AWS CLI or SDK to access the S3 bucket. For example:

```bash
aws s3 ls s3://your-bucket-name/ \
    --access-key "ASIAEXAMPLE" \
    --secret-key "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
    --session-token "FQoGZXIvYXdzEEXAMPLE..."
```

---

### Key Benefits:
1. **Secure Cross-Account Access**:
   - The trust policy allows only **Account B** to assume the role in **Account A**.
   
2. **Temporary Access**:
   - Vendors get **temporary credentials** via `sts:AssumeRole`, reducing security risks.

3. **Least Privilege**:
   - You control **what** actions the role can perform on the S3 bucket using the attached permissions policy.



