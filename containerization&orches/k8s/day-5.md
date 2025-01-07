Here’s a clear and organized set of notes on **StatefulSet**, **Headless Service**, and **Storage (Static & Dynamic Volume Provisioning)** with examples for better understanding.

---

# 📚 **Kubernetes Notes**

## **1. StatefulSet**

### **What is StatefulSet?**  
- A **StatefulSet** is a Kubernetes workload resource used to **manage stateful applications**.  
- Unlike Deployments, StatefulSets **maintain identity and order** for each Pod.  
- Ideal for applications requiring **stable storage**, **unique network identifiers**, and **ordered deployment/termination** (e.g., databases like MySQL, MongoDB, etc.).

### **Key Features of StatefulSet:**  
1. **Stable Network Identity:** Each Pod gets a unique and consistent hostname.  
2. **Stable Storage:** Persistent storage is associated with each Pod and is not lost after Pod rescheduling.  
3. **Ordered Deployment and Scaling:** Pods are created and deleted sequentially (`0 → N`).  
4. **Ordered Updates:** Ensures updates happen in order (`N → 0`).  

---

### **StatefulSet Example:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql-statefulset
spec:
  serviceName: "mysql"
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: mysql:5.7
          ports:
            - containerPort: 3306
          volumeMounts:
            - name: mysql-persistent-storage
              mountPath: /var/lib/mysql
  volumeClaimTemplates:
    - metadata:
        name: mysql-persistent-storage
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 1Gi
```

**Explanation:**  
- `serviceName`: Controls the network domain for Pods.  
- `volumeClaimTemplates`: Ensures **each Pod gets its own PersistentVolume**.  
- Pods are created as `mysql-0`, `mysql-1`, `mysql-2`.

---

## **2. Headless Service**

### **What is a Headless Service?**  
- A **Headless Service** is a service without a **single ClusterIP**.  
- Instead of load balancing, it provides **direct access to individual Pods**.  
- Used with **StatefulSets** to ensure stable Pod network identities.

### **When to Use Headless Services?**  
- When applications need **direct access to specific Pods**.  
- For **stateful workloads** like databases.  

### **Headless Service Example:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  clusterIP: None
  selector:
    app: mysql
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
```

**Explanation:**  
- `clusterIP: None` makes the service headless.  
- DNS entries are created for **each Pod** (e.g., `mysql-0.mysql.default.svc.cluster.local`).

**Access Specific Pod:**  
```bash
mysql -h mysql-0.mysql
```

---

## **3. Storage**

### **A. Static Volume Provisioning**

#### **PersistentVolume (PV):**
- **Definition:** A piece of storage in the cluster provisioned by an admin.  
- **Lifecycle:** Independent of any Pod.  

#### **PersistentVolumeClaim (PVC):**
- **Definition:** A request for storage resources from a PV.  
- **Binding:** Kubernetes binds a PVC to an available PV based on **accessModes** and **storage requests**.  

**Static Provisioning Example:**

**Step 1: Create a PV**
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-static
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

**Step 2: Create a PVC**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-static
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

**Step 3: Attach PVC to a Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-with-static-pv
spec:
  containers:
    - name: nginx
      image: nginx:latest
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: storage
  volumes:
    - name: storage
      persistentVolumeClaim:
        claimName: pvc-static
```

---

### **B. Dynamic Volume Provisioning**

- In **Dynamic Provisioning**, storage is provisioned **automatically** using **StorageClass** (SC).  
- **StorageClass:** Defines a storage type (e.g., AWS EBS, GCP Persistent Disk).  
- Removes the need for manually creating PVs.

**Key Components:**  
1. **StorageClass (SC)** – Blueprint for storage provisioning.  
2. **PVC** – Requests storage dynamically via SC.

---

**Dynamic Provisioning Example:**

**Step 1: Create a StorageClass**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard-storage
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  fsType: ext4
```

**Step 2: Create a PVC Using SC**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-dynamic
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: standard-storage
```

**Step 3: Attach PVC to a Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-with-dynamic-pv
spec:
  containers:
    - name: app-container
      image: nginx:latest
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: storage
  volumes:
    - name: storage
      persistentVolumeClaim:
        claimName: pvc-dynamic
```

---

## **4. Comparison Table**

| **Feature**            | **Static Provisioning** | **Dynamic Provisioning** |
|-------------------------|-------------------------|--------------------------|
| **Provisioning**       | Manual                 | Automatic               |
| **Admin Effort**       | High                   | Low                     |
| **StorageClass**       | ❌ Not Required        | ✅ Required             |
| **Flexibility**        | Low                   | High                    |
| **Best Use Case**      | Small Clusters         | Scalable Environments   |

---

## ✅ **Key Takeaways:**
1. **StatefulSet:** Used for stateful apps like databases, with stable storage and unique identities.  
2. **Headless Service:** Ensures direct access to specific Pods.  
3. **Static Provisioning:** Admin manually creates PersistentVolumes.  
4. **Dynamic Provisioning:** Kubernetes automatically provisions storage using StorageClass.  

Let me know if you want to dive deeper into any section or need additional examples! 🚀😊

