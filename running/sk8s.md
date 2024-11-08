# 1-7-24
volumes in k8s

EBS[BlcokStorage][Suitable for OS,Gives High Throughput]
- It is a hard disk both server and volume should be in az
- volume is static means it won't increase it size automatically
- Suitalbe for OS,DB
- High Throughput 

EFS[FileStorage][Sharable Stroage,mount multiple machines,sharable storages are always have high latency compared to Block Stroage]
- Sharable storage it works on NFS protocol can be mounted to multiple servers at a time
- It is a dynamic storage it can automatically expand
- Suitable to store images,videos and files
- For anywhere access go to EFS

`Static Provisioning`[manually creating the volume and pv]
Both instance and EBS volumes should be in same az

1. create volume
2. install ebs drivers on EKS cluster
3. Nodes have authroized to access EBS volumes
4. You can represent EBS volume inside k8s using pv[wrapper][pv acts a bridge b/w EBS volumes and k8s]
5. Pod can cliam volume through pVC

`TroubleShooting`
- check the EBS CSI drivers installed or not
  kubectl get pods -n kube-system

- Check the IAM role was attached to node or not

- Check the pv and pvc status
  kubectl get pv kubectl get pvc -n <ns>
  kubectl describe pv <pv-name>

`kube-system` this ns belongs to administration

kubectl get nodes --show-labels

`AccessModes` ReadWriteOnce ReadOnlyMany  ReadWriteMany ReadWriteOncePod

1. users send mail to staorege to create volume storage team create volume gives the volume ID
2. users send mail to k8 admin to create pv for them using this ID
3. users can cliam the pvc

I have volume in az-2 but my pod also should placed in az-2 now i want to advance schduling

`dynamic provisioning`[when require volume it will create volume and pv]

- needs storage class to achieve dynamic volume provisioning
- admins create sc for every project as best project

`ReclaimPolicy` Life cycle of volume
`Delete` associate pv and external volume also deleted
`Retain` pvc deleted remainning like pv and external volume still there
`Recycle` data should erased ready for claim

# 3-7-24
EFS volume   storing and provisiong

# 4-7-24
- statefulsets are used to maintain statefull applications like DB,Prometheus
- It will ensure pods have unique name[pods gets restart also identity will not same]
- When Scaling happend mysql-0,mysql-1,mysql-2............ orderly happens
- downscaling mysql-2,mysql-1...........
- Generally clusterIP LB it is good for stateless app but in case of stateful app LB is not good because if records stires in each avialable pod we get inconsistent result so we would go for Headless service it does not have any IP it directly used POD IP
- every pod have it's won storage so pv and pvc should created for every pod


100% we should not place customer related date into k8s

We just placed 2nd level data like monitoring,alerts

`HELM`
1. K8s package manager
2. templatize k8s manifest files

# 5-7-24
RBAC

K8s does not have auth it uses cloud provider but k8s have it own authorization

policy 
- descirbe cluster

role [permissions]
rolebinding [bind the role to the identity][R&RB are namespace level]

Cluster Role Cluster Role binding[Clusterlevel]

Linux and Netwroking is 90% of IT
apiGroups[all services are grouped into multiple apiServices]
reosurces[serivces]
verbs[actions]

aws iam eks aws-auth

kubectl get configmap aws-auth -n kube-system -o yaml

update aws-auth ConfigMap

- IAM user
- IAM policy to access EKS cluster
- Role
- RoleBinding
- Integrate IAM user with aws-auth

admin will  email project tema that ns and access is given

pod is overutilized or underutilized
HPA
VPA

# 10-07-2024
**ALB Ingress Controller SetUp**
1. OIDC attch to the cluster
2. Install policy
```bash
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.8.2/docs/install/iam_policy.json
```
3. create policy 
```bash
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam-policy.json
```
4. create service account
```bash
eksctl create iamserviceaccount \
--cluster=siva \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::806962169196:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--region ap-south-1 \
--approve
```
5. add helm repo to add ingress controller
```bash
helm repo add eks https://aws.github.io/eks-charts
```
6. helm install
```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=siva --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
```

7. Ingress Reosurces
```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: instan-ingress-resources
  annotations:
        alb.ingress.kubernetes.io/scheme: internet-facing
        alb.ingress.kubernetes.io/target-type: ip
        alb.ingress.kubernetes.io/tags: Environment=dev,Team=test
        alb.ingress.kubernetes.io/group: ullagallu
spec:
  ingressClassName: alb
  rules:
  - host: "instana.test.ullagallu.cloud"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: web-instana
            port:
              number: 80
```

ALB --> Listner --> Rules Evolutions --> TG

1. Labels and selectors are used for identifying and select the internal resources
2. Annotations are used to select external resources and we can also place the special characters unlike labels

**HELM**
1. templatize the manifest files
2. package manager


# Ingress[10-07-2024]

https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.8/deploy/installation/

https://github.com/kubernetes-sigs/aws-load-balancer-controller

**helm benefits**
- templatize the manifest files
- package manager[how we install any package in rhel os using dnf]

- labels and selectors are used to grouping identifying internal objects
- annatations are used to select external objects and no limits for key and value  and also pass some meta data
- used to create external resources

alb.ingress.kubernetes.io/group.name: ullagallu
kubernetes.io/ingress.class: alb

spec:
    ingressClassName: alb

# 11-07-2024

**init containers**
- run before main container
- it can be one or many
- init containers for completion
- sequentiallly executed
- if init containers are failed main containers are not running
- generally these are used for other containers ready ,to prepare some configuration for main container
- DB and backend both are started at a time backend is ready before DB started successfully backend is getting failed because no connection to DB
- we have init container for backend so before starting backend container starts init container should be checking DB is ready or not 

- How to prepare configure config for main container using init container
- How can i mount volume using init container to main container

*ephemeral volumes*
- are 2 types

**emptyDir**
- comes with pod goes with pod
- by default volumes consider as emptyDir in k8s

**hostPath**
- ephemeral volume where pod can access host machine files and dirs only one use case with hostPath that is accssing hostMachine logs that to readOnly mode this best practice

*probes*
These are one type of health checks apply on containers

**liveness probes**
- determines that containers is running successfully or not if the probe was failed it will restart the container
**readyness probes**
- wheather container is ready to accept traffic or not 
- it will check container port 8080 is opened means ready accept traffic


- I have backend deployment how can i pull the logs from backend container and push ElasticSesrch using fluentD
- FileBeat,FluentD,FluentBit which is best to collect the logs

# Difference B/w
FileBeat
FluentBit
FluentD
# Explain this
ElasticSearch
LogStash
Kibana


- Give me K8s manifest to deploy EL/FK
*DaemonSet*
- A pod run in the every node it will collect the logs of every nodes push to ElasticSearch 
- Automatically k8s ensure that Daemon set on each and every node if new node was added it add Daemon set o that node

### 15-July-2024

k8s is not prefer to store the RDBMS data prefere to store secondary level data like queues,cache and monitoring,logging

1. existing ALB attach to k8s cluster
2. ingress creating ALB

option first is feasible it is a part of infra no need to create give extra capability to cluster to provision ALB we can create listners, attach SSL certificates, create rules ,TGs

you can easily attach pods directly to ALB TG using tg binding resource

# Ingress
- provides external access to the services with in the cluster
- acts as a layer 7 LB allowing external traffic to be routed different services based on HTTP/HTTPS routes and rules
- used as a reverse proxy

LB:
--
used for high availability

ALB:
- having enough intelligent route the traffic based on path and host[decision making capability]
- using single ALB to route traffic to multiple websites
NLB:
- Any kind of data manaipulation not happend what ever traffic was received forwards the traffic as it is to the backend


# Ingress Controller	
- The function of ingress controller
  - evaluates all the rules
  - manages redirections
  - Entrypoint to the cluster

- My k8s cluster have my app as well as k8s dash board Monitoring tools and Logging tools

- Inorder access myapp,k8s dash board, kibana and grafana dashbords 
- To get external access to access all the componets with single resource instead of launching LB for each service

# Ingress Resources
Having rules and respective service endpoint these rules are evaluated by IngressController


# Node Port
using for developing and testing purposes open port all worker nodes in the cluster that is you're exposing port to the outside world that is security breach

# Load Balancer
- without exposing Node Port to the outside just use LB to expose service


EKS cluster SG rules Defined in this videos

Through ingress only you have to access your service that is secure and scalable

one EKS cluster can host multiple hosts

aws-load-balancer-controller deploy installations

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml

https://github.com/zalando-incubator/kube-ingress-aws-controller/blob/master/deploy/kops.md
