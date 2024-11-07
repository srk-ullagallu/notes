`CI`  a developers merege their code to central repo frequntly as devops engineer we provide env that code was build and tested with automated fashion.


`pipeline` connecting multiple stages together like
- checkout
- source code analysis
- owasp dependency check
- Quality gates
- test cases
- docker build 
- push to ecr

It is a conitnuous process

CI process we execpt an end for pipeline

CI pipelines are we start and we can expect and end 

Usually in organizations CI and CD pipelines are decoupled we are not going to do auto deployment to the prod

Actually CD pipeline has to deployment in dev and wait get sign off from the dev then then do in stage get sign off  and so on 

env to env deployment you need to get signoff 

Jenkins for CI

GithuB for CD

Developer adopt agile methdology to do developement

Jira has stories 

We are using github enterprise 

On each and every commint we are going to run the pipeline

code merge happen only PR[ReviewProcess]

commit ids are not userfirendly so we are using tags

So the pipeline that should support all the above scenarios 
    - Developer commits should be detected 
    - main commits should be detected
    - tags should be detected
After every detection pipeline should run for it's respective commit

Why Jenkins is not good for CD purpose
Since it does not have a flexibility to stop in b/w phase to phase and wait for some actions like approvals for a long time
In CD process no visibility is very minamal

IN CI jenkins is super tool ther is no competitor

continous delivary
manual release need to some approvals 

continous deployment
with automation release

Without manual intervention releases happend in prod[This is not happend in my carrer i'm not experienced this this scary also]

freestyle is a very basic

pipeline is only work for only one scenario[onebranch[tag,story,commit]]

multiBranch pipelne [it will detects a branches in vcs and it will the pipelines for each pipeline]

declarative pipeline is easy to write the code having the syntax

At a scale declarative pipeline cannot handle declarative pipeline has a limitation that is the reason I have changed my stance on declarative pipeline 

BlueOcean
PipelineStageView

# 21-9-24
Pipeline:MultiBranch
Jenkins Installation with Ansible

# 23-9-24




