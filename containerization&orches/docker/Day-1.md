# Day-1
`physical machines` 

`virtual machines`

`containerization`

`docker`

`container`

`image`

---
### Linux Kernel Features: Namespaces and Cgroups
- Process in Linux are share the resources
Containers are possible because of these two core Linux kernel features:  

### **📌 Namespaces** (Isolation)  
Namespaces ensure that each container runs in its own environment without interfering with others.    
- **USER Namespace**: Provides user-level isolation.  
- **PID (Process ID)**: Isolates process IDs, ensuring each container has its own process space.
- **NET (Networking)**: Provides separate network interfaces for each container.
- **MNT (Mount)**: Controls file system access within a container.
- **UTS (Unix Timesharing System)**: Allows each container to have its own hostname.
- **IPC (Inter-Process Communication)**: Isolates shared memory and message queues.

### **📌 Cgroups (Resource Management)**  
Cgroups control resource usage (CPU, memory, disk I/O) for containers to prevent one from consuming too many resources.  
- **CPU Cgroup** – Limits CPU usage per container.  
- **Memory Cgroup** – Restricts RAM allocation per container.  
- **I/O Cgroup** – Controls disk access speed. 


---
### Docker Architecture
1. **Docker CLI**: User interacts with Docker using commands.
2. **Docker Daemon**: Manages Docker objects and executes commands.
3. **Container Runtime**: Runs containers.
4. **Images**: Templates for containers.
5. **Containers**: Runnable instances of images.
6. **Repositories**: Store and share images.

---

### **Visual Representation of Docker Architecture**

```
+-------------------+       +-------------------+       +-------------------+
|   Docker CLI      | <---> | Docker Daemon     | <---> | Container Runtime |
| (User Interface)  |       | (Docker Engine)   |       | (runc, containerd)|
+-------------------+       +-------------------+       +-------------------+
                                      |
                                      v
                              +-------------------+
                              | Docker Images     |
                              | (Read-only)       |
                              +-------------------+
                                      |
                                      v
                              +-------------------+
                              | Docker Containers |
                              | (Runnable)        |
                              +-------------------+
                                      |
                                      v
                              +-------------------+
                              | Repositories      |
                              | (Docker Hub, etc.)|
                              +-------------------+
```






































































































































































































# Day-1
---
## **1.Virtualization and Containerization**
Virtualization and containerization are two approaches to running multiple applications on the same physical hardware efficiently.
- **Virtualization**: Creates multiple virtual machines (VMs) on a single host, each with its own OS.
- **Containerization**: Runs multiple isolated applications using a shared OS kernel, making it more lightweight and efficient.
---
 ## **2. What is Docker? Benefits of Docker?**  
Docker is a containerization tool used to package applications along with their dependencies into lightweight, portable containers. It eliminates the "works on my machine" issue by ensuring the same environment across development, testing, and production.

### **✅ Benefits of Docker:**  
- **Lightweight** – No need for a full OS, only the application and its dependencies.  
- **Portable** – Run anywhere, from local machines to cloud environments.  
- **Fast Deployment** – Containers start in seconds.  
- **Efficient Resource Usage** – Containers share the host OS kernel, making them lightweight and fast compared to virtual machines (VMs).  
- **Scalability** – Easily scale applications up or down based on demand.  
- **Consistency** – The same image runs on all environments, reducing compatibility issues.  
---
## **3. What is a Container? Benefits of a Container?**  
A **container** is a lightweight, standalone, and executable package that includes everything needed to run a piece of software, such as the code, runtime, libraries, and system tools. Containers are isolated from each other and the host system, ensuring that they run consistently across different environments.  

### **✅ Benefits of Containers:**  
- **Uses Less Resources** – No need to install a full OS for every application.  
- **Faster Startup** – No OS boot required, just starts the application.  
- **Better Isolation** – Containers run independently, preventing conflicts between applications.  
- **Simplifies DevOps** – Developers and operations teams can work with the same container images in different environments.  
---
## **4. Difference Between VM and Container**  

| Feature           | Virtual Machine (VM) | Container |
|------------------|---------------------|-----------|
| **Size** | Large (GBs) | Small (MBs) |
| **Startup Time** | Slow (OS boot required) | Fast (just starts the app) |
| **Resource Usage** | High (each VM has its own OS) | Low (shares host OS kernel) |
| **Isolation** | Complete (separate OS per VM) | Process-level (namespaces, cgroups) |
| **Performance** | Slower due to OS overhead | Faster as there is no extra OS |
| **Portability** | Less portable (depends on OS) | Highly portable (runs anywhere) |

**Containers are more efficient than VMs** because they don’t require an additional OS. 
---



