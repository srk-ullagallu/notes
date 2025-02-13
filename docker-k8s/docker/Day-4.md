# Deploy the instana project in ECS
# Docker Best Practices
- ✅ **Use official images** – They are secure and well-maintained.  
- ✅ **Use small base images** – Reduces image size and attack surface (`alpine`, `distroless`).  
- ✅ **Use multi-stage builds** – Keeps final images small by removing unnecessary dependencies.  
- ✅ **Use a custom user instead of root** – Improves security by restricting privileges.  
- ✅ **Minimize layers** – Combine `RUN` commands to reduce unnecessary layers.  
- ✅ **Use `.dockerignore`** – Exclude unnecessary files (`node_modules`, `.git`, etc.).  
- ✅ **Tag images properly** – Avoid using `latest`; use specific versions (`nginx:1.25`).  
- ✅ **Keep containers stateless** – Store data in volumes instead of inside containers.  
- ✅ **Limit container privileges** – Use `--read-only`, `--cap-drop`, and `seccomp` profiles.  
- ✅ **Regularly scan images** – Use tools like `trivy` or `docker scan` for vulnerabilities.  
