# What is GitHubActions
































# Running Notes

# Traditional CI/CD Tools - Challenges
- Choose EC2 instance
- Install Jenkins,take care of Upgrades and Backups
- Take care of jenkins plugins installation
- Firewalls setup 

- No burden to manage infrastructure to setup CI/CD environment
- No need to install any softwares

# What is CI
# What is Continuous Deployment/Delivery

The Process of manual approval prior to production deployment is refer to as continuous delivery
# Why CI/CD?

# GithubActions
- It allows developers to automate task direcctly from their repo's you can quickly create workflows to implement CI/CD pipelines that build and test on every `PR` and deploy and merged pull request to the production tight beside your code base

- GithubActions Manages infrastructure for you
  - setup servers
  - scaling the resources
  - managing execution environment

  - Tasks in virtual envs
  - caching necessary dependencies
  - provinding reports on the outcomes

  - streameline development
  - reduce manual errors 
  - increase efficiency

- GithubActions is not only for CI/CD it will goes beyond CI/CD 

- The core component of Githubactions is `workflow` a `workflow` is automated process capable of executing one or more tasks this workflows defines using yaml file ansd located in `.github/workflows` with in your repos with in repo having multiple workflows each workflows responds for specific event occuring in your repo 
- Within `workflow` you can define one or more `jobs` a job consists a series of individual steps which are executed on a runner and `runner` is nothing but a virtual machine which is responsible for your `workflows` upon triggering    

# Types of Runners
1. Github hosted runner
2. Self-Hosted Runer


