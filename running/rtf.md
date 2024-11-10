# 12-7-2024
standard operating procedure

time spend in ops is very very huge cast compared to development cast

automation tested in dev easy to replicate scalable infra across different envs 

- Time to prodution faster
- Less Configuration drift[unkonwn things will not give surprises]
- Reduce cost[Engineeringcost+businesscost]

alternative to terraform[pulumi,crossplane[k8snativeinfraprovision tool]]

`Ansible` exclusively for configuation management[do automation inside os]
`Terraform` exclusively for creating consistent infrastrautre[network,storage,compute,db...]

`Pulumi` cames with a concept like to write infrastructure code no need to learn any DSL you can able to write any programmin lang that already comfort this is main behind it ofcourse terraform comes same thought to counter pulumi.

# 15-7-2024

resource <aws_instance> <instance>{
    x = 10
    y = 20
}

x,y is called a argument
10,20 called a inputs
resource offers a data called attributes

ti --> will understand code we have written and download unecessary provider plugins and +2 more things do 
tp --> will tell the execution plan what it is  planning to do when you apply actually
ta --> create the resources which are mentioned in the code if the resources is already there then tf will not anything
td --> delete the resources which were been created so far by tf however tf will not look for code to delete it will delete reosurces created by tf

aws_instance is a resource label which is offered by provider
instance is a local resource label our wish

In organization we don't create any local users in IAM  centralized way to handle users is best thing add or remove users from one place 

AWS comes with key-pair bacoz of ec2-classic

keep the code dry use variables

interpolcation "Hello, ${var}"

variables
tfvars[high precedenc than variables]
-var=file-variables.tf[highprecedence than tfvars]

# 16-7-2024

count loops based on index identification of failure touch, and also change change the order of terraform what is the behaviour of that[it is destroying the things and re create it] count considerd as a least priority option
for_each loops based on key value pair identification of failure becomes very easy

# 18-7-2024
modules = grouping the resources,do the best practices and DRY

In terraform what is the best code structure for multiple env of remote state and remote modules

chicken egg problem

# 19-7-2024

Github Actions

In CMD we don't have any track who is running what so we going to pipieline

# 20-7-2024
configuring github runner

# 22-7-2024

for saas and paas you directly attach role for iaas use instance profile

In AWS some H/W is ideal

amazon offers unused h/w for lesser cost if they need then can taken back
