# Deployment in Physical Virtual and containers

1. Earlier, applications ran on physical machines without any resource limits.  
2. If one application used too many resources, it could slow down or crash other applications.  
3. To avoid this, companies started running each application on a separate physical machine.  
4. However, this approach was expensive because each machine was underutilized.  
5. A better solution was needed to efficiently use system resources while keeping applications isolated.

- **Virtualization**: Creates multiple virtual machines (VMs) on a single host, each with its own OS.
1. Running each application on a separate physical machine was costly and inefficient.  
2. Virtualization solved this by allowing multiple independent VMs on a single physical machine.  
3. Each VM provides strong isolation and has its own dedicated OS.  
4. This improved resource utilization and reduced hardware costs.  
5. With application modernization, the backend was decoupled into multiple components.  
6. Running each component in a separate VM led to resource underutilization.  
7. Since each VM has a full OS, scaling and boot times became slow (taking minutes).  
8. A more efficient solution was needed to optimize resource usage and improve scalability.

- **Containerization**: Runs multiple isolated applications using a shared OS kernel, making it more lightweight and efficient.
1. Containerization eliminates the need for a full OS for each application component.  
2. A container includes only the bare minimum OS, the app, its dependencies, and system libraries.  
3. Containers share the host machine’s OS as a read-only copy instead of having their own OS.  
4. This minimal setup enables faster boot-up and quicker scaling.  
5. Containers use software-level virtualization, unlike VMs, which use hardware-level isolation.  
6. In a microservices architecture, development happens rapidly for faster releases.  
7. Containers are easy to move across platforms, making deployments more flexible.  
8. They spin up quickly and scale efficiently, improving overall system performance.

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

# What is Docker
# What is Container
# Difference b/w vm and containers
# What is virtualization and containerization
# What are namespaces and cgroups
