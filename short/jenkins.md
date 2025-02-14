### Jenkins SharedLibs
Jenkins Shared Libraries allow you to create reusable pipeline code that can be used across multiple Jenkins jobs.

create a repo shared-libs
- create folder vars/
- hello.groovy

Configure SharedLibs in Jenkins
1. Go to Jenkins Dashboard → Manage Jenkins → Configure System.
2. Find the Global Pipeline Libraries section.
3. Click Add and enter:
    Name: shared-libs
    Source Code Management: Git
    Repository URL: (Enter your Git repo URL)
    Default Version: main (or specific branch/tag)
    ✅ Check Load Implicitly (if you want auto-loading)

In Pipeline you can configure shared Libs

@Library('shared-libs') _
hello('siva')

## 🚀 **Benefits of Shared Libraries**
✅ **Reusability**: Write once, use in multiple pipelines.  
✅ **Better Organization**: Keep pipelines clean by moving logic to shared libraries.  
✅ **Version Control**: Easily manage versions via Git branches/tags.  

### 🛠 **Jenkins Control Plane & Build Node Setup** (Simplified)  

Jenkins has **two main components**:  
1. **Jenkins Controller (Control Plane)** → Manages jobs, UI, and scheduling.[Distribute and orachestrate builds acorss build nodes]  
2. **Build Node (Agent/Worker)** → Runs the actual builds.  

- In Build Node enable password auth for ec2-user
- In Control plane setup agent 

### 🛠 **Use Cases of Build Nodes**  
✅ **Parallel Builds** → Run multiple jobs at once.  
✅ **Load Balancing** → Distribute builds across multiple machines.  
✅ **Different Environments** → Run builds on different OS versions.  
✅ **Faster Builds** → Offload work from the Jenkins controller.  

### 🔥 **Advantages of Using Build Nodes & Shared Libraries**
| Feature           | Build Nodes 🏗  | Shared Libraries 📜  |
|------------------|----------------|----------------------|
| Faster builds  | Runs on multiple machines | Code is reused, reducing complexity |
| Scalability  | Supports cloud & on-prem nodes | Easy to maintain multiple pipelines |
| Flexibility  | Builds on different OS & architectures | Centralized control of pipeline logic |
| Efficiency  | Frees Jenkins Controller resources | Updates affect all pipelines instantly |


