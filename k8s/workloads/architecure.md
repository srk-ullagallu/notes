# K8s Architecture

K8s by default Cluster In nature, cluster is nothing but a group of nodes,some nodes acts as a `control plane` some `worker nodes`

`control plane` is responsible to manage containers like placement,keep the configuration,ensure HA, Scalability and healing of the containers.

Where as `worker nodes` responsible to host the workloads[applications] are running here

*Master Node Components*

The `apiserver` is the single entry point for requests, handling authentication (verifying identity), authorization (checking permissions), and validation before storing request configurations in etcd.

The `Scheduler` is responsible for pod placement. It receives requests from the `apiserver`, retrieves node statistics, and runs filtering and scoring algorithms to find the best-fit node. The response is sent back to the `apiserver`, which then updates the scheduling configuration in etcd.

`etcd` is a high-availability key-value data store that holds the entire cluster configuration.

The `Controller Manager` is responsible for maintaining the cluster's desired state by monitoring and adjusting resources. It includes controllers like `ReplicaSet`, `Deployment`, `EndpointController`, `Node`, and `Job` controllers, which ensure that pods, deployments, endpoints, and other resources align with the cluster's specifications.

In EKS, the `Cloud Controller Manager` manages integration with AWS cloud services. It handles tasks like provisioning AWS resources (e.g., load balancers, EBS volumes), managing node lifecycles, and updating routes. This allows Kubernetes to leverage AWS infrastructure efficiently within an EKS cluster.

*Worker Node Components*

 `kubelet` An agent running on each node that takes instructions from the `apiserver` to create and manage pods, while also updating pod status back to the `apiserver`.

- `kube-proxy` Manages networking for pods on each node, handling routing, load balancing, and maintaining network rules for cluster communication.

- `CRI` (Container Runtime Interface) Responsible for creating and managing containers, supporting container operations as directed by Kubernetes.

**Flow of `kubectl apply -f pod.yaml`:**

1. The `API server` receives the request.
2. It writes the configuration to `etcd`.
3. The `API server` passes the pod configuration to the `Scheduler` for pod placement.
4. The `Scheduler` requests node information from the `API server`.
5. The `API server` fetches node information from `etcd`.
6. The `API server` hands over the node information to the `Scheduler`.
7. The `Scheduler` runs an algorithm for pod placement, considering any constraints the pod may have.
8. The `Scheduler` returns the pod placement information to the `API server`.
9. The `API server` updates the pod placement information in `etcd`.
10. The `API server` calls the `kubelet` on the respective node and passes the pod information.
11. The `kubelet` instructs the container runtime to create the container.
12. Once the container is created, the `kubelet` wraps it as a pod.
13. The `kubelet` sends the pod creation status back to the `API server`.
14. The `API server` updates the pod status in `etcd`.
15. The `API server` responds to the client with the pod creation status.



Absolutely! Let’s break down **kube-proxy** and its role in managing **network rules** for **Pods** and **Services** in Kubernetes.

---

## 📚 **What is kube-proxy?**

- `kube-proxy` is a **networking component** that runs on each **node** in a Kubernetes cluster.  
- It ensures that **network traffic** is properly routed between **Pods** and **Services**.  
- It manages **IPtables**, **IPVS**, or other networking backend rules to enable communication.  

In short: It **routes traffic** from **Services** to the appropriate **Pods**.

---

## 🛠️ **How kube-proxy works with Services and Pods**

### 1️⃣ **Services and kube-proxy**

- A **Service** in Kubernetes provides a stable IP and DNS name for a group of **Pods**.
- kube-proxy listens to the Kubernetes API server for **Service** and **Endpoints** changes.
- It creates and updates **network rules** on each node based on these changes.

#### Example: ClusterIP Service
- A `ClusterIP` Service is exposed internally in the cluster.
- kube-proxy sets up rules so that traffic to the **Service IP** is load-balanced to one of the **Pod IPs** behind it.

### 2️⃣ **Endpoints and kube-proxy**

- When a Pod is created or deleted, Kubernetes updates the **Endpoints** of the Service.
- kube-proxy dynamically updates the network rules to point to the correct set of **Pod IPs**.

---

## ⚙️ **Modes of kube-proxy**

1. **iptables (default on most systems)**  
   - Uses `iptables` rules to redirect traffic.
   - Packets are sent directly to the Pod IP.

2. **IPVS (IP Virtual Server)**  
   - More efficient for large-scale clusters.
   - Handles load balancing in the kernel space.

3. **Userspace (legacy, rarely used)**  
   - kube-proxy forwards traffic in user space.
   - Slower and less efficient.

---

## 🌐 **How Traffic Flows (Example)**

1. A client makes a request to the **Service IP** (`ClusterIP`) on port `80`.
2. kube-proxy intercepts this traffic.
3. It checks the **Endpoint** list for the Service.
4. Based on the rules, it forwards the traffic to one of the **Pod IPs** behind the Service.

### 🔄 **If a Pod is Removed**
- kube-proxy detects the change via the Kubernetes API.
- It updates the network rules to remove the stale Pod IP from the Service's Endpoints.

---

## 🧠 **Key Takeaways**
- **kube-proxy** ensures that requests to a **Service IP** are routed to the correct **Pod IP**.
- It uses either **iptables**, **IPVS**, or **userspace** to manage network rules.
- kube-proxy adapts dynamically when Pods are added, removed, or changed.

Let me know if you’d like a deep dive into **iptables** or **IPVS** modes, or if you have a specific scenario in mind! 🚀


 