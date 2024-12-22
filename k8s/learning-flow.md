# What is k8s?

# Why K8s?
[k8s archi and features](https://kubernetes.io/docs/concepts/overview/#why-you-need-kubernetes-and-what-can-it-do)

# k8s architecture
[k8s architecture](https://kubernetes.io/docs/concepts/overview/components/)

# ClusterSetup
- kubeadm
- kops
- eks
- minikube
- kind

# Basics
- Labels & Selectors,Annotatios
- Namespaces
- pod
- initcontainers,sidecar,proxy

# Workloads
- ReplicaSet & Replication Controller
- Deployment
  - Scaling[HPA,KEDA]
- Job
- CronJob
- DaemonSet
- StatefulSet

# Services[Networking]
- ClusterIP
- NodePort
- LoadBalancer
- ExternalName
- Headless Service
- Ingress
- CoreDNS,ExternalDNS
- API GW
- ISTIO

# Storage
- pv,pvc,sc
- Static volume provisioning
- Dynamic volume provisioning

# Advance Scheduling
- nodeselector
- affinity
- anti-affinity
- Taints&Tolerations

# Configuration
- configmap
- secrets
- probes[liveness,readiness]

# Security
- RBAC
- Service Account
# Packaging&Templatizing
- HELM 
- Kustomization

# Quotas
- ResourceQuotas
- HELM,Kustomization
# Nodes Scaling
- Cluster Auto Scalar
- Karpenter

# Extened K8s
- CRDS
- Operator

# Observability
- Prometheus&Grafana
- Elastic Stack

