# Deployment in Physical Virtual and containers

Earlier, applications were run on physical machines, but there was no mechanism to limit how much system resources an application could consume. So, if one application used more resources, it could cause performance issues or even crash other applications. The solution was to run each application on a separate physical machine, but this was a costly approach.

- **Virtualization**: Creates multiple virtual machines (VMs) on a single host, each with its own OS.
To overcome the cost of running each application on a separate physical machine, we can use virtualization. Virtualization allows us to create independent VMs on a physical machine, providing strong isolation between the VMs. This helps in utilizing the physical machine's resources more effectively. It's hardware-level isolation, and each VM has its own dedicated OS. With the process of application modernization, the backend was decoupled into multiple components, and I don't need a full OS for each component. Running each component in a separate VM leads to resource underutilization, and since each VM has a full OS, scaling and boot times can take minutes.

- **Containerization**: Runs multiple isolated applications using a shared OS kernel, making it more lightweight and efficient.
Containerization for running microservices doesn't require a full OS—just the bare minimum OS, the app, its dependencies, and system libraries. Containers don't have a full OS; they use the host machine's OS as a read-only copy to run. This minimal OS setup brings benefits like faster boot-up and quicker scaling. It's a software-level virtualization. In the microservices world, development happens rapidly for faster releases, and containers are easy to move across platforms. They're also faster to spin up and scale.

Virtualization and containerization are two approaches to running multiple applications on the same physical hardware efficiently.
---
# Docker
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

Linux kernel creates an instance of that program in memory, assigns it resources, and gives it a unique Process ID (PID)—this is called a process

# docker installation
#!/bin/bash
dnf install -y git docker tmux tree
systemctl start docker
usermod -aG docker ec2-user
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

---

## **Docker Objects**  
- **Images**: Read-only templates used for creating containers. An image includes a base OS, application code, application dependencies, and required system dependencies.  
- **Containers**: Running instances of images. A container is like a lightweight virtual machine with read-write capabilities. It can be created, started, stopped, paused, resumed, and removed.  
- **Networks**: Enable communication between containers or expose a container for external access over the internet.  
- **Volumes**: Containers are ephemeral, meaning their data is not persistent and is lost when the container stops or is removed. Volumes help persist data across container restarts.  

---

## **Docker Architecture**  
1. **Docker CLI**: A command-line interface used to interact with Docker by running commands.  
2. **Docker Daemon**: The server process responsible for managing Docker objects such as images, containers, volumes, and networks.  
3. **REST API**: Provides a programmatic interface to manage Docker objects.  
4. **Container Runtime**: The component that actually runs the containers.  
5. **Images**: Pre-built templates used to create containers.  
6. **Containers**: Running instances of images that execute applications in isolated environments.  
7. **Repositories**: Storage locations (e.g., Docker Hub, AWS ECR) where images are stored and shared.  

---
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

## **Difference Between VM and Container**  

### **Virtualization vs. Containerization**  

| **Aspect**          | **Virtualization** (VMs) | **Containerization** (Containers) |  
|--------------------|------------------------|---------------------------------|  
| **Isolation Type** | **Hardware-level** isolation | **Software-level** isolation |  
| **OS Requirement** | Each VM has a **full OS** | Shares the **host OS kernel** |  
| **Resource Usage** | Requires more CPU, RAM, and storage | Lightweight, uses fewer resources |  
| **Startup Time**   | Takes **minutes** to boot | Starts in **seconds** |  
| **Performance**    | Slightly slower due to OS overhead | Faster as it avoids full OS overhead |  
| **Use Case**       | Best for running **different OSs** on the same host | Best for **microservices and scalable apps** |  

✅ **Virtualization** → Runs multiple OSs on a single machine.  
✅ **Containerization** → Runs multiple apps using a shared OS for efficiency.
---

### **Meaning of Isolation in Virtualization & Containerization**  

**Isolation** means keeping applications and their dependencies **separated** from each other to prevent conflicts, improve security, and ensure stability.  

#### **1. Isolation in Virtualization (VMs) → Hardware-Level Isolation**  
- Each VM runs its **own operating system** on top of a **hypervisor**.  
- Resources (CPU, memory, storage) are **allocated separately** to each VM.  
- Even if one VM crashes, it does not affect other VMs.  
- Example: Running **Windows and Linux VMs** on the same host.  

#### **2. Isolation in Containerization → Software-Level Isolation**  
- Containers **share** the **host OS kernel** but keep applications **separate**.  
- Each container has its **own file system, network, and process space**.  
- Containers are **lightweight** compared to VMs but still **prevent conflicts**.  
- Example: Running multiple **Node.js and Python apps** in different containers on the same host.  

✅ **Isolation prevents interference between applications** while allowing them to run efficiently. 🚀
