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

Every pod gets unique ip address

How this ip address was managed in k8s

crashloopback = container is dead or failed and the same container restarted again and again

Every Pod has one pause-container pod is self is a container that id pause container

pause container is a first created to host the container

it is going to reserve the n/w ns and all the containers created next to the pause container it is going to attach all the containers attached to the particualr n/w ns


`Different Phases of Pod life Cycle`

- Pending[unable|to|find|resources]
- Running[all|resources|workig]
- Succeeded[all|containers|are|terminated|successfully|and|will|not|restarted]
- Failed[one|of|the|container|existed|wiht|non-zero]
- Unkonwn[some|of|the|reason|pod|state|is|updated]

**Architecure of K8s**

API Server understand incoming request it is going to forward appropriate targets
It acts as a reverse proxy here


`apiserver` takes your request 

- Authentication checks the identity 
- Authrizates
- Validates the request
- single entry for your request
- updates the request config into etcd

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

`control manager`

`cloud control manager`
controller for creating LB,instances,security group


`kubelet`
- kubelet is a agent it takes instructions from the `APIServer`
- According to the instructions it create and update the pod status back to the `APIServer`
- It is a deamon service

`kube-proxy`


ReplicaSet is a configuration
ReplicationController configuration is maintained by


Labels and selectors are used to map 2 different Objects the k8s

isolating pods from rs just remove labels of pods


some of the values are mutable[can|be|changed] and immutable[cannot|changed]

`Annotations` are used to pass supplement info a pod which is not effect execution of a pod

Through annotations we attach metadata 

`PodDeletionCost` using this annotation which pod get's deleted when downscaling was happend

`[[[container]pod]rs]deployment`
- pod is a wrapper around the containers
- replica set is a wrapper around the pods
- Deployment is a wrapper around rs

# 10-8-24

services

`clusterip` `nodeport` `loadbalancer` `external name` `headless`

k8s CNI[calico|cilium|vpc|weavenet|flannel]

Externalname is a cname records

# 12-8-2024

build docker image that prints hostname

echo "Hello from $(hostname)" > /usr/share/nginx/html/index.html

--image=docker.io/rkalluru/debug

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

`Resource Management`

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





