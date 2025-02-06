### **Kyverno - Kubernetes Policy Engine**  

Kyverno is an **open-source policy engine** designed for Kubernetes. It helps enforce security, compliance, and governance rules using **Kubernetes-native policies**. Unlike tools like Open Policy Agent (OPA), Kyverno works directly with **Kubernetes YAML** instead of requiring a new policy language.  

---

### **Key Features**  
✅ **Kubernetes-Native** – Uses YAML-based policies, no need to learn Rego.  
✅ **Validation, Mutation, and Generation** – Enforce, modify, and create resources automatically.  
✅ **Admission Controller** – Blocks non-compliant configurations before they are created.  
✅ **Runtime Enforcement** – Continuously scans and enforces policies.  
✅ **Works with GitOps** – Integrates well with ArgoCD and FluxCD.  

---

### **How Kyverno Works**  
1. **Intercepts API Requests** – Checks if new Kubernetes resources follow policies.  
2. **Applies Policy Rules** – Can validate, mutate, or generate resources.  
3. **Allows, Denies, or Fixes Requests** – Based on policy configuration.  

---

### **Types of Kyverno Policies**  

1️⃣ **Validation Policies** – Block non-compliant resources.  
   🔹 Example: Deny pods running as root.  
   
   ```yaml
   apiVersion: kyverno.io/v1
   kind: ClusterPolicy
   metadata:
     name: disallow-root-user
   spec:
     validationFailureAction: Enforce
     rules:
     - name: check-root
       match:
         resources:
           kinds:
           - Pod
       validate:
         message: "Running as root is not allowed."
         pattern:
           spec:
             securityContext:
               runAsNonRoot: true
   ```

2️⃣ **Mutation Policies** – Modify incoming requests to enforce best practices.  
   🔹 Example: Automatically add a security context to pods.  
   
   ```yaml
   apiVersion: kyverno.io/v1
   kind: ClusterPolicy
   metadata:
     name: add-security-context
   spec:
     rules:
     - name: add-context
       match:
         resources:
           kinds:
           - Pod
       mutate:
         patchStrategicMerge:
           spec:
             securityContext:
               runAsNonRoot: true
   ```

3️⃣ **Generation Policies** – Automatically create or update resources.  
   🔹 Example: Ensure every namespace has a default network policy.  
   
   ```yaml
   apiVersion: kyverno.io/v1
   kind: ClusterPolicy
   metadata:
     name: enforce-network-policy
   spec:
     rules:
     - name: generate-network-policy
       match:
         resources:
           kinds:
           - Namespace
       generate:
         apiVersion: networking.k8s.io/v1
         kind: NetworkPolicy
         name: default-deny
         namespace: "{{request.object.metadata.name}}"
         data:
           spec:
             podSelector: {}
             policyTypes:
             - Ingress
             - Egress
   ```

---

### **Use Cases**  
🔹 **Security Compliance** – Enforce security best practices in Kubernetes.  
🔹 **Auto-fix Configuration Issues** – Ensure every pod has labels, resource limits, etc.  
🔹 **Multi-Tenant Environments** – Prevent one team from modifying resources of another.  
🔹 **Integrate with CI/CD** – Validate Kubernetes manifests before deployment.