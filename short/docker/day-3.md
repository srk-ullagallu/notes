# Docker volumes
Containers are ephemeral, meaning they don’t persist data after termination or restart. To preserve data beyond the container lifecycle, we use volumes.
1. Named Volumes  
   - Created and managed by Docker.  
   - Persist beyond container removal.  
   - Used for sharing data between containers.  
   - Example:  
     ```
     docker volume create myvolume
     docker run -v myvolume:/data ubuntu
     ```  

2. Anonymous Volumes  
   - Temporary volumes without a name.  
   - Exist only as long as the container runs.  
   - Deleted when the container is removed.  
   - Example:  
     ```
     docker run -v /data ubuntu
     ```  

3. Bind Mounts  
   - Mounts a host file/folder into the container.  
   - Can expose host data to containers.  
   - Best practice is to use read-only mode to prevent security risks.  
   - Example:  
     ```
     docker run -v /host/path:/container/path:ro ubuntu
     ```  
   - `ro` (read-only) ensures the container cannot modify host files.  
   - If `rw` (read-write) is used, a vulnerable container can get full control over the host filesystem.

# docker compose  
Docker Compose is a tool to define and manage **multi-container** Docker applications using a `docker-compose.yml` file.

### Why Use Docker Compose?  
- **Simplifies multi-container setup** (e.g., app + database).  
- **Easy to configure** services, networks, and volumes.  
- **Single command to start/stop** all services (`docker-compose up/down`).  

### Basic `docker-compose.yml` Example  
```yaml
version: "3.8"

services:
  app:
    image: myapp
    ports:
      - "8080:80"
    depends_on:
      - db

  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: testdb
```

### Key Commands  
- `docker-compose up -d` → Start all services in detached mode.  
- `docker-compose down` → Stop and remove containers.  
- `docker-compose ps` → List running services.  
- `docker-compose logs` → View logs.  
- `docker-compose exec app sh` → Access a running container.  

### Use Cases  
- Running **microservices**  
- **Local development** environments  
- Defining **test setups** with databases, message brokers, etc.

# docker best practices
- Official image
- Multi stage docker build to keep image size less
- Avoid containers run as root user
- Use .dockerignore to exclude unnecessary files.
- Combine multiple RUN instructions to reduce image layers.
- Use specific image versions instead of latest.
- Regularly update images to patch security vulnerabilities.
- Clean up unused images, containers, and volumes to free up space.
- Use environment variables for configuration instead of hardcoding.
- Prefer CMD over ENTRYPOINT unless strict execution control is needed.
- 
