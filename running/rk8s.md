# 2-8-24[Docker]
- In vm's autoscaling happens very very slow end users get a some sort of failures
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
  - Scaling issues[compared to better lot better than physical machines]


- Containrization is another type of virtualzation it is s/w level vurtualization
  - containers does not have dedicated os it uses host OS has readonly copy to run the containers
  - each container has bare minimum OS
  - Becuase size of containers weight scaling and booy up happens on the fly
  - Effective resource utilization
  - Containers has used shared resources of host machines[migration becomes very easy]
  - But security point of vm's gives strong securty than containers because of virtualzation
  - containers are immutable [we build from scratch]

- This evolution form physical--->vm--->container is for maintainning stateless app
- This phenomemon not for stateful app like DB applications

- Loosing backend is not a matter for us but loosing db it is matter for us

- Docker is a containerization tool used to create s/w bundle it has everything to run the app for example app code,dependencies and bare minimum os and libs


**Mutability & Immutability**
***Disadvantages with Mutability***
- I can apply config on one vmand another vm forget that's endup with troubleshooting .........
***Advantages with Immutability***
- consistency



Actually docker uses containerd for containers management they build eco-system on top of containerd

docker bin ---> docker service ---> containerd

earlier k8s user docker as CRI for k8s like

k8s ---> docker bin ---> docker service ---> containerd

Later they remove docker as runtime they, docker is not reuired to run containers containerd is enough why do we need to maintain complete docker ecosystem that's why they remove docker from k8s eco- system

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

- I did run some thing one machine same thing did on another machine try to do automation while running automation Iwent break something 

- containers are ephemeral[We|can't|expect|how|much|time|they|live]

# 6-8-2024

