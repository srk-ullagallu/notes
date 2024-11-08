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

