Here’s a list of commonly used `kubectl` commands categorized by actions and resources. These commands are widely used for managing Kubernetes clusters.

---

### **1. Cluster Interaction**
- **Check cluster status**:
  ```bash
  kubectl cluster-info
  kubectl get nodes
  ```
- **View config and switch contexts**:
  ```bash
  kubectl config view
  kubectl config use-context <context-name>
  ```

---

### **2. Pods**
- **List all pods**:
  ```bash
  kubectl get pods
  kubectl get pods -o wide
  kubectl get pods --all-namespaces
  ```
- **Describe a pod**:
  ```bash
  kubectl describe pod <pod-name>
  ```
- **Stream pod logs**:
  ```bash
  kubectl logs <pod-name>
  kubectl logs -f <pod-name>
  kubectl logs <pod-name> --container <container-name>
  ```
- **Execute a command inside a pod**:
  ```bash
  kubectl exec -it <pod-name> -- <command>
  kubectl exec -it <pod-name> -- bash
  ```

---

### **3. Deployments**
- **List all deployments**:
  ```bash
  kubectl get deployments
  ```
- **Describe a deployment**:
  ```bash
  kubectl describe deployment <deployment-name>
  ```
- **Scale a deployment**:
  ```bash
  kubectl scale deployment <deployment-name> --replicas=<number>
  ```
- **Update a deployment**:
  ```bash
  kubectl set image deployment/<deployment-name> <container-name>=<new-image>
  ```
- **Rollback a deployment**:
  ```bash
  kubectl rollout undo deployment/<deployment-name>
  ```

---

### **4. Services**
- **List all services**:
  ```bash
  kubectl get services
  kubectl get svc
  ```
- **Describe a service**:
  ```bash
  kubectl describe service <service-name>
  ```
- **Expose a deployment as a service**:
  ```bash
  kubectl expose deployment <deployment-name> --type=<service-type> --port=<port> --target-port=<target-port>
  ```

---

### **5. ConfigMaps and Secrets**
- **Create a ConfigMap**:
  ```bash
  kubectl create configmap <configmap-name> --from-literal=<key>=<value>
  ```
- **List ConfigMaps**:
  ```bash
  kubectl get configmaps
  ```
- **Create a Secret**:
  ```bash
  kubectl create secret generic <secret-name> --from-literal=<key>=<value>
  ```
- **List Secrets**:
  ```bash
  kubectl get secrets
  ```

---

### **6. Namespaces**
- **List all namespaces**:
  ```bash
  kubectl get namespaces
  ```
- **Create a namespace**:
  ```bash
  kubectl create namespace <namespace-name>
  ```
- **Delete a namespace**:
  ```bash
  kubectl delete namespace <namespace-name>
  ```
- **Use a namespace**:
  ```bash
  kubectl config set-context --current --namespace=<namespace-name>
  ```

---

### **7. Nodes**
- **List all nodes**:
  ```bash
  kubectl get nodes
  ```
- **Describe a node**:
  ```bash
  kubectl describe node <node-name>
  ```
- **Cordon and uncordon a node**:
  ```bash
  kubectl cordon <node-name>    # Mark node as unschedulable
  kubectl uncordon <node-name>  # Mark node as schedulable
  ```
- **Drain a node**:
  ```bash
  kubectl drain <node-name> --ignore-daemonsets
  ```

---

### **8. Persistent Volumes (PV) and Persistent Volume Claims (PVC)**
- **List PVs and PVCs**:
  ```bash
  kubectl get pv
  kubectl get pvc
  ```
- **Describe a PV or PVC**:
  ```bash
  kubectl describe pv <pv-name>
  kubectl describe pvc <pvc-name>
  ```

---

### **9. Monitoring and Debugging**
- **Check resource usage**:
  ```bash
  kubectl top nodes
  kubectl top pods
  ```
- **Debug pod issues**:
  ```bash
  kubectl describe pod <pod-name>
  kubectl logs <pod-name>
  kubectl exec -it <pod-name> -- bash
  ```

---

### **10. Apply and Manage Resources**
- **Apply YAML configuration**:
  ```bash
  kubectl apply -f <file.yaml>
  ```
- **Delete resources**:
  ```bash
  kubectl delete <resource> <name>
  kubectl delete -f <file.yaml>
  ```
- **Dry-run mode**:
  ```bash
  kubectl apply -f <file.yaml> --dry-run=client
  ```
- **View applied configuration**:
  ```bash
  kubectl get <resource> <name> -o yaml
  ```

---

### **11. Miscellaneous**
- **Run a pod quickly**:
  ```bash
  kubectl run <pod-name> --image=<image> --restart=Never
  ```
- **Create a resource from a file**:
  ```bash
  kubectl create -f <file.yaml>
  ```
- **Port forward**:
  ```bash
  kubectl port-forward <pod-name> <local-port>:<pod-port>
  ```

This set of commands will cover most of your daily Kubernetes tasks. Let me know if you need further details! 😊