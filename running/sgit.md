# 4th-June-2024
git = single source of truth[everything is automation]
- distributed versioning control system

**Branching**
- Enables isloation where we can work on the that once everything good merge to main branch through PR
merge happend trough review process

everyone should ceate their own branch made the changes raise pull request some review process happend once the review completed then merge the feature branch in to main branch

How can i see parent commints for another commit

- Merge or Rebase to strategies to incorporate one branch changes to another branch

**Merge**

- create branch
- made the changes
- raise the PR
- get the approvals
- then merge it

merge gives one extra commit i.e is merge commit it has 2 parents one is branch latest commit and another once is feature branch commit


**Rebase**
- create branch
- made the changes
- raise the PR
- get the approvals
- then rebase it

- no extra commit
- commit ids are changed
- no histroy preserved it is rewritten in main branch

- looks clean and linear history


single branch --> multiple persons working --> want to keep history --> if you don't know about anything --> prefer merge

**conflicts**
If collaborators working on same feature one collaborator made the changes and another collaborator made the chages they they are trying to merge it git throws i'm unable to decide which code to keep they git raise an conflict error then those 2 colloaborators sit togehter decide which to keep which not then raise PR then merge to target branch

If git finds different content in the same line collaborators sit together resolve the conflicts

if main branch move forward 
anothet branch is trying to merge it then conflict will come

conflict always resolve locally

- change the base after rebase new commit have only one parent

# 5th-June-2024

**Branching Strategy**
How manage your from dev to prod

- No application down 
- Faster releases
- No security breaches
- No maintainence failures 

because of devops and cloud

**GitFlow**

Development branch
source: main
destination: nothing

feature branch
source: development
destination: development


feature merging happend throuhg PR to development

deploy to dev env --> dev will perform the testing from development side

dev team lead confirms features are tested properly

Build and release team -->  present they are called devops engineers

create one branch from development ---> release branch



Release branch
source: development
release/5.4.0 = deploy in to QA ---> QA team tests code

from now on every body should work rlease branch only 
lot of defects

QA team sign-off = clients will directly talk to QA lead


**Feature branching model**
modules or independent projects
one branch/feature one person


we have one release for every 2 weeks we follow feature branching

main = prod

feature branch from main branch

they do the development and deploy to dev env

if that is success they will raise PR if the PR is approved they merge changes to main branch
then we perform QA and UAT deployment

once we get QA and UAT sign off we will deploy to prod through CR process


Before deploying in to PROD we  

follow CR process

we raise the CR and we log
- what are changes in release
- date of release
- if failure how can we rollback ? what is the plan 
- any downtime
- QA testing results
- UAT results
- Scan results 

- Delivary Manager Approval
- QA Manager Approval
- Client Approval

- Deployment window[Release Date and time]

- deployment failed CR failed

- Why it is failed stop the next spring

- Do RCA

- Do the same process Again

1. You're working on latest modern things from the beginning
2. You worked on legacy things you we re part of migrating from legacy to modern


- How to do migration from github flow to feature branching model

- How can we integrate selenium test cases in QA pipiline


