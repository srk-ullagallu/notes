### Replication Controller
- **Definition**: The Replication Controller ensures that a specified number of pod replicas are running at any given time.
- **Selector**: It uses equality-based selectors to identify pods. This means it can only match labels that are equal (e.g., `app=nginx`).
- **Rolling Updates**: It does not support rolling updates. If you need to update the pod template, you must delete the existing Replication Controller and create a new one.
- **Deprecation**: Replication Controllers are considered deprecated in favor of ReplicaSets and Deployments.

### ReplicaSet

- **Definition**: A ReplicaSet is a newer version that also ensures that a specified number of pod replicas are running. It is used as a building block for Deployments.
- **Selector**: It supports both equality-based and set-based selectors, allowing for more complex matching (e.g., matching multiple labels).
- **Rolling Updates**: ReplicaSets can be managed by Deployments, which handle rolling updates seamlessly.
- **Usage**: While you can use ReplicaSets independently, they are primarily intended to be managed through Deployments for better control and flexibility.

### Key Differences

| Feature                  | Replication Controller           | ReplicaSet                   |
|--------------------------|----------------------------------|------------------------------|
| **Selector Type**        | Equality-based only              | Equality and set-based       |
| **Rolling Updates**      | Not supported                    | Supported via Deployments     |
| **Deprecation**          | Deprecated                       | Current standard             |
| **Management**           | Standalone                       | Typically managed by Deployments |

### Conclusion
While both Replication Controller and ReplicaSet serve to maintain a specified number of pod replicas, ReplicaSets offer more flexibility and features, especially when combined with Deployments. It’s advisable to use ReplicaSets and Deployments in modern Kubernetes applications.

---
# Questions
1. What is ReplicaSet
2. What is difference D/W Replicaset and Replication Controller

# Exercise
## ReplicaSet (RS)

### RS Equality-Based Example

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs-equality
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

- **Selector**: Uses `matchLabels` to match pods with the label `app=frontend`.
- **Purpose**: Ensures 3 replicas of pods labeled `app=frontend` are running.

---

### RS Set-Based Example

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs-set
spec:
  replicas: 3
  selector:
    matchExpressions:
      - key: app
        operator: In
        values:
        - frontend
        - backend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

- **Selector**: Uses `matchExpressions` to match pods where `app` is either `frontend` or `backend`.
- **Purpose**: Ensures 3 replicas of pods matching the selector are running.

---

## ReplicationController (RC)

### RC Equality-Based Example

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: rc-equality
spec:
  replicas: 3
  selector:
    app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

- **Selector**: Matches pods with the label `app=frontend`.
- **Purpose**: Ensures 3 replicas of pods labeled `app=frontend` are running.

---

### RC Set-Based Example (Invalid)

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: rc-set
spec:
  replicas: 3
  selector:
    matchExpressions:
      - key: app
        operator: In
        values:
        - frontend
        - backend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

**Note**: This example is invalid because **ReplicationController does not support set-based selectors**. You must use a **ReplicaSet** for such functionality.

---

## Key Points

### `selector` Field:
- In **ReplicationController**, the `selector` field is a simple dictionary of key-value pairs.
  - **Example**: `selector: app: frontend`.

### `matchLabels` and `matchExpressions`:
- Not supported in **ReplicationController**.
- These advanced selector mechanisms are only available in **ReplicaSet** and other modern resources like **Deployment**.

---

## Recommendations
- Use **ReplicaSet** for advanced selector capabilities (e.g., `matchLabels`, `matchExpressions`).
- For new workloads, prefer using a **Deployment**, which provides additional features like rolling updates and rollbacks while managing ReplicaSets under the hood.



### **Deployments**  

- A **Deployment** in Kubernetes is a high-level resource that manages **ReplicaSets** and ensures a specified number of pod replicas are running.  
- It provides a way to **declare, update, and scale applications** seamlessly in a Kubernetes cluster.  
- Deployments are the recommended way to handle **rolling updates, scaling, and self-healing**.  

---

### **Key Points**  

- **Automated Updates**: Deployments enable **rolling updates** and **rollback** strategies to maintain application availability.  
- **Scaling**: You can easily **scale up or down** by adjusting the number of replicas.  
- **Self-Healing**: Deployments automatically replace pods if they fail or are deleted.  
- **Declarative Configuration**: Use YAML or JSON files to define desired states for your applications.  

---

### **Basic Syntax**  

#### **Example Deployment YAML**  
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

### **Explanation**  
- **`apiVersion`**: Specifies the API version (`apps/v1`).  
- **`kind`**: Indicates it's a **Deployment** resource.  
- **`metadata`**: Contains the **name** of the deployment.  
- **`spec`**: Defines the desired state:
  - **`replicas`**: Number of pod replicas to maintain.
  - **`selector`**: Uses **label matching** to identify associated pods.
  - **`template`**: Describes the pod specification, including the container image and port.

---

### **Key Features**  

1. **Rolling Updates**  
- Deployments update pods incrementally to avoid downtime.  

**Example**:  
```bash
kubectl rollout status deployment my-deployment
```
- Ensure the update process is complete without service interruptions.

2. **Rollback Support**  
- Kubernetes allows rolling back to previous states with ease.

**Rollback Command**:  
```bash
kubectl rollout undo deployment my-deployment
```
- Roll back to a previous deployment revision if something goes wrong.

3. **Scaling Applications**  
- Deployments allow scaling up or down by adjusting the number of replicas.

**Scale Command**:  
```bash
kubectl scale deployment my-deployment --replicas=5
```
- Adjust the **replicas to 5**, scaling up the application horizontally.

4. **Self-Healing**  
- Kubernetes automatically reschedules pods if they fail or become unresponsive.

---

### **Benefits of Deployments**  
- ✅ **Easy Rollback**  
- ✅ **Declarative Updates**  
- ✅ **Automatic Scaling**  
- ✅ **High Availability & Fault Tolerance**  
- ✅ **Smooth Rolling Updates with No Downtime**

---

### **Common Commands**  

1. **Create a Deployment**  
```bash
kubectl create -f deployment.yaml
```

2. **View Deployments**  
```bash
kubectl get deployments
```

3. **Update a Deployment**  
```bash
kubectl apply -f updated-deployment.yaml
```

4. **Scale a Deployment**  
```bash
kubectl scale deployment my-deployment --replicas=4
```

5. **Rollback a Deployment**  
```bash
kubectl rollout undo deployment my-deployment
```

---

### **Deployment vs. ReplicaSet**  
| **Attribute**       | **Deployment**                  | **ReplicaSet**                   |
|---------------------|---------------------------------|---------------------------------|
| **Purpose**        | Manages updates, rollback, scaling  | Simply maintains a number of pods |
| **API Version**     | `apps/v1`                     | `apps/v1`                        |
| **Updates**        | Integrated with rolling updates | No built-in update support       |
| **Ease of Use**     | More user-friendly            | Requires manual control         |

---

### **Conclusion**  
- **Deployments** provide a powerful and user-friendly way to manage applications in Kubernetes.
- They support **scaling, rolling updates, rollback strategies**, and **self-healing**.
- Using **Deployments** ensures **high availability, fault tolerance**, and **seamless updates**, making it a key component in Kubernetes application management. 🚀

### **Jobs & CronJobs**  

---

### **Jobs**  

- A **Job** in Kubernetes creates one or more pods to perform a task until completion.  
- It ensures that a specified number of pods successfully finish executing a task.  
- Jobs are ideal for **batch processing, data migration**, and **ETL jobs**.  

---

### **Key Points**  
- **Completion Guarantee**: Ensures the specified number of pods **completes successfully**.  
- **Automatic Retry**: Kubernetes retries failed pods until the task is successfully completed.  
- **Resource Management**: Can specify resource requests and limits for better control.  

---

### **Job YAML Example**  
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: my-job
spec:
  parallelism: 1
  completions: 1
  template:
    spec:
      containers:
      - name: myapp
        image: busybox
        command: ["echo", "Running a Job Task"]
      restartPolicy: OnFailure
```

**Explanation:**  
- **`parallelism`**: Number of pods running simultaneously.  
- **`completions`**: Number of pods that must successfully finish.  
- **`restartPolicy`**: Specifies pod restart behavior (`OnFailure` or `Never`).

---

### **Common Job Commands**  
- **View Running Jobs:**  
  ```bash
  kubectl get jobs
  ```

- **View Job Logs:**  
  ```bash
  kubectl logs <pod-name>
  ```

- **Delete a Job:**  
  ```bash
  kubectl delete job my-job
  ```

---

### **CronJobs**  

- A **CronJob** in Kubernetes schedules jobs to run **periodically** at fixed intervals (similar to cron jobs in Linux).  
- It’s ideal for **regular tasks like backups, reporting, and system cleanup**.  

---

### **Key Points**  
- **Scheduled Execution**: CronJobs allow you to automate tasks at specific intervals.  
- **Resource Control**: You can define resource requests and limits for pods.  
- **Time Syntax**: Uses standard **cron syntax** to specify the schedule.  

---

### **CronJob YAML Example**  
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: my-cronjob
spec:
  schedule: "*/5 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: myapp
            image: busybox
            command: ["echo", "Running Cron Job Task"]
          restartPolicy: OnFailure
```

**Explanation:**  
- **`schedule`**: `"*/5 * * * *"` means the job runs **every 5 minutes**.  
- **`jobTemplate`**: Defines the pod specification and container details.  
- **`restartPolicy`**: Determines pod retry behavior.

---

### **Key Differences**  

| **Attribute**       | **Job**                         | **CronJob**                          |
|---------------------|--------------------------------|------------------------------------|
| **Purpose**        | For **one-time tasks**         | For **scheduled, periodic tasks**    |
| **Execution**      | Runs until successful completion | Runs periodically based on schedule   |
| **Configuration**   | Immediate job deployment     | Uses **cron syntax for scheduling**   |
| **Use Cases**       | Batch jobs, data processing   | Scheduled backups, cleanup, ETL tasks |

---

### **Common Commands**  

**For Jobs:**  
- **List Jobs:**  
  ```bash
  kubectl get jobs
  ```
- **Get Pod Logs for Job:**  
  ```bash
  kubectl logs <pod-name>
  ```
- **Delete a Job:**  
  ```bash
  kubectl delete job my-job
  ```

**For CronJobs:**  
- **List CronJobs:**  
  ```bash
  kubectl get cronjobs
  ```
- **View Logs for CronJob Pods:**  
  ```bash
  kubectl logs <cronjob-pod-name>
  ```
- **Delete a CronJob:**  
  ```bash
  kubectl delete cronjob my-cronjob
  ```

---

### **Conclusion**  
- **Jobs** are best suited for **one-time tasks and batch jobs**.  
- **CronJobs** are ideal for **periodic tasks, backups**, and **system maintenance**.  
- Kubernetes **Jobs and CronJobs** together provide robust support for **batch processing, automation, and periodic task scheduling**, ensuring applications remain resilient and maintainable. 🚀