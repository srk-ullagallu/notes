# dockerfile instructions

- `FROM` - Sets the base image  
- `WORKDIR` - Sets the working directory inside the container  
- `RUN` - Executes commands during the image build  
- `COPY` - Copies files from host to container  
- `ADD` - Like COPY but supports remote URLs and auto-extracts archives  
- `CMD` - Default command to run when the container starts (can be overridden)  
- `ENTRYPOINT` - Sets a fixed command that runs inside the container  
- `EXPOSE` - Informs which port the container listens on
- `USER` - instruction in Docker sets the user for running the container. By default, containers run as root, which is a security risk. To run as a non-root user, create a user and switch to it using USER. 

- Shell Mode (`CMD ["sh", "-c", "your_command"]`) runs inside a shell, which may block signals like SIGTERM from reaching the actual process.  
- Exec Mode (`CMD ["your_command"]`) runs the command directly, ensuring proper signal forwarding.  
- Signal Forwarding means when stopping a container (`docker stop`), Docker sends SIGTERM to the main process. In Shell Mode, the shell may not pass it properly, while in Exec Mode, the process receives it correctly.

Example:  
```
FROM ubuntu:latest
RUN useradd -m appuser
USER appuser
CMD ["bash"]
```

This ensures the container runs with limited permissions, reducing security risks. Avoid running containers as root unless absolutely necessary.

**When to Use ENTRYPOINT** 
- When the container must always run a specific application (e.g., nginx, mysqld, etc.).
- When you want to ensure the container runs a single, well-defined process.
**When to Use CMD**
- When you want a default command but allow users to override it.
---

Docker images are made up of multiple layers. Each layer represents a change made during the build process.  

Base layer is the starting point, usually an OS image.  
Intermediate layers are created by instructions like RUN, COPY, ADD.  
Read-only layers are stacked above the base to form the final image.  
Writable layer is added when a container runs, allowing changes.  

Layers help with caching, efficiency, and reusability.
---
You can combine multiple `RUN` instructions in a Dockerfile using `&&` and `\` to reduce the number of layers and optimize the image.  

Example:  

```dockerfile
RUN apt update && \
    apt install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*
```

This reduces image size by minimizing intermediate layers.
---
Multi-stage builds help reduce the final image size by using multiple stages in a Dockerfile.  

1. The first stage compiles or builds the application.  
2. The final stage copies only the necessary files, leaving behind unnecessary dependencies.  

Example:  

```dockerfile
FROM golang:latest AS builder  
WORKDIR /app  
COPY . .  
RUN go build -o myapp  

FROM alpine:latest  
WORKDIR /app  
COPY --from=builder /app/myapp .  
CMD ["./myapp"]  
```

This approach keeps the final image lightweight.
---
- instana project containerization

### Running Container as Root - Problems  

- Running as root gives full control inside the container. If an attacker gains access, they can do anything.  
- If a root container is compromised, it can impact the host system, especially if running in privileged mode.  
- Avoid mounting the host filesystem in read-write mode; use read-only mode to prevent unauthorized changes.  
- Running as a non-root user reduces security risks and limits potential damage.  
- Use Docker security best practices like `USER` in Dockerfile and dropping unnecessary capabilities.

**Best Practices**  
- Use a non-root user in Dockerfile:  
  ```dockerfile
  RUN useradd -m appuser  
  USER appuser  
  ```  
- Set `runAsNonRoot: true` in Kubernetes.  
- Avoid `--privileged` mode.  
- Drop unnecessary capabilities.

# Docker networking

Docker networking allows containers to communicate with each other and external systems while maintaining isolation and flexibility. It enables efficient service discovery, scaling, and secure communication between containers across single or multiple hosts.

- Bridge: Default network, allows containers to communicate on the same host. Custom bridge networks provide better control.  
- Overlay: Used for multi-host communication in Swarm mode.  
- Host: Removes network isolation, directly using the host’s network.  
- None: No networking, fully isolated container.  

For single-host communication, use a bridge network. For multi-host communication, use an overlay network.

docker netowrk create rb
docker network delete rb
docker network inspect rb