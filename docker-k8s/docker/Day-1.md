# Day-1
**Deployment in Physical Machines**
Earlier, applications were run on physical machines, but there was no mechanism to limit how much system resources an application could consume. So, if one application used more resources, it could cause performance issues or even crash other applications. The solution was to run each application on a separate physical machine, but this was a costly approach.
**Deployment in Virtual Machines**
To overcome the cost of running each application on a separate physical machine, we can use virtualization. Virtualization allows us to create independent VMs on a physical machine, providing strong isolation between the VMs. This helps in utilizing the physical machine's resources more effectively. It's hardware-level isolation, and each VM has its own dedicated OS. With the process of application modernization, the backend was decoupled into multiple components, and I don't need a full OS for each component. Running each component in a separate VM leads to resource underutilization, and since each VM has a full OS, scaling and boot times can take minutes.
**Deployment in Containers**
Containerization for running microservices doesn't require a full OS—just the bare minimum OS, the app, its dependencies, and system libraries. Containers don't have a full OS; they use the host machine's OS as a read-only copy to run. This minimal OS setup brings benefits like faster boot-up and quicker scaling. It's a software-level virtualization. In the microservices world, development happens rapidly for faster releases, and containers are easy to move across platforms. They're also faster to spin up and scale.

Virtualization and containerization are two approaches to running multiple applications on the same physical hardware efficiently.
- **Virtualization**: Creates multiple virtual machines (VMs) on a single host, each with its own OS.
- **Containerization**: Runs multiple isolated applications using a shared OS kernel, making it more lightweight and efficient.

**Docker**
Docker is a Containerization tools allows you to package applications and their dependencies into containers, ensuring consistency across different environments.
Image Creation: You can create Docker images, which are lightweight and portable, making it easy to share and deploy applications.
- **Lightweight** – No need for a full OS, only the application and its dependencies.  
- **Portable** – Run anywhere, from local machines to cloud environments.  
- **Fast Deployment** – Containers start in seconds.  
- **Efficient Resource Usage** – Containers share the host OS kernel, making them lightweight and fast compared to virtual machines (VMs).  
- **Scalability** – Easily scale applications up or down based on demand.  
- **Consistency** – The same image runs on all environments, reducing compatibility issues.
**image & container**
An image is a read-only template. When you execute an image, it creates a container, which is a lightweight, running instance of that image. The container has its own set of resources.
### Linux Kernel Features: Namespaces and Cgroups

Namespaces and cgroups are two kernel features. Namespaces provide isolation for processes, so each container has its own users, network stack, hostname, and IPC namespace, preventing interference with other processes. Cgroups allow us to restrict the system resource utilization of containers.

System point of view container also a process with better isolation with kernal features like namespaces and cgroups
Namespaces help containers get their own set of users, network stack, file system, DNS, and hostnames. The IPC namespace ensures that one container doesn't interfere with another, providing isolation between them. Cgroups are used to restrict the resource utilization of containers, ensuring they don’t consume more than their allocated share of CPU, memory, or other system resources.

The IPC (Inter-Process Communication) namespace ensures that containers have isolated communication mechanisms, such as shared memory, message queues, and semaphores. This prevents one container from interfering with the IPC resources of another container, ensuring better isolation between them.

- One container’s shared memory **won’t** be visible to another container.  
- One container’s message queues **won’t** be accessible by processes outside.  

In Linux, all processes share the system's resources, and they are designed to be shareable, using CPU, memory, and other resources based on their needs.

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



# docker installation
#!/bin/bash
dnf install -y git docker tmux tree
systemctl start docker
usermod -aG docker ec2-user
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose