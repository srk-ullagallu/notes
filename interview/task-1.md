General Questions: 
1- Introduce yourself. 
2- Describe a challenge you faced as a devops engineer and how you overcame it. 
3- Would you like to work individually or in a team. 
4 - Tell me about something where you got a chance to learn and implement from scratch. 
5- How would you be handling a situation where you are not getting any help from your team members. 
 
AWS Questions: 
1- Launch template vs launch configuration. 
2- How do you communicate with AWS services privately without exposing to internet. 
3- NAT g/w vs NAT instance v/s Egress only IGW v/s IGW 
4- Design a 3 tier infrastructure using the AWS services which should be secure and highly available. 
5- Statefull v/s stateless firewalls. 
6- Differentiate between NLB and ALB. 
7- You want to redirect traffic from x.company.in to company.in/x, how to achieve it. 
8- Your database initially performs well, but after certain month you face slowness. How to troubleshoot and fix the same. 
 
K8s: 
1- K8s architecture 
2- Deployment v/s stateful set v/s replica set 
3- What is config map 
4- Role of etcd in kubernetes. 
5- How rolling updates work in a deployment? 
 
Docker: 
1- ADD v/s COPY 
2- Entrypoint v/s CMD 
3- How to remove all unwanted or unused docker objects from system? 
4- Multistage docker build. 
5- Is docker file immutable 
 
Terraform: 
1- What does terraform init do ? 
2- How to auto approve the terraform changes? 
3- count v/s foreach 
4- How to import an existing resource to terraform? 
5- Data black in terraform. 
6- What are provisioners in terraform? 
7- Remote backend. 
 
Linux: 
1- How to check the list of installed packages? 
2- Command to check kernel version. 
3- How to create a new user and add it as sudo? 
4- Command to check if a process called "a" is running or not. If running how stop it. 
5- Command to list all files less than 5mb. 
6- Hard link v/s soft link. 
7- Commands to check disk space usage and free RAM. 
 
CI/CD: 
1- Git fetch v/s Git pull 
2- Sonarqube quality gate vs quality profile. 
3- What is sonar runner. 
4- Types of pipeline in Jenkins. 
5- Scripted vs Declarative pipeline. 
6- Should we prefer artifactory to store artifacts or should we store them in s3. 
7- How to upgrade plugins in Jenkins. 
8- Usermanagement in Jenkins. 
9- Concepts about Gitlab runners. 
10- How to upgrade Jenkins. 
 
Ansible: 
1- loops in Ansible. 
2- Ansible Roles. 
3- Is Ansible idempotent? 
4- Ansible script to install nginx. 
5- Conditionals in Ansible. 



 
You need to deploy a multi-container application with interdependent 
services that communicate with each other. How would you set up 
networking and communication between these containers in Docker?

To set up networking and communication between interdependent 
containers in Docker, I would follow these steps: 
1. Define a Docker network: Create a Docker network using the `docker 
network create` command. This network will allow containers to 
communicate with each other using DNS-based service discovery. 
2. Run the containers on the same network: When running the containers, 
assign them to the same Docker network using the `--network` option. 
This ensures that they can communicate with each other.
3. Assign unique container names: Provide unique names to each container 
using the `--name` option. This makes it easier to reference and 
communicate with specific containers. 
4. Utilize container DNS names: Docker automatically assigns DNS 
names to containers based on their names. Containers can communicate 
with each other using these DNS names as hostnames. 
5. Expose necessary ports: If a container needs to expose a port for 
communication with external services, use the `--publish` or `-p` option to 
map the container's port to a host port. 
6. Configure environment variables: Set environment variables in each 
container to specify connection details or configuration parameters 
required for inter-container communication. 
7. Test communication between containers: Validate the communication 
between containers by running tests or executing commands within the 
containers to ensure that they can access and communicate with the 
required services. 













I recently had the opportunity to interview with MNC Company as a DevOps Engineer with 3+ years of experience. Here are some of the questions I was asked:

1. Could you give an introduction yourself and your daily activities as a DevOps engineer?
2. In Terraform, I’ve created a database with sensitive information like a password, and I don't want it to appear in the output. How can I do that?
3. Which parameter do I need to pass in Terraform to avoid displaying sensitive information like a password in the output?
4. In a Dockerfile, which user performs what action, and how can I specify the user?
5. What are the different networking types in Docker?
6. What is the difference between a bridge network and an overlay network in Docker?
7. How does a user access an application deployed in a Kubernetes cluster? What is the process?
8. Let’s say there’s an application deployed in AWS, and we want it to be highly available. How can we achieve high availability?
9. In Terraform, there is a database password in my configuration. How can I ensure that the password does not appear in the output? Which parameter should I use?
10. What is the difference between SLO (Service Level Objective) and SLA (Service Level Agreement)?
11. What is the difference between PV (Persistent Volume) and PVC (Persistent Volume Claim)?
12. Explain the Kubernetes architecture used in your project.
13. Are you using stateful or stateless applications in your project?
14. What is a StatefulSet in Kubernetes?
15. Scenario-based questions related to PVC (Persistent Volume Claim) and PV (Persistent Volume).
16. How is a Persistent Volume (PV) created in Kubernetes?
17. What is a Persistent Volume (PV)?
18. What is the difference between a Persistent Volume (PV) and a Persistent Volume Claim (PVC)?
19. How do you map ports in a Dockerfile?
20. If there is one port 80 and another port 8000, how do you map them in Docker?
21. What are the different services in Kubernetes, and which services have you worked on?
22. Which ingress controller are you using in your project?
23. What is the difference between a rollback, a canary deployment, and a blue-green deployment in Kubernetes?
24. Scenario-based questions related to deployments in Kubernetes.
25. Let’s take a scenario: I am creating an EC2 instance and attaching it to a VPC. How can I ensure the VPC is created first and then the EC2 instance?
26. How do you ensure that a VPC is created before an EC2 instance in AWS using Terraform?
27. What is Ansible, and why do we use it?

𝐑𝐞𝐩𝐨𝐬𝐭 𝐡𝐞𝐥𝐩𝐬 ♻️


SSL Certificate management is really important for a Devops Engineer. Let's break down some key terms.


Certificate Authority (CA): A trusted entity that issues and validates TLS certificates.

TLS Certificate: A digital credential that verifies the identity of a server or client, ensuring encrypted and authenticated communication.

Private Key: A secret key tied to a specific certificate, used by a server or client to prove its identity.

Public Key: The non-secret part of a certificate’s key pair. It can be shared openly and is used by others to verify signatures and encrypt data for the entity holding the corresponding private key.

Secret Object: Kubernetes resource used to store TLS certificates and keys securely, often referenced by Ingress controllers and workloads.

cert-manager: A popular Kubernetes add-on that automates the creation, renewal, and management of TLS certificates.

1. What scripting languages are you familiar with?

2. What are artifacts in GitLab CI?

3. What is a private module registry in Terraform?

4. If you delete the local Terraform state file and it's not stored in S3 or DynamoDB, how can you recover it?

5. How do you import resources into Terraform?

6. What is a dynamic block in Terraform?

7. How can you create EC2 instances in two different AWS accounts simultaneously using Terraform?

8. How do you handle an error stating that the resource already exists when creating resources with Terraform?

9. How does Terraform refresh work?

10. How would you upgrade Terraform plugins?

11. What are the different types of Kubernetes volumes?

12. If a pod is in a crash loop, what might be the reasons, and how can you recover it?

13. What is the difference between StatefulSet and DaemonSet?

14. What is a sidecar container in Kubernetes, and what are its use cases?

15. If pods fail to start during a rolling update, what strategy would you use to identify the issue and rollback?

16. How can we enable communication between 500 AWS accounts internally?

17. How to configure a solution where a Lambda function triggers on an S3 upload and updates DynamoDB?

18. What is the standard port for RDP?

19. How do you configure a Windows EC2 
instance to join an Active Directory domain?

20. How can you copy files from a Linux server to an S3 bucket?

21. What permissions do you need to grant for that S3 bucket?

22. What are the different types of VPC endpoints and when do you use them?

23. How to resolve an image pullback error when using an Alpine image pushed to ECR in a pipeline?

24. What is the maximum size of an S3 object?

25. What encryption options do we have in S3?

26. Can you explain IAM user, IAM role, and IAM group in AWS?

27. What is the difference between an IAM role and an IAM policy document?

28. What are inline policies and managed policies?

29. How can we add a load balancer to Route 53?

30. What are A records and CNAME records?

31. What is the use of a target group in a load balancer?

32. If a target group is unhealthy, what might be the reasons?

33. Can you share your screen and write a Jenkins pipeline?

34. How do you write parallel jobs in a Jenkins pipeline?


Brilliant Security Feature Of K8s 1.30

Have you explored "User Namespaces", this feature allows a process to have full privileges for actions within the user namespace but is restricted for actions outside of it.

In simple words, this allows running a process as a non-root user on the host, even if it runs as root within the container.

Here is how it enhances security in several ways:

Limited Privileges: The process has full privileges only within the container's user namespace. Outside of this namespace, it operates with restricted privileges, reducing the risk of it performing harmful actions on the host system.

Damage Containment: If a container is compromised, the attacker gains root access only within the container. This limits the potential damage to the container itself and prevents the attacker from gaining root access to the host or other containers.

Isolation: By running processes with different user IDs, it ensures that even if one container is compromised, the attacker cannot easily affect other containers or the host system.

Compliance and Auditing: Running processes as non-root users can help meet security compliance requirements and make it easier to audit and monitor activities, as actions performed by non-root users are more easily tracked and controlled.

Overall, this approach significantly reduces the attack surface and enhances the overall security posture of the system. 

Adding `externalTrafficPolicy: Local` and `sessionAffinity: ClientIP` enhances performance by reducing latency and ensuring client sessions stick to the same pod.

https://github.com/RajPractiseRepo/terraform-eks-microservices-multibranch-cicd-project


1. Write a shell script to find and delete all files in a directory that are older than 30 days.
2. Create a script to monitor the disk usage of a server. If usage exceeds 80%, log the details to a file and send an alert email.
3. Write a script that renames all .txt files in a directory by appending the current date to the filename.
4.     Create a script that checks if a particular service (e.g., httpd or nginx) is running. If not, it should restart the service and log the action.
5.     Write a script to monitor CPU and memory usage every minute and log the details if CPU usage is above 90% or memory usage exceeds 75%.
6.     Write a script that performs a backup of a specified directory and compresses it with the current date in the filename. Schedule it to run daily using cron.
7.     Create a script to check the availability of a list of websites. For each site, if it's unreachable, log the URL and send an alert.
8. Write a Python script using boto3 to list all S3 buckets in an AWS account and their respective sizes.
9. Develop a script that starts and stops EC2 instances based on a schedule (e.g., start at 8 AM and stop at 8 PM).
10. Create a script that monitors a specified directory and automatically deletes any files larger than 100 MB.

1.     How do you define and measure SLIs, SLOs, and SLAs in your organization?
2.     Tell me a scenario where you had to resize EBS storage without downtime.
3.     How do you configure cross-region VPC Peering? What challenges might arise?
4.     What is the difference between Security Groups and Network ACLs? Provide a use-case for each.
5.     How do you handle updates to a production environment using CloudFormation without downtime?
6.     What are the differences between AWS CloudFront and a traditional reverse proxy server?
7.     How would you implement blue-green deployments or canary releases in a CI/CD pipeline?
8.     If your build process frequently fails due to flaky tests, how would you address this?
9.     What are the differences between Deployments, StatefulSets, and DaemonSets, and how would you choose one over another?
10.  Describe how you would debug a CrashLoopBackOff state in a Kubernetes pod.
11.  How do you implement a readiness probe and a liveness probe? Why are both important?
12.  How would you implement node affinity to ensure pods are scheduled on specific nodes?
13.  What are the benefits of using a multi-stage Docker build? Provide a real-world example.
14.  How do you configure a Docker container to ensure it adheres to the principle of least privilege?
15.  Explain how you would debug a Docker container that keeps restarting.
16.  How do you decide between using an Application Load Balancer (ALB), Network Load Balancer (NLB), and Gateway Load Balancer (GWLB) for a particular application?
17.  How do you permanently open a specific port on a Linux machine?
18.  Explain the use case for htop vs top in Linux.
19.  How do you manage rollbacks in CloudFormation during stack updates?



💥 New project update 💥 - Shell scripting 👩‍💻 

Hey guys! So after learning shell scripting from various sources including Avinash Reddy Thipparthi & Abhishek Veeramalla, I tried writing a script all of my own!
Its a simple yet powerful script that will help you *Modify the file permissions* of n number of files all at once! 

Perks of this project :
 - Can modify permissions for multiple files at a time.
 - We can also include files that are present in other directories.
 - useful for those who want to give multiple files access to new people in the organizations.

Struggles I faced & Improvements I did while writing this script :
- The first idea of writing a script was automating the file permission-modification of a single file! But after running the script, I realized it was time consuming than doing it manually 🙆‍♀️ . So I want to make it for multiple files! 
(I used some Read & array functions for accepting multiple inputs from the user at once 💁‍♀️ )
- And the next thing I struggled with is, processing the files again & again without asking the users to input the data once more! (looping statements helped me with this 🖖 )
- And also added some trouble shooting functions in the script in case if some files doesn't exist, it will notify us and will also show us the updated file permissions of our given files 😊 .

you can see the Screenshots and the recordings of the output below 👇 
open for suggestions & feedback from you guys! And have a nice day all.. More way to go :)

1. How do you uncommit the changes that have already been pushed to GitHub? 
2. If there is suddenly the file is deleted in git how do you get it back? 
3. Can you increase the size of the root volume without shutting down the instance?
4. If you lost the .pem file then how will you connect to EC2? 
5. S3 bucket having a policy for only read-only but you’re having full access for you? Can you modify s3 objects? 
6. Difference between Classic ELB and Application ELB?
7. How many subnets are assigned to the routing table? 
8. In your VPC all IPS are finished you require resources how to provision it? 
9. Are you only using cloud watch for monitoring?
10.If your using load balancing in 2 availability zones den which load balancer you should use?
11. can you write docker file where Linux env condition deploy static webserver 
12. Is it possible to run any VM in AWS without creating any EC2 instance ? 
13. I want to create a pipeline in Jenkins which needs to have 10 different stages and based on my input it needs to execute some stages not every stages how you will configure that .
14. What are the Terraform modules? Have used any modules in the project?
15. Is it possible to configure communication between 2 servers those are having private access
16. What happens when you delete /var/lib/docker/overlay?
17. Write a simple script that calls with “Foo” prints “bar” and when called with “bar” prints “foo”. Every other option should print “Try 
again”?
18. Tell all the scenarios too implement the security in Kubernetes.
19. Your EKS application is experiencing higher than expected traffic. How would you automatically scale the Pods?
20. Your team needs to be alerted when the CPU usage of any Pod in your EKS cluster exceeds 80% for more than 5 minutes. How would you set this up?
21. Your team wants a Grafana dashboard to visualize the HTTP request latency of your applications running in EKS. How would you achieve this?




Reach out Templates,

To the Hiring Manager

Hi (First Name), 
I saw your profile while looking up (Industry Name) recruiters on LinkedIn in (Name of Place). 
I am a (Insert Job Title), (Add relevant information about your experience).
My main skills encompass (add skills). 
Does that fit the type of roles you generally recruit for? 
I would love to work for (add company name) as their vision and mission are in line with mine. 
Let me know what you think, I’d love to talk. 
Best, 
(Your Name)


The Job Seeker 

Greetings, (First Name)
My name is (Name), and I am a (Insert Role). 
I have been following your organization's work for a while now. (Add notable achievements of company)
I am very interested in working at (Insert something unique to the company). 
(Insert some information about your experience)
If you have a second, I would love to discuss how my experience and skills can benefit your organization for the position of (Insert name of role). 
(If there is no job posting, and you want to inquire about an opening then add the line mentioned below.)
I know you must be flooded with messages; but if there are any job openings for (Insert Role), I would be more than delighted to share why I might be a good fit. 
Thank you and have an amazing day!
Best, 
(Your Name)

Next up I will be sharing the Email and LinkedIn InMail templates.



📊 𝗥𝗲𝗮𝗹-𝘁𝗶𝗺𝗲 𝗟𝗶𝗻𝘂𝘅 𝗧𝗿𝗼𝘂𝗯𝗹𝗲𝘀𝗵𝗼𝗼𝘁𝗶𝗻𝗴: 𝗧𝗼𝗽 𝗜𝗻𝘁𝗲𝗿𝘃𝗶𝗲𝘄 𝗤𝘂𝗲𝘀𝘁𝗶𝗼𝗻𝘀 & 𝗔𝗻𝘀𝘄𝗲𝗿𝘀 🐧

Ready to ace your Linux admin interview? Here are some key questions and answers to help you shine! 💪

1️⃣ Q: 𝗖𝗿𝗼𝗻 𝗷𝗼𝗯𝘀 𝗻𝗼𝘁 𝗿𝘂𝗻𝗻𝗶𝗻𝗴? 𝗛𝗼𝘄 𝘁𝗼 𝘁𝗿𝗼𝘂𝗯𝗹𝗲𝘀𝗵𝗼𝗼𝘁? 🕰️
A: 
• Check cron service: `systemctl status cron`
• Verify job syntax: `crontab -l -u username`
• Check logs: `/var/log/syslog` or `/var/log/cron`


2️⃣ Q: 𝗛𝗼𝘄 𝘁𝗼 𝗺𝗼𝗻𝗶𝘁𝗼𝗿 𝗖𝗣𝗨 𝗮𝗻𝗱 𝗺𝗲𝗺𝗼𝗿𝘆 𝗶𝗻 𝗿𝗲𝗮𝗹-𝘁𝗶𝗺𝗲? 💻
A: 
• Use `top` or `htop` (if installed) for a user-friendly view


3️⃣ Q: 𝗙𝗼𝗿𝗴𝗼𝘁 𝗿𝗼𝗼𝘁 𝗽𝗮𝘀𝘀𝘄𝗼𝗿𝗱? 𝗛𝗼𝘄 𝘁𝗼 𝗿𝗲𝘀𝗲𝘁? 🔐
A: 
• Boot to single-user mode
• Remount root filesystem: `mount -o remount,rw /`
• Change password: `passwd && reboot`


4️⃣ Q: 𝗛𝗼𝘄 𝘁𝗼 𝗲𝘅𝘁𝗲𝗻𝗱 𝗮 𝗹𝗼𝗴𝗶𝗰𝗮𝗹 𝘃𝗼𝗹𝘂𝗺𝗲 𝗮𝗻𝗱 𝗿𝗲𝘀𝗶𝘇𝗲 𝗳𝗶𝗹𝗲𝘀𝘆𝘀𝘁𝗲𝗺? 💾
A:
• Check space: `vgdisplay`
• Extend LV: `lvextend -L +10G /dev/mapper/vg_name-lv_name`
• Resize filesystem: `resize2fs /dev/mapper/vg_name-lv_name`


5️⃣ Q: 𝗦𝘆𝘀𝘁𝗲𝗺 𝘄𝗼𝗻'𝘁 𝗯𝗼𝗼𝘁 𝗱𝘂𝗲 𝘁𝗼 𝗺𝗶𝘀𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗲𝗱/𝗲𝘁𝗰/𝗳𝘀𝘁𝗮𝗯. 𝗛𝗼𝘄 𝘁𝗼 𝗳𝗶𝘅? 🆘
A:
• Boot to rescue mode
• Edit fstab: `nano /etc/fstab`
• Remount root: `mount -o remount,rw /`
• Reboot


6️⃣ Q: 𝗛𝗼𝘄 𝘁𝗼 𝘁𝗿𝗼𝘂𝗯𝗹𝗲𝘀𝗵𝗼𝗼𝘁 𝗮 𝘀𝗹𝗼𝘄 𝘀𝗲𝗿𝘃𝗲𝗿? 🐌
A:
• Check CPU: `top` or `htop`
• Check memory: `free -m`
• Investigate high-usage processes


7️⃣ Q: 𝗦𝘆𝘀𝘁𝗲𝗺 𝗿𝘂𝗻𝗻𝗶𝗻𝗴 𝗼𝘂𝘁 𝗼𝗳 𝗱𝗶𝘀𝗸 𝘀𝗽𝗮𝗰𝗲. 𝗪𝗵𝗮𝘁 𝘁𝗼 𝗱𝗼? 💽
A:
• Check partitions: `df -h`
• Find large files: `du -ah / | sort -rh | head -n 20`


8️⃣ Q: 𝗛𝗼𝘄 𝘁𝗼 𝘀𝗲𝘁 𝗳𝗶𝗹𝗲 𝗽𝗲𝗿𝗺𝗶𝘀𝘀𝗶𝗼𝗻𝘀 𝗿𝗲𝗰𝘂𝗿𝘀𝗶𝘃𝗲𝗹𝘆? 🔒
A:
• Change permissions: `chmod -R 755 /path/to/directory`
• Change ownership: `chown -R user:group /path/to/directory`






General Questions: 
1- Introduce yourself. 
2- Describe a challenge you faced as a devops engineer and how you overcame it. 
3- Would you like to work individually or in a team. 
4 - Tell me about something where you got a chance to learn and implement from scratch. 
5- How would you be handling a situation where you are not getting any help from your team members. 
 
AWS Questions: 
1- Launch template vs launch configuration. 
2- How do you communicate with AWS services privately without exposing to internet. 
3- NAT g/w vs NAT instance v/s Egress only IGW v/s IGW 
4- Design a 3 tier infrastructure using the AWS services which should be secure and highly available. 
5- Statefull v/s stateless firewalls. 
6- Differentiate between NLB and ALB. 
7- You want to redirect traffic from x.company.in to company.in/x, how to achieve it. 
8- Your database initially performs well, but after certain month you face slowness. How to troubleshoot and fix the same. 
 
K8s: 
1- K8s architecture 
2- Deployment v/s stateful set v/s replica set 
3- What is config map 
4- Role of etcd in kubernetes. 
5- How rolling updates work in a deployment? 
 
Docker: 
1- ADD v/s COPY 
2- Entrypoint v/s CMD 
3- How to remove all unwanted or unused docker objects from system? 
4- Multistage docker build. 
5- Is docker file immutable 
 
Terraform: 
1- What does terraform init do ? 
2- How to auto approve the terraform changes? 
3- count v/s foreach 