## 7-6-2024
# Jenkins
- Java based web application
- Plugins gives the more power to the Jenkins[Plug-and-play]
CI=automate the build process right from code push to github artifact creation
CDelivary = manually releasing app
CDeployment = without manual intervention release the app

**Master/BuildAgent[node]**
- Master distribute the jobs to agents to do th job

- When work is there master calls agent to  do work

**agent**
- install java
- create user and password

**Master**
- add the agent configuration

### Types of Jobs
**FreeStyleJobs**
- create the jobs through console
- no vcs,no collaboration,no auditing
**Job**
**scripted**
- versioning the jobs
- enable the collaborations
- auditing the changes who made what


- pipeline with agent label
- pipeline with options
- disable concurrent builds
- parameters
- triggers
- environment
- When
- post,delete workspace once it was done
- input
- parallel builds
- upstream and downstream
- ansi color

# What is pipeline
# What are the benefits of creating infra with Jenkins pipelines

## 10-6-2024
In Recent versions jenkins comes with node monitoring
If we have nof executors we can that nof jobs at a time

- Maintain different jenkins for environment to avoid complexities
- can i trigger my pipeline using JIRA

SRE
---
- Installations
- RBAC
- Upgrade
- No downtime
- Monitor
- Backup

## 11-6-2024
nexus
- Infra should be ready to deploy application 
- 
for i in 01.vpc 02.sg ; do $i ; terraform apply -auto-approve ; cd .. ; done

- yum repos
- white labeled

hosted = our own repo nexus

## 12-6-2024
- sso for jenkins[authentication]
- RBAC for sso user

- We configured CI/CD pipeline end to end we allow developers to concentrate on application code development

- We create repo for project
- create infra for applications deployment
- create CI/CD pipelines


- Earlier my pipelines have any security checks it just normal pipelines
- We are slowly implemented or bring security into my pipelines
- The process is takes months for implement secuirty
- for example first we eneble sonarqube scanning
- after few months clear the defects if defects are not clear we failed the build

- As a devops engineer we discuss branching strategy with developers having proper PR process 
- On board new projects into different devops tools

for i in (ls -dr */);do cd ${i%};terraform destroy -auto-approve;cd ..;done

## 13-6-2024

## Before CI
**Build and release team**
- clone the code
- build the application
- upload artifact to nexus using nexs api
- 1 week after build team inform the have the issues developers work on that again they work on the issues
- this is a loop takes time no immediate feedback system
- engineers power wasted 

- same process repeated for QA,UAT and PROD
- Deployment window 12hrs 1 week monitoring other defects

- Jenkins server co-ordinates all the tools to required build and release
- Pipeline as sequence of stages to achieve auotmated build and release

- How can i measure pipeline capability

Coding standards = static source code analysis[scan the code give some recommendations you must apply the recommendationsto
pass the build]

SAST = Security Related things analysis will be given to developers they have to fix

DAST = Dynamic Security

Open Source Lib scan = upgrade the libs

Docker image scanning

Now deploy the code

unit testing[tedting functionality of any]
functional testing[Micro services application so developers]
integration testing[test the entire application][this will be perform by QA]
smoke testing,performance testing
all testings are not 100% automation some manual work is also there

coverage = unit testing

## 14-6-2024

shiftleft 
---------
Implement security beofre deployment 
1. unit testings
2. scans
- SAST[on code]
- Source code analysis
- Open source lib scan
- DAST[real time attack on the application][veracode]
- Image Scan
3. Deploy to Dev 
4. Functional Test [usually by developers because it is micorservice]







