
# 20-9-24

automating process of build and test and deploy where developers frequently merge their code into central repo this process ensure early bug detection and improves the code quality and fastning the software releases


`CI` Automating the integration of code changes from multiple contributors into a single software project during development developers
merge their code changes frequently to central repo where build and tests are happend for each and every commit pipeline should run

`CI Benefits` faster releases with less defects

`Pipeline` 

Usually in organizations CI and CD pipelines are decoupled

We are not going to do atuo deployment into prod in organizations

In CI pipeline there is a start and end

But in CD pipeline there is not end 

Deploymenet in dev and wait and go the next env and wait go to the next environment why you're waiting you need to get signoff

We have different tools for CI[Jenkins] and CD[GithubActions]

He might push a buggy code also

Each and every developer goes with a short lived branches

[trunkbaseddevelopment.com]

Developers working story each and every stroy has Jira Ticket

We are using Github Enterprise version

each dot determines a commit

For every commit we run a pipeline

No one direclty pushes the code to main branch where as it always comes with a merge 

commit id is not a userfriendly to remember for this reason we may use tags for ease of remembering

So the pipeline that should support all the above scenarios
- Developer commits should be dtected
- Main commits should be detected
- Tags should be detected

After every detect the pipeline should run for its respective commit

In interviews says using bit bucket


"We use a multibranch pipeline in Jenkins because, during development, developers often create multiple branches. As a DevOps engineer, it's not feasible to create a separate Jenkins pipeline for each branch. With the multibranch pipeline, Jenkins automatically detects branches containing a `Jenkinsfile` and triggers the CI/CD pipeline for each detected branch, ensuring continuous integration and delivery."


declarative pipeline is easy to write it has syntax according to our requirement we can write pipelines though it is a easy and has lot of challenges so end of the we would go with scripted pipeline at a scale declarative pipeline not handling I faced scenario where declarative pipeline has a limitation so my strategy go into the scripted pipeline



Why Jenkins is not good for CD purpose:
- Since it does not have a flexibility to stop in b/w and wait for some actions like approvals for a long time phase to phase
- Since it is does not have any felxibility to stop in b/w phase to phase. Due to that it is always to limited to CI part itelf. However still people uses this but end of the visibility is very minimal

In CI there is no other tool that works just like Jenkins is a Super tool in CI part there is no competator Jenkins Offers many things in CI part no other tool will not offer 

CDelivary Deploy to prod[manaul]
CDeployment Deploy to prod[automated] it is a scary we need to get sign off from different env's and CR process is there

Declarative Pipeline is to write pipeline at a scale we cannot handle we end up with scripted pipeline

When face scenario like that declarative pipeline has limitation then we go for scripted pipeline

# 21-9-24

My Jenkins Server is slow how can you trouble shoot

Jenkins Setup with terraform and ansible

BLocks in Ansible

# 23-9-2024

Testing of the code in 2 ways

- Dev person doing testing
- QA person doing testing

- What are the test cases that developer will develop
- What are the test cases that QA person will develop

TDD practices test driven development

Performance test cases are run in PT env not CI Pipeline

End to End [ETE]

General Pipeline:

checkout -- compile -- test cases -- dcoker build -- docker push -- deploy to dev


                    compile                test cases       docker build       docker push           deploy to dev
main branch           yes                     no               no                no                    no

story branch          yes                     yes               no                no                    no  

tag                    no                      no               yes                yes                   yes



Declarative pipeline is good for single branch pipelines scenario if it is multi branch it won't be a good choice for example we have when condition if it is a main run but what about if it is not main how can i control other stages

jenkins shared lib

`-` are not allowed `_` only allowed in funtion names


sh 'env'

# 24-9-24

roboshop-devops-project-v3

compile the code was only reqired for java and golang programming languages require
nodejs and python scripting languages does not require

In declarative pipeline first step would be declarative code checkoutSCM but in scripted pipeline it would be git checkout

If we want to build brand new pipeline we will gether some info from developer
- what programming lang they use
- version of the programming lang
- What is the build tool they used
- Get the info unit test cases command and integration tests

# 25-9-24
roboshop
docker build
Dockerfile

# 26-9-24
roboshop
docker build
Dockerfile

# 27-9-24

# 30-9-24

ArgoCD

How I deal with the deployment

The nature of CI is start and end the jenkins good for this it is always start and goes towards end

Actual Deployment pIpeline is dev once dev signoff go to next QA once QA is signoff then only other env deployments it has wait for sign off from different env then proceed waiting for days or hours  until then should be on hold

Jenkins is not for that 
In jenkins we can hold the executor by entering sleep command but is not a literally stop recommend becuase background still executor executing sleep is not a ending of a process 

only deployment context is only used 

# 1-10-24

github actions
- creating github repos using terraform
- create preotection rules for environemnt wise in github
- Pipelines ask me for review to deploy QA,PRE-PROD,PROD in GithubActions
- How Can I trigger My Jenkins CI Pipeline to GithubActions CD pipeline

- deployment

# 2-10-24

- githuactions argocd deploymnt pipeline
- install ARGOCD cli in github runner
- dynamic name for github workflow
- github actions reusable workflows

- deployment


# 4-10-24
- deployment all applications

# 7-10-24

- Load Test
- new relic integration with app for block box metrics

# 8-10-24
- infrastructure secure or not
- scan the terraform code [trivy]
- /usr/local/bin/tfsec infra-dev-eks

# 10-10-24

- KMS = aws has h/w so host the machines in h/w there is a chance to read the data so aws offers kms to encrypt the data
- VPC flow logs


# 11-10-24
- KMS for cloudwatch logs
- EKS node group launch template [1:01:]

# 14-10-24
- Infrastructure
- EKS cluster
- OS
- Container

image scanners
- Amazon inspector
- Nessus vulnerability scanner
- twistlock defender

start insurence company data breach

CISO

# 15-10-2024
- aws_ami_from_instance
- packer
- inspector

# 17-10-2024
- k8s cluster security
- twistlock defender
- Guard Duty

- Falco
- securing pod 

- kubeaudit

# 18-10-24
- security readonly file system by pod

# 21-10-24
- if you include twist lock to scan the container in dev pipeline or any security pipeline
- k8s manifestfiles security using trivy

# 22-10-24

Istio - 57 

- method level restriction between micro services 
- communication b/w component to componet plan communication happend

# 23-10-24
- kiali
- CIRF install every linux have certificates

# 25-10-24
- istio authorization policy

# 28-10-24

# 30-10-24
- istio gateway

# 04-10-24
- sonarqube

# 05-10-24
- Byte Byte Go








1. SCM checkout
2. Unit test cases
3. SonarQube Analysis
4. Owasp dependecy Check
5. Docker build[applicationbuild]
6. Dcoker image Scanning
7. image push
