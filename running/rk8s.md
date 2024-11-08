# 2-8-24[Docker]
- In vm's autoscaling happens very very slow end users get a some sort of failures while accessing the app
- Rather than running app in server go for containrization scaling happend much faster
- In container all the things packed and just run the packge 

- Containers are light weight and super fast in bootup and scaling

Purely talks about application perspective

- If you host app on physical machine, physical machine down entire app goes down app availability has main problem
  - In physical machines
    - No Scalability
    - No resource boundary b/w app may be one app resource consumption may cause another app performance down or some times app
    goes down

- That's why Industry comes with vurtualization concept able to create multiple virtual isolated machines on physical machines
  - Having strong resource isolation b/w machines
  - Effective resources utilization
  - Each and every machine has it's own OS
  - VM's are H/W level virtualiztion
  - Each vm has it's own Computing capacity[migration some what difficult]
  - vms are mutable[i login into vm and made the changes]

  - It solves the problems of hosting app on physical machines but problem with vm's are it's size of the machine becaue each and every machine has dedicated OS

  - It causes app startup takes time
  - Scaling issues[lot better than physical machines]


- Containrization is another type of virtualzation it is s/w level vurtualization
  - containers does not have dedicated os it uses host OS has readonly copy to run the containers
  - each container has bare minimum OS
  - Becuase size of containers weight scaling and boot up happens on the fly
  - Effective resource utilization
  - Containers has used shared resources of host machines[migration becomes very easy]
  - But security point of vm's gives strong security than containers because of virtualzation
  - containers are immutable [we build from scratch]

- This evolution form physical--->vm--->container is for maintainning stateless app
- This phenomemon not for stateful app like DB applications

- Loosing backend is not a matter for us but loosing db it is matter for us

- Docker is a containerization tool used to create s/w bundle it has everything to run the app for example app code,dependencies and bare minimum os and libs


**Mutability & Immutability**
***Disadvantages with Mutability***
- I can apply config on one vm and another vm forget that's endup with troubleshooting .........
***Advantages with Immutability***
- consistency



Actually docker uses containerd for containers management they build eco-system on top of containerd

docker bin ---> docker service ---> containerd

earlier k8s user docker as CRI for k8s like

k8s ---> docker bin ---> docker service ---> containerd

Later they remove docker as runtime they, docker is not required to run containers containerd is enough why do we need to maintain complete docker ecosystem that's why they remove docker from k8s eco- system

container is a just a process core feature of linux they just done the isolation

If there is a 2 process in the os how can you ensure one process will not read another process info so memory isolaion comes into the picture along with some more isolation comes into the picture PID,N/W,MNT isolation .........

Docker uses just linux features

Everything is linux

again one risk is there one container is faulty container which is trying to consume my all resources other containers will suffer the point of sharing resources is not a soluble solution in enterprise world 

# 5-8-24

Linux Features are like
Namespaces = 
Cgroups = 
- mnt isolation[your|container|having|own|fs|like|a|mini|os]
- PID isolation
- N/W isolation
- UTS[isolates|hostname|DNS|settings]
chroot jail


To Runs S/W need
- OS
- Installaing app
- Run the s/w

challenge is lift and shift[move the s/w is from one machine to another machine] is a problem lift in one os and shifting is in another os is another problem this problem easily comes in development world

Things are developed in windows goes well but running on linux things are different

How can tackle is we do a package and package take care of it

package it simple run anywhere you want

which is my bad

- I did run some thing one machine same thing did on another machine try to do automation while running automation I went break something 

- containers are ephemeral[We|can't|expect|how|much|time|they|live]

# 6-8-2024

container security
image security
containers are meant for stateless app
shared files systems are slow[There|is|no|success|rate|of|fs]
Why do we need fs
life cycle of container

# 7-8-2024

docker history <image>

container is nothing but running a process in the os it is no difference by the way

docker run = docker create + docker init + docker start

docker inpsect gives the low level info of the container

can you please explain docker build context how it is happend


The challenges with container mainly is networking and storage

In contaienrs one containers running on one node another on anther nodes sharing storage b/w containers is very costly 
When it comes to the k8s k8s has it own wrapper around containers the storage mounting is ease[one|container|is|writing|another|reading]
Shared storage is not succeede in the market

That is main essense of understanding

What makes k8s makes better than docker swarm
k8s intriduces a POD

# 8-8-2024

In pod N/W and Storage are sharable where as in containers are different

Discovery is quite challenge in container world but pod makes very easy the 2 containers communicate each other via localhost
but in containers you're depends on external n/w latency higher

[kubectl|helm|terraform|ansible|jenkins|k9s] ---> all are client [Kube|API|Server]

pod is a smallest deployable unit


ReplicaSet[Maintains|stable|set|of|relicas|at|any|time]

How ReplicaSet Konws this pod belongs to particular replicas by using pod has labels and replicaset has labels

**Execrsie**
- create a rs with 3 pods
- create pod with same labels that rs pod have
- observe the behavious of that pod


always maintain unique labels

kubectl api-resources

# 9-8-2024

pod is a virtual wrapper around the containers

end of the actually a container

If container dies ip address change 

container in pod dies ip addr will not change 

Every pod gets unique ip address

How this ip address was managed in k8s

crashloopback = container is dead or failed and the same container restarted again and again

Every Pod has one pause-container pod is self is a container that is pause container

pause container is a first created to host the container

it is going to reserve the n/w ns and all the containers created next to the pause container it is going to attach all the containers attached to the particualr n/w ns

pod always reserves always one IP because of pause container eventhough container goes down in the pod

`Different Phases of Pod life Cycle`

- Pending[unable|to|find|resources][schduler does not pod requirements]
- Running[all|resources|workig]
- Succeeded[all|containers|are|terminated|successfully|and|will|not|restarted]
- Failed[one|of|the|container|existed|wiht|non-zero]
- Unkonwn[some|of|the|reason|pod|state|is|updated]

The backbone of k8s is API server in k8s we have lot of API's

Normal API it will understand your request based on that it will redirect appropriate place it does proxy

kubectl api-versons

**Architecure of K8s**

API Server understand incoming request it is going to forward appropriate targets
It acts as a reverse proxy here


`apiserver` takes your request 

- Authentication checks the identity 
- Authrizates
- Validates the request
- single entry for your request
- updates the request config into etcd
- API server Asks give me right node for this pod requirement
`Schduler`


- The purpose Scheduler is `pod` placement
- Takes request from API server
- Get the Node stastics from API server
- Runs the algorithm[filtering|scoring|onnodes] based on the constraints finds best fit node
- Handovers the rsponse back to the `APIServer`
- `APIServer` updates the schdules config in etcd

`etcd`
- It is a key-value database it stores the complete cluster configuration
- HA
- We need to troubleshoot pods so we need info this was provided by ETCD

client  asking pod decribe --request---> API Server --get the decribe status of the pod-> etcd --etcd handovers info of the pod to the ---> API server ----> client



`control manager`

`cloud control manager`
controller for creating LB,instances,security group,volumes,r53 records

`kubelet`

- kubelet is a agent it takes instructions from the `APIServer`
- According to the instructions it create and update the pod status back to the `APIServer`
- It is a deamon service

`kube-proxy`


ReplicaSet is a configuration

ReplicationController configuration is maintained by

all the pods goaway so however 

just remove the controller not the pods just use `kubectl delete <rs> --cascade=orphan`

Labels and selectors are used to map 2 different Objects the k8s

isolating pods from rs just remove labels of pods

pod deletion cost when down scaling happen which pods get ridoff[youngest pods should deleted]
using annotation we some metadata to the pod which will help us to do some extra ops like pod deletion cost

some of the values are mutable[can|be|changed] and immutable[cannot|changed]

`Annotations` are used to pass supplement info a pod which is not effect execution of a pod

Through annotations we attach metadata 

RS for `ensure desired nof pods`
Deployment `Rotation of images chnages`

`PodDeletionCost` using this annotation which pod get's deleted when downscaling was happend

`[[[container]pod]rs]deployment`
- pod is a wrapper around the containers
- replica set is a wrapper around the pods
- Deployment is a wrapper around rs

- k8s is mainly for stateless app if you really want to deal with stateful application we have statefulset

- Difference b/w `shared fs` and `distributed fs`
- Jobs used to run pods some sort of time not like 24/7 if the work is completed it will goes off

# 10-8-24

services

`clusterip` `nodeport` `loadbalancer` `external name` `headless`

k8s CNI[calico|cilium|vpc|weavenet|flannel]

Externalname is a cname records

- How can i look into CNI range of IP ranges

- IP tables are OS level firewall

`CORE DNS`

# 12-8-2024[statefulset]

build docker image that prints hostname

echo "Hello from $(hostname)" > /usr/share/nginx/html/index.html

--image=docker.io/rkalluru/debug
docker.io/rkalluru/nginx:hostname-print

`configuration management` How can you manage configuration in k8s

Passing configuration through env variable a pain to pass 10 values or more

`configmap` decouple the configuration from pod statement pass once central place is configmap
- config is used to mount complete file as a volume

`secrets` in k8s no use it is a base64 encoding easy decode the secrets
To deal with secrets using HV

Yes, in Kubernetes, when you update a ConfigMap or Secret, the changes do not automatically propagate to the running pods. To apply the changes, you need to restart the pods that depend on the updated ConfigMap or Secret. 

Here are a few ways to restart the pods:

1. **Delete the Pods**: Kubernetes will automatically recreate the pods, pulling in the latest ConfigMap or Secret changes.
   ```bash
   kubectl delete pod <pod-name>
   ```
   Or to restart all pods in a deployment:
   ```bash
   kubectl rollout restart deployment <deployment-name>
   ```

2. **Change Deployment Spec**: Editing the deployment by updating an annotation (e.g., add a timestamp) will trigger a rolling update, causing pods to restart with the updated configuration.

3. **Use `kubectl rollout restart`**: This command will restart all pods in a deployment.
   ```bash
   kubectl rollout restart deployment <deployment-name>
   ```

`Resource Management`[ResourceBoundary]

offere 3 things
- cpu
- memory
- hugepages

requests[guarantee] for resources 
limits[no|gurantee] for resources if resources are avialable it will consume other wise it won't[it is just a bonus]

1 vcpu = 1000 milli cores
0.1[fractional] 0r 100m are same

Resource Quotas easy to organize the efficiently resources by admin
Based on requirement admin allocate particular compute capacity to the ns

# 13-8-2024
56:42 OSI layer
namespace level quotas and limits

based on prority of pods can we apply resource quotas

`security` 

`RBAC` Wheather the particular have right access to do this job or not
K8s does not provide any authentication

`Role`[ns level]
`RoleBinding`
`ClusterRole`[cluster level]
`CLusterRoleBinding`

`SA`

`Cloud Trail` Monitoring each and everything happend in the aws account[everything tracked by here]

`Role` is `identity` in `amazon` same thing k8s `service account` is a `identity`

By defaut every ns comes with one default `service account`

Role binding | Cluster Role Binding in k8s attach Role|Cluster Role to identiy wheather it is a ServiceAccount | AWS IAM Users|Roles|Groups

In k8s Objects are catagorized into multiple API's


In k8s cluster every pod can talk to each other there is restriction however i want to start controlling that

based on lebels and ip addresses

There are 2 types of traffic
- ingresss[incoming]
- egress[outgoing]

OSI is a fundamental communication layers how to 2 different computers talk each other

The layers happends in `bits` is a `physical Layer`
`frames`  `data link Layer` some sort of identification through MAC address

It is happening in the `packet level`  `Network Layer`

`Segements` security groups TCP,UDP `Transport` end to end connection

Nginx is a layer 7 software which is understands the request /api /transaction or app.google.com drive.google.com

It understanding the request `Layer7` is a content aware it is not dealing with contnent non-aware proxy

Contenet non-aware is `Layer4`

ingrees:
 - from:
    - ipBlock:
    - namespaceSelector:
    - podSelector:
logicl OR ipBlock or namespaceSelector or podSelector[any one of the condition satisfy]

Network Policy with VPC CNI

# 14-8-24

GO do addons VPC CNI edit and add the network policy true

Now tou wanted to have method level control also `service mesh` comes in to picture istio one of the famous

`Observability` what is happening how many requests are coming and perforamce 

what is privileged container

security context for a pod or container

I'm not able to recall

# 19-8-24

pod security standards workshop by amazon

To analyze our k8s cluster good or bad we have multiple tools kubeaudit


`Redinness` is container ready to accept traffic or not
`Liveness` Wheather container running or not

let me give a try

# 20-8-24

HPA[adding pods][stateless]

VPA[increase the resources][stateful]


kubectl get hpa --watch


`KEDA`


# 21-8-24[advance|Scheduling]


Scheduler is responsible for find right node to run this pod

nodeSelector

affinity[liking|attaracting]
anti-affinity[disliking|repelling]


RequiredDuringSchedulingIngnoredDuringExecution[must|and|should]
PrefferredDuringSchedulingIngnoredDuringExecution[If|matching|node|was|not|found|still|want|scheduling]

I don't want run that pods on a particular node or i want run particular workloads on particular nodes
I want schedule but exclusively choose which pods to schedule



Taints
Tolerations

Higher Precedence

# 22-8-24[storage]
# 23-8-24
- cluster add ons
- roboshop deployment

# 26-8-24
- Helm

# 27-8-24

# 28-8-24
- vault

helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets

SecretStrore for every ns
CLusterSecretStore for all ns in the cluster

vault secret store external secret with token example

HashiCorp Vault

External Secret Operator provider HV

Example

# 29-8-24
app deployment 

anticipating traffic before any big deal

There is a performance envinroment checking all is good or not based on that we will going to the prod

Running Load[Simulate the traffic] ---> This will tell how much are needed ---> How much load ---> BT will give the context---> 50 active users all the time--->Run Load % Collect Resource usage ---> BenchMark those resources

# 30-8-24

If you want to know usage of resources than probably if i'm looking for TSDB by prometheus

The problem with metrics server show you at the moment of time metrics only no historical data metric points

load testing

docker.io/roboshop/rs-load

env:
  - name: HOST
    value: "http://frontned/*"
  - name: NUM_CLIENTS
    value: "10"
  - name: RUN_TIME
    value: "5m"
  - name: ERROR
    value: "0"
  - name: SILENT
    value: "0"

 learndevopsonline github above image was definition was avaialble

watch "kubectl top pods"

PT will conduct performance testing

# 22-10-24

`ISTIO` is dealing with communications
 
Having multiple components communication b/w these composnents massive so that where the challenge come into picture

N/W has a limitation that it can only deal with a tcp layer of communication 

these ip address will not communicate with other or vice-versa

so and so ns with so and labels we can deal with that

Granular connections b/w components only that component is required for ex: GET POST DELETE  

Why we allow unnecessary calls b/w components

Deal with methods kind of restrictions b/w components with in the k8s cluster

communication b/w components happend in plain communication happening actually dealing with http layer

it is good thing have security in the communication b/w components

It is not good thing going and modify the http to https in the code rather that service mesh comes in a handy

they will take care about offloading request from the server istio help us auto encryption/decrypt

# 23-10-24

- How we can enable encrypt svc-svc communication
- Istio uses envoy proxy means along with main container istio container was also placed earlier communication happend directly to the pod now for request was received by istio container it will decrypt pass the request to the app container it process the request handover back to the istio it will encrypt the response back 































# 8-8-2024[k8s]
Different orchestrators[k8s,swarm,ECS,OpenShift]

What makes k8s better than docker swarm i.e is k8s introduces POD

`Advantages of POd Over Container`
- Pod is a wrapper around the containers
- Pod is a logical group of containers meaning pod can have one or more containers inside that
- Dealing with N/W,storage is a advantage
- Inbuilt DNS server
- Each and every pod has its own IP


`Network In Container` The n/w b/w the containers goes over the outside nodes this becomes very difficult manage discovery is big  or quit challenge

`Network in Pod` The n/w is with in the pod it is not even using node n/w when it comes it is very easy to container can communicate each other via localhost in the container

Storage also same in case containers and pod also

k8s deal with storage,n/w,firewalls 
master nodes manages components in the cluster

Master Nodes[`Manages components in the cluster`]
Compute Nodes[`Host the workloads`]

`Minikube Setup`


APIServer[kubectl,k9s,k8sUI,Terraform,Ansible,Jenkins] we communicate with API server using these manay tools

kubectl cluster-info

cli approach creating the pods is not that much good it has lot much info pod cotainer or pod cli approach is not that much used we need to provide so much meta data it is better provide metadata through declarative format

octant for k8s UI


containers in the pod shares same ns that's the reason containers can communicate each other via localhost

`ReplicaSet` Maintain the stable set of replica pods running at any given time it guarantees availability of a specified number of identical pods 

kubectl get pods -l <key>:<value>

The ReplicaSet and Pod are different entity but we can make relation b/w these 2 by using labels and selecotrs

ReplicaSet manages the pods using selector labels

ReplicaSet always look for pods belongs to replica set

Always maintain unique labels

kubectl api-resources

We should read the documentation when there is a need

Task
----
- Create a Replicaset with 3 pods
- Create a naked pod with labels of Replicaset pods have
- Then observer what happend


# 9-8-2024

How pod was preserve IP address eventhough container in the pod restarts multiple time the reason for that the pod launches one `pause container` along with the containers in the pod

when you actually launch a pod the box of a pod itself is a container that is pause container 

when the pod is a created the pause container also created to host the container it is going to reserve the n/w namespace now all the containers launch next to the pause container it is going to attach the particular ns

`POD Life Cycle`

`Pending` Pod has not been bound to any node
`Running` Pod has been bound to node and all of the containers have been created atleast one container still running
`Succeeded` all containers in the pod terminated successfully and will not restarted
`Failed` all containers in the pod have terminated 
`Unknown` For some reason the state of POd is not updated

`API Server` The common objective of API server is understand incoming request based on the route appropriate products

v1 v2 means in k8s manifest definition which `api` going to hit

when you hit like this
kubectl apply -f pod.yaml

1. API server receives the request
2. Writes the config in to ECTD
3. API server pass the pod config to the schduler for pod placement
4. Schduler wants node info from the API server
5. API server fetch node info from the ETCD
6. API server handovers the node info to the Schduler
7. It runs algo for the pod placement before that it will also consider any constrains that pod have
8. Then Sceduler gives back to the API server about pod placement
9. API server updates the pod plament info in the ETCD
10. API server calls the kubelet respect node pass the pod info to the kubelet
11. kubelet instruct the container run time to create the container
12. Once the containers is created kubelet wrap that container as  POD
13. Now Kubelet handovers the this process resquest about pod creation status back to the API server
14. Now API server update the pod status in the ETCD
15. API server gives the response of pod creation to the client

Difference b/w Replication Controller and ReplicaSet

- Isolating the pods from replicaset by changing labels

Annotations are used to pass supplement info to the pods 

- Pod Deletion Cost When down scaling was happend which pods should remove 

`Deployment` Replicaset is to main desired nof identical pods at any time but replicaset is not for deploying new pods for example if you nginx:1.20 now update to nginx:1.24 replicaset does not do anything that's is the reason why deployment comes in to the picture

Deployment is super set of replicaset and rs is super set of pods

Deployment is a wrapper around rs and rs is a wrapper around pods

K8s is mainly for stateless applications in case if you want deal with db's we have stateful sets

Why don't we use shared file system

# 10-8-2024

`services`

`clusterIP`

`NodePort`

`LoadBalancer`

`External` are CNAME records

`Headless`

In statefulset How can i decide who is write the data who is read the data


`What is IP table` It is a os level firewall 
https://www.tecmint.com/linux-iptables-firewall-rules-examples-commands/

EKS uses VPC CNI

Difference b/w VPC CNI/Calico/Cilium

# 12-8-2024

TO check headless service design Nginx container that prints ip of the container

- first create deployment+service with clusterIP check the DNS of service does it gives ip of container or service
- second create statefuleset+headless service then do like above and observer it

kubectl logs -f -l app=nginx

configuration management How can manage env variables in k8s 

If you keep defining env vairables in pod definition it is a pain to maintain all the env that's why k8s comes with centralized managed configuration for pods that is configmap that thing is keeyp dry and clean in pod definition


secrets in k8s there is no use this is simple encode and decode so will go and user hashicorp vault to store secrets
To deal with the secrets we would use HV

some of the pods behaving abnormally due to the whatever reason

resources: must requires compute capacity to start pod
limits: Some times the pod requires more cpu but it won't access all capacity in the node some we draw some boundary for resources usage It is a bonus not guarantee of limits defined capacity,If capacity avialable use it if not there is no guaranteee

Requests[Mandatory]
Limits[NoGurantee]

behind the scene k8s monitors k8s resources it will adjust accordingly

history | grep docker | grep up


We can define Quotas for the namespace that ns will not exceed what we define for ns to know the resource

If based on priority of pod we can define Quotas if pod as high priority it will get it 

# 13-08-2024[seucrity]

How do you provide authorization in k8s

In k8s the identity provides by service account

In aws whatever we doing that will monitor by cloud trail

Role is identity in aws

ServiceAccount is identity in k8s

kubectl get pod debug -o yaml

Every ns has comes with default serviceaccount

`Task`
- create sa in siva ns
- create pod with sa in ns

`RBAC`[Authorization]



Role = NS level
CLusterRole = Cluster level
- Above 2 has permissions to access resources in cluster

RoleBinding
ClusterRoleBinding

- Binding means attach Role to the identity

`Task`
- create role to watch list,watch,create pods in siva ns
- create sa in siva ns
- binding role to sa
- deploy pod in siva
- check the logs pod

- create same pod in rama ns
- check the logs 

- Why do we need a permission to a pod within cluster
For example I need to install a software that will manage the pods for example there is a argoCD is a deployment tool which also get a pod state in the cluster it require a permission

In Cluster every pod can talk each other there is no restriction we don't have any limitation however how can i control or restirct the pod communication this where N/W policies comes in to the picture

- one ns talk to another ns
- pod to another pod

- How based on labels and IP traffic

There 2 types

- Incoming traffic
- Outgoing traffic

OSI layers are fundamental communication layers how the communication work b/w 2 devices in a n/w

segments Transport here sg are comes in to picture basically it understands protocols
packets Netwokt  happend over IP addresses

content aware is layer 7[content aware proxy]
content aware is layer 4[non content aware proxy]


1:00:55 

nginx is a layer 7 software which will understands the request is coming /api /images ...

# 14-08-2024

HTTP methods
ISTIO

container pod security

- run as a normal user
- SELinux[bring the relation b/w file and user][wheather particular process is able to access or not that was defined by selinux if the context is matches allow other wise block it]
- Running as priviliaged or unprivilaged pod
- Linux capabilities

This has some imporatant concept like privilaged container

- Docker has problem if you mount /var/lib/dcoker.sock it has privilages

enforce security context in k8s across context


# 19-8-2024

PSS[PodSecurityStandards] 
`Privileged` unrestricted or unsecure providing the widest possible level of permissions
`BaseLine` Minimally restricted 
`Restricted`

PSA[PodSecurityAdmission]
`enforce`
`audit`
`warn`

- Hello Chatgpt Can you design lab for me above

kubeaudit
kubesec
kubebench
kubescan
kubescore
kubehunter
kubiscan

these free tools to scan but in enterprise world we would use some pait tools like

Twistlock defender

Before going to prod we need to get signoff from security team

7 k8s security scanners to use in your devsecops pipeline

# 20-8-2024

`probes` like health checks to determine my application running or not

`HPA`

kubectl get hpa --watch

HPA Basic on CPU and Memory

KEDA[k8seventdrivingautoscaling] is best for scaling k8s

VPA

I want seek a clarity wheather a my pod can increases resources or not

VPA exercise please ChatGpt

need to install VPA[hackfolder]

# 21-8-2024[Scheduling]
This is the right for this pod

node selector
affinity/anti affinity
requiredduringschedulingingonreduringexecution[must statisfy]
preferedduringschedulingingonreduringexecution[may be no problem if not satisfy]

Taints
Tolerations

# 22-8-2024
EBS EKS IAM Role

# 23-8-2024





[10 DevOps Projects](https://www.youtube.com/watch?v=1tHFB5rDz-Y)

















