# What is k8s?

# Why K8s?
[k8s archi and features](https://kubernetes.io/docs/concepts/overview/#why-you-need-kubernetes-and-what-can-it-do)[1]

# k8s architecture
[k8s architecture](https://kubernetes.io/docs/concepts/overview/components/)[1]

# ClusterSetup
- kubeadm[1]
- kops[1]
- eks[1]
- minikube
- kind

# Basics
- Labels & Selectors[1],Annotatios
- Namespaces[1]
- pod[1]
- initcontainers,sidecar,proxy

# Workloads
- ReplicaSet & Replication Controller[1]
- Deployment[1]
  - Scaling[HPA,KEDA]
- Job
- CronJob
- DaemonSet
- StatefulSet

# Services[Networking]
- ClusterIP[1]
- NodePort[1]
- LoadBalancer[1]
- ExternalName
- Headless Service
- Ingress
- CoreDNS[1],ExternalDNS
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

