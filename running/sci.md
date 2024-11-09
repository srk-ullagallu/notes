reset = no history of mistake commit
revert = preserve history of commit and have the corrected history

Jenkins[CITool]
---------------
Jenkins is a simple java based web application

plug and play If you add plguins gets more functionality to the Jenkins

do the changes,review,test


Git is a single source of truth

If you Version control your configuration, made the changes that will be tracked,reviewed and test 

Branching

main points to the prod direct changes are not allowed through some review process

main ---> feature branch

do the changes in feature branch --> get reviews --> run some tests --> scan the code 

`freestylejobs` In Jenkins console we configure the jobs

trigger the job,pre build,build and post build

`disadvantages`
- any can login the changes,difficult to track the changes what went wrong
- difficult to restore no versions

`scripted way`
- review can be done before do something
- easy to restore
- track the changes
- maintains the hisotry

`plugins`

- pipeline stage view
- blue ocean plugin
- 

Jenkins Control Node
- Ditribute the work to the agent node
- Monitor the build process
- Publish the build results
- It is not a good practice to run jobs on master node

Agent Node
- Take the instructions from master node
- Run the Jobs

1. When work is there master calls agent and ask them to do work 
2. Daily agent comes to master and ask is there any work

15 mins to create build artifact

Any event happen in one system infrom to another system

# 10-7-24
input  

- pipeline utility steps

If organization is big prefere different jenkins for prod and lower env

SRE:
    Installation
    RBAC
    Upgrade
    No Downtime
    Monitor
    Backup

# 11-7-24
    
- ansi color

white lebled traffic only allowed

project infra
application infra
tools infra

It is not like on the fly to add or implement scanning into our pipelines it is like journey of months to implement in it

6months = you must enable the scan
6months = you need to clear defects if defects are not clearn fail the scan

discussion happend over scan

Jenkins co ordinate all the tools sequnentially run the stages
