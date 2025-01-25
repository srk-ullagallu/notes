# IAM-user01 has Full access to all S3 buckets but in bucket01 policy there is explicit deny to use01
In AWS, **explicit deny** always overrides any allow statement, regardless of the user's permissions. So, if **IAM-user01** has full access to all S3 buckets but there is an **explicit deny** in the `bucket01` policy for `IAM-user01`, the deny will take precedence, and the user will be unable to perform actions on that bucket.

### Scenario Breakdown:
- **IAM-user01**: Has full access to all S3 buckets.
- **Bucket Policy for `bucket01`**: Contains an **explicit deny** for `IAM-user01`.

### Example:

Let's break it down with an example to make this clearer.

1. **IAM-user01 Policy (Full Access to All S3 Buckets)**

This policy grants `IAM-user01` full access to all S3 buckets:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
```

- This policy allows `IAM-user01` to perform all actions (`s3:*`) on any S3 bucket (`arn:aws:s3:::*`).

2. **Bucket Policy for `bucket01` (Explicit Deny for `IAM-user01`)**

Now, let's say we have the following bucket policy on `bucket01` that explicitly denies `IAM-user01` access to the bucket:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:*",
      "Principal": {
        "AWS": "arn:aws:iam::account-id:user/IAM-user01"
      },
      "Resource": [
        "arn:aws:s3:::bucket01",
        "arn:aws:s3:::bucket01/*"
      ]
    }
  ]
}
```

- **Explicit Deny**: This policy denies `IAM-user01` from performing any `s3:*` actions on `bucket01`.

### How AWS Evaluates Permissions:
1. **IAM-user01's Permissions**: The user has full access to all S3 buckets due to the IAM policy.
2. **Bucket Policy on `bucket01`**: The explicit deny in the bucket policy applies to `IAM-user01`.

AWS evaluates policies in the following way:
- First, it checks **IAM policies** for `IAM-user01`, which allows access to all S3 buckets.
- Then, it checks the **bucket policy** on `bucket01`, which explicitly denies `IAM-user01`.
- Since the deny is **explicit**, it takes precedence over the allow, and **`IAM-user01` will not be able to access `bucket01`**.

### Key Points:
- **Explicit Deny**: It overrides any allow statements, even if those allows come from other policies (like IAM user policies or other bucket policies).
- **Allow statements** are only effective if there is no conflicting deny statement.

### Conclusion:
In your case, **IAM-user01** will not be able to access `bucket01`, despite having full access to all other S3 buckets, because the bucket policy on `bucket01` explicitly denies access to the user. 


# IAM-user02 has no S3 access explicitly deny to buckect-02 but in bucket policy user02 has full access

In AWS, when there is **no explicit allow** in the IAM user policy but there is an **explicit deny** and a **full access allow** in the bucket policy, the access evaluation is done based on the following rules:

1. **Explicit Deny**: A deny takes precedence over any allow. If there is an explicit deny in the IAM user policy or a resource policy (like the S3 bucket policy), it will prevent access.
2. **Explicit Allow**: If there is an explicit allow (like in the bucket policy), it will only apply if there is no conflicting explicit deny.

### Scenario Breakdown:

- **IAM-user02**: 
  - Has **no explicit S3 access** in the IAM policy.
  - Has **explicit deny** in the IAM policy for `bucket-02`.
- **Bucket Policy on `bucket-02`**: 
  - Grants **full access** to `IAM-user02`.

### Example:

Let's consider this scenario in detail with example policies.

1. **IAM-user02 Policy (No S3 Access and Explicit Deny for `bucket-02`)**

This is the IAM policy for `IAM-user02`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::bucket-02/*"
    }
  ]
}
```

- This policy explicitly denies access to **any actions** (`s3:*`) on objects within `bucket-02`.

2. **Bucket Policy for `bucket-02` (Full Access to `IAM-user02`)**

This is the bucket policy attached to `bucket-02`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Principal": {
        "AWS": "arn:aws:iam::account-id:user/IAM-user02"
      },
      "Resource": [
        "arn:aws:s3:::bucket-02",
        "arn:aws:s3:::bucket-02/*"
      ]
    }
  ]
}
```

- This policy grants **full access** (`s3:*`) to the `IAM-user02` for `bucket-02`.

### How AWS Evaluates Permissions:

1. **IAM Policy Deny**: 
   - The **explicit deny** in the IAM user policy prevents `IAM-user02` from performing any S3 actions on `bucket-02`, because **deny always takes precedence**.

2. **Bucket Policy Allow**:
   - The **full access allow** in the bucket policy does grant permissions to `IAM-user02`, but because the **IAM policy has an explicit deny**, this allow is overridden by the deny.

### Outcome:
Even though `bucket-02`'s bucket policy grants **full access** to `IAM-user02`, the **explicit deny** in the IAM policy **takes precedence** and prevents the user from accessing `bucket-02`. 

### Key Points:
- **Explicit Deny** always takes precedence over allow statements.
- Even though the bucket policy allows access, the **IAM policy's deny** blocks that access.
- For access to be granted, the **explicit deny** must be removed or adjusted in the IAM policy.

### Conclusion:
In this case, **IAM-user02 will not be able to access `bucket-02`** because the explicit deny in the IAM policy overrides the full access allow in the bucket policy.

Let me know if you need further clarification!

# Explicit deny takes precedence
Yes, that's correct! In both examples, **explicit deny** takes precedence over any allow, whether it comes from an IAM policy or a resource policy (like an S3 bucket policy). 

### Key Points:
- **Explicit Deny**: This will always override any allow statement, whether the deny is in the **IAM policy** or the **resource policy** (bucket policy, for example).
- **Allow**: If there is an allow but no conflicting deny, access will be granted.
- If there’s a conflict where one policy allows access and another denies it, the **deny** will always take precedence.

### Example Recap:

1. **Scenario 1**:
   - **IAM-user01** has full access to all S3 buckets (via IAM policy).
   - **Bucket01** has an **explicit deny** for `IAM-user01` (in the bucket policy).
   - **Outcome**: **`IAM-user01` will not have access** to `bucket01` because the explicit deny in the bucket policy takes precedence.

2. **Scenario 2**:
   - **IAM-user02** has no S3 access and is **explicitly denied** in the IAM policy for `bucket-02`.
   - **Bucket Policy for bucket-02** grants **full access** to `IAM-user02`.
   - **Outcome**: **`IAM-user02` will not have access** to `bucket-02` because the explicit deny in the IAM policy takes precedence over the bucket policy’s allow.

### Summary:
- **Explicit Deny** will always override **Allow**.
- Deny in **IAM policies** or **resource policies** (like bucket policies) takes priority and blocks access, even if there's a conflicting allow somewhere else.

Let me know if you have more questions on this!


---
### ABAC

### **Scenario Breakdown**:
- **DEV Team**:  
  - Can **start**, **stop**, and **restart** the **DEV DB**.
  - Cannot perform any actions on the **PROD DB**.
  
- **DBAdmin Team**:  
  - Can **start**, **stop**, and **restart** the **PROD DB**.
  - Cannot perform any actions on the **DEV DB**.

### **Steps to Implement the Policies**:

1. **Tag the Databases**:
   - Tag the **DEV DB** with `Team=DEV` and **PROD DB** with `Team=PROD`.
   
2. **Create IAM Policies** for both teams:
   - DEV Team Policy: Allow actions on the DEV DB only.
   - DBAdmin Team Policy: Allow actions on the PROD DB only.

### **Step 1: Tagging the RDS Instances**

Let's assume the following:
- `dev-db` is the DEV database.
- `prod-db` is the PROD database.

Tag the databases with the relevant team names.

#### Tag DEV DB (dev-db):
```bash
aws rds add-tags-to-resource --resource-name arn:aws:rds:region:account-id:db:dev-db --tags Key=Team,Value=DEV
```

#### Tag PROD DB (prod-db):
```bash
aws rds add-tags-to-resource --resource-name arn:aws:rds:region:account-id:db:prod-db --tags Key=Team,Value=PROD
```

### **Step 2: Create IAM Policies**

#### **A. DEV Team Policy**  
This policy allows the DEV team to **start**, **stop**, and **restart** only the **DEV DB** (`Team=DEV`), and explicitly denies access to the **PROD DB**.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds:StartDBInstance",
        "rds:StopDBInstance",
        "rds:RebootDBInstance"
      ],
      "Resource": "arn:aws:rds:region:account-id:db:dev-db",
      "Condition": {
        "StringEquals": {
          "aws:RequestTag/Team": "DEV"
        }
      }
    },
    {
      "Effect": "Deny",
      "Action": [
        "rds:StartDBInstance",
        "rds:StopDBInstance",
        "rds:RebootDBInstance"
      ],
      "Resource": "arn:aws:rds:region:account-id:db:prod-db"
    }
  ]
}
```

- **Allow**: Start, stop, and restart the `dev-db` (only for resources tagged with `Team=DEV`).
- **Deny**: Start, stop, and restart the `prod-db` (explicit deny).

#### **B. DBAdmin Team Policy**  
This policy allows the DBAdmin team to **start**, **stop**, and **restart** only the **PROD DB** (`Team=PROD`), and explicitly denies access to the **DEV DB**.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds:StartDBInstance",
        "rds:StopDBInstance",
        "rds:RebootDBInstance"
      ],
      "Resource": "arn:aws:rds:region:account-id:db:prod-db",
      "Condition": {
        "StringEquals": {
          "aws:RequestTag/Team": "PROD"
        }
      }
    },
    {
      "Effect": "Deny",
      "Action": [
        "rds:StartDBInstance",
        "rds:StopDBInstance",
        "rds:RebootDBInstance"
      ],
      "Resource": "arn:aws:rds:region:account-id:db:dev-db"
    }
  ]
}
```

- **Allow**: Start, stop, and restart the `prod-db` (only for resources tagged with `Team=PROD`).
- **Deny**: Start, stop, and restart the `dev-db` (explicit deny).

### **Step 3: Attach Policies to IAM Groups**

#### Attach the **DEV Team Policy** to the **DEV Group**:

```bash
aws iam put-group-policy --group-name DEV-Team --policy-name DEV-DB-Policy --policy-document file://dev-team-policy.json
```

#### Attach the **DBAdmin Team Policy** to the **DBAdmin Group**:

```bash
aws iam put-group-policy --group-name DBAdmin-Team --policy-name DBAdmin-DB-Policy --policy-document file://dbadmin-team-policy.json
```

### **Step 4: Create IAM Users for Each Team**

Now, create IAM users for each team and add them to the respective groups.

#### Create User for DEV Team:
```bash
aws iam create-user --user-name dev-user01
aws iam add-user-to-group --user-name dev-user01 --group-name DEV-Team
```

#### Create User for DBAdmin Team:
```bash
aws iam create-user --user-name dbadmin-user01
aws iam add-user-to-group --user-name dbadmin-user01 --group-name DBAdmin-Team
```

### **Step 5: Test the Policies**

1. **Testing for DEV Team (dev-user01)**:
   - **Allow**: `dev-user01` should be able to **start**, **stop**, and **restart** the `dev-db`.
   - **Deny**: `dev-user01` should not be able to perform any action on the `prod-db`.

2. **Testing for DBAdmin Team (dbadmin-user01)**:
   - **Allow**: `dbadmin-user01` should be able to **start**, **stop**, and **restart** the `prod-db`.
   - **Deny**: `dbadmin-user01` should not be able to perform any action on the `dev-db`.

---

### **Summary**:
- The **DEV Team** has permissions to manage only the **DEV DB** and is denied access to the **PROD DB**.
- The **DBAdmin Team** has permissions to manage only the **PROD DB** and is denied access to the **DEV DB**.

Let me know if you need any further clarification or help with testing the policies!