**physicalmachines**

- running multiple app on same machine
- problem is one app consumes more resources of a host sysmtem that causes another app under perform or may down
- there is no way to create resournce boundaries for app
- solution is run each app on seperate machine that is costly solution to ensure HA and Scalability

**virtualmachines**

- Virtualization is able to create multiple indepenedent machines on same host machine with this technology we can efficiently use host machine resources
- Each and every vm has a full os virtualization creates strong isolation b/w vm's
- Application architecture was modernized over years from monolith to 3-tier to N-tier architecture means micro services
- Running Micro services on vm is a resources are underutilized
- To start and Scale the vms takes time because it's full os 

**containers**

- unlike vms containers are process level isolation means s/w level isolation
- containers does not require full os unlike vm these containers use host machine os as read-only template to run the containers
- So containers are very fast in terms of spinup and scale the containers

Virtualization and containerization are two approaches to running multiple applications on the same physical hardware efficiently.
---

**what is docker & features**

- docker is containerization tool to packaging  app + dependencies + bare minimum os and system libs it solves the problem of runs in my machine maintains consistent,reliable and portable solution

- `Lightweight` – No need for a full OS, only the application and its dependencies.  
- `Portable` – Run anywhere, from local machines to cloud environments.  
- `Fast Deployment` – Containers start in seconds.  
- `Efficient Resource Usage` – Containers share the host OS kernel, making them lightweight and fast compared to virtual machines (VMs).  
- `Scalability` – Easily scale applications up or down based on demand.  
- `Consistency` – The same image runs on all environments, reducing compatibility issues.

An `image` is a read-only template. When you execute an image, it creates a container, which is a lightweight, running instance of that image. The container has its own set of resources.

Linux `kernel` creates an instance of that program in memory, assigns it resources, and gives it a unique Process ID (PID)—this is called a process

---

**what is container**
Running instances of images. A container is like a lightweight virtual machine with read-write capabilities. It can be created, started, stopped, paused, resumed, and removed.
**basic commands**

`container management commands`  run,pause,unpause,stop,rm

`container logs` logs

`container realtime monitoring` stats

`inspecting the objects` inspect

`image management commands` build,rmi,history,images

---
**Docker Client-Server Architecture** 

Docker follows a client-server architecture where the Docker Client interacts with the Docker Daemon (Server) to manage containers.  

1. Docker Client  
- Acts as the interface between the user and the Docker daemon.  
- Sends commands (like `docker run`, `docker build`, `docker ps`) to the daemon using REST API over UNIX socket or TCP.  
- Can be a CLI (`docker` command) or GUI-based tools like Docker Desktop.  

2. Docker Daemon (Server)  
- Runs in the background and handles all container operations.  
- Listens for requests from the client and manages:  
  - Containers 
  - Images  
  - Networks  
  - Volumes  
- Uses container runtime (like `containerd`) to execute containers.  

3. Docker Registry (Optional)  
- A remote or local repository to store and share Docker images.  
- Example: Docker Hub, AWS ECR, GCR, or private registry.  
- Commands:  
  - `docker push` → Uploads an image.  
  - `docker pull` → Downloads an image.  

How Docker Works (Flow)  
1. The Docker Client runs a command (`docker run nginx`).  
2. The Docker Daemon checks if the image exists locally.  
3. If not, it pulls the image from a Docker Registry (e.g., Docker Hub).  
4. The daemon creates a container using the image.  
5. The container runs in an isolated environment with its dependencies.  

Key Takeaways  
- Client sends commands.  
- Daemon (Server) executes container tasks.  
- Registry stores images.  
- Container runtime runs the actual containers.

---

**container life cycle**
Container Life Cycle involves several phases:  

1. Created → The container is created but not running yet.  
2. Running → The container is actively executing processes.  
3. Paused → The container’s processes are temporarily halted.  
4. Stopped (Exited) → The container has been stopped (graceful shutdown).  
5. Killed → The container is forcefully stopped.  
6. Restarted → The container stops and starts again.  
7. Removed → The container is permanently deleted.  

Each phase represents a different state in the container’s lifecycle.  

**namespaces & cGroups**
namespaces and cGroups are 2 kernal features namespaces provides isolation each and every container behaves like independent machine
where as each container as it's own 1.file system 2.users 3.hostname 4.network stack 5. process and cGroups help us control resournces usage[memory,cpu,diskI/O] each containers run as process in host machine becuase of namespaces
