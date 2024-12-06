# Why K8s
Containers are an excellent way to bundle and run applications, but they lack mechanisms for high availability (HA), scalability, and auto-healing. This is where Kubernetes (K8s) comes into play. It provides a robust framework that efficiently manages failover, HA, and scalability.

Deployable means "ready to be launched or executed in a system."

**Features**

`Service Discovery & LB`

`Storage Orchestration`

`Automated Rollouts & Rollback`

`Automatic Bin Packing`

`Self Healing`

`Secret and Configuration Managment`

`Dual Stack Support`

`Designed For Extensibility`

`HPA`


## Basics

- **Labels**: Key-value pairs attached to objects (like pods, services, and deployments) that help organize and group similar types of objects. Labels are **arbitrary**, meaning they can be defined by users in any way they choose, allowing for flexible categorization without a predefined structure.

### Equality-based Requirement
- In selectors with **equality-based requirements**, you specify exact matches for labels. For example, if you have a selector that requires `environment=production`, only objects with that exact label will be selected. All specified labels must match for the object to be included.

### Set-based Requirement
- In selectors with **set-based requirements**, you can specify a set of values for a label. For example, you might use a selector to match objects with `environment in {production, staging}`, selecting all objects that have the label `environment` set to either `production` or `staging`. Again, all specified labels must be satisfied for the object to be included.

### Equality-based Requirement Example

**Label**: `role=frontend`

**Selector**:
```yaml
selector:
  matchLabels:
    role: frontend
```
- In this case, the selector requires that the object has the label `role` exactly equal to `frontend`. Only pods or services with this exact label will be selected. For instance, a pod with the label `role=frontend` will be included, while a pod with `role=backend` will not be selected.

### Set-based Requirement Example

**Label**: `tier`

**Selector**:
```yaml
selector:
  matchExpressions:
    - key: tier
      operator: In
      values:
        - frontend
        - backend
```
- Here, the selector specifies that the label `tier` must be one of the values in the set `{frontend, backend}`. This means that any object with the label `tier` set to either `frontend` or `backend` will be selected. For example, a pod with `tier=frontend` or `tier=backend` will match, while one with `tier=database` will not.

### Selectors
- **Selectors** are used to identify or map two different objects in Kubernetes. They allow you to filter and select resources based on their labels, enabling efficient management and organization of objects within the cluster.


In the context of Kubernetes, **annotations** are non-arbitrary key-value pairs that provide additional metadata about an object, such as a pod. Unlike labels, which are used for grouping and selection, annotations are intended for storing supplementary information that does not affect the execution or scheduling of the pod.

### Key Characteristics of Annotations:

- **Non-arbitrary**: Annotations are typically used to store structured metadata that has specific meanings or uses, often defined by tools, libraries, or systems interacting with Kubernetes. While users can define their own keys, there are common conventions or formats used within the ecosystem.

- **Supplemental Information**: Annotations allow you to attach useful information to a pod without impacting its behavior. For example, they can be used to specify details like `TargetGroupBinding` for integrating with AWS Application Load Balancers (ALBs) or other configuration parameters.

- **Retrieval by Clients**: Tools, libraries, and other clients can easily retrieve this metadata, which can be utilized for various purposes, such as monitoring, management, or operational insights.

### Example Annotation Structure

Here’s an example of how annotations might be structured in a pod definition:

```yaml
metadata:
  annotations:
    key1: "value1"
    key2: "value2"
```

In this example:
- `key1` and `key2` are arbitrary keys used to store specific metadata.
- The values `value1` and `value2` can represent any relevant information, such as operational instructions or configurations that other systems or tools may use to interact with the pod. 


In Kubernetes, **namespaces** are a powerful mechanism for isolating and organizing resources within a single cluster. Here’s a breakdown of their characteristics and benefits:

### Overview of Namespaces

- **Isolation**: Namespaces allow you to isolate groups of resources, making it easier to manage and control access in multi-user or multi-team environments.

- **Name Uniqueness**: Resource names must be unique within a namespace but do not need to be unique across different namespaces. For example, you can have a Deployment named `frontend` in both the `dev` and `prod` namespaces.

- **Non-Nested Structure**: Namespaces cannot be nested; each Kubernetes resource belongs to exactly one namespace.

### When to Use Namespaces

Namespaces are especially useful in environments with many users, teams, or projects. For clusters with just a few users, namespaces may not be necessary. You should start using them when you require the organizational features they provide.

### Benefits of Using Namespaces

- **Resource Quotas**: You can apply resource quotas to limit the amount of resources (CPU, memory, etc.) that can be consumed by the resources in a namespace. This helps prevent any single team or project from monopolizing cluster resources.

- **Role-Based Access Control (RBAC)**: Namespaces allow you to implement RBAC, enabling you to define who can access or modify resources in specific namespaces, enhancing security and management.

- **Resource Group Isolation**: By organizing resources into namespaces, you can achieve logical separation of applications or environments (e.g., dev, staging, production), making it easier to manage different groups of resources independently.

- **Easy Management**: Namespaces simplify the management of resources, allowing for easier cleanup, monitoring, and organization, especially in larger clusters.

### Example Namespace Definition

Here’s an example of how to create a namespace in Kubernetes:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
```

### Namespaces and DNS in Kubernetes

In Kubernetes, when you create a **Service**, a corresponding DNS entry is automatically generated to enable service discovery. This entry follows a specific naming convention that incorporates the service name and the namespace. 

### DNS Entry Format

The format for the DNS entry of a Service is:

```
<service-name>.<namespace-name>.svc.cluster.local
```

### Key Points

- **Local Resolution**: When a container within a namespace references a service by its `<service-name>`, it will resolve to the service that is local to that namespace. This allows for straightforward communication between pods and services within the same namespace.

- **Namespace Isolation**: This DNS mechanism is beneficial for maintaining the same configuration across multiple namespaces (e.g., Development, Staging, and Production). For instance, you can have a service named `app` in both the `development` and `production` namespaces, and each will be accessible within its respective namespace using just `app`.

- **Cross-Namespace Communication**: If you need to access a service in a different namespace, you must use the **fully qualified domain name (FQDN)**. For example, to access a service named `app` in the `staging` namespace from another namespace, you would use:

```
app.staging.svc.cluster.local
```

This FQDN specifies the exact service in the desired namespace, ensuring that the correct resource is accessed, regardless of other services with the same name in different namespaces.

### Example

For instance, if you have the following services:

- **Development Namespace**: 
  - Service Name: `app`
  - DNS: `app.development.svc.cluster.local`

- **Production Namespace**:
  - Service Name: `app`
  - DNS: `app.production.svc.cluster.local`

A pod in the `development` namespace can simply use `app` to connect to its service, while a pod in the `production` namespace will need to use `app.production.svc.cluster.local` to connect to the production service. This structure helps maintain clarity and prevents name collisions across environments.