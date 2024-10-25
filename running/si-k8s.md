# 10-7-2024[Cluster|Creation|Upgradation]
Admin Activity

What is kubeconfig file[used|for|auth|authrization|k8s|cluster] .kube/config

Cluster Upgradation is planned
- No down time to the existing apps but no new releases or no new deployments
- We will notify all app teams we are performing a platform upgrade on this time [night|time|preferred|may|have|less|traffic]
- During the cluster upgradation you did n't have any access

- Notify each and every step during cluster upgradation to the stakeholders

1. We need to another node group[green] with same capacity
2. Cordon green nodes so that they should not get any pods schedule
3. Upgrade control plane from [console][application|should|accessible|during|control|upgradation]
   - Because workloads are running in the nodes
   - If you do upgradation from Terraform it will upgrade both control plane and worker nodes together
   - This is not recommanded

4. Upgrade green node group to 1.30[console]
5. Cordon the blue node group
6. UnCordon the green nodes
7. Drain the workloads in the blue nodes ignore daemons sets

- We will take 1 hour downtime not for application for platform 
- Inform all stake holders[application|teams|managers] and perform sanity testing all workloads are running perfectly or not
- Once the evrything is good close the activity[Jira|Ticket]

[ChatGPT|Version]
In an interview, you could break down the cluster upgrade process step-by-step, focusing on key aspects of coordination, automation, and downtime minimization.

### Explanation:

**Kubeconfig File:**
The `kubeconfig` file (typically located in `.kube/config`) is crucial for managing access to Kubernetes clusters. It stores configurations for multiple clusters and user authentication details, allowing you to securely interact with clusters by defining contexts and users. It’s essential for tasks that require authorization and authentication when connecting to the Kubernetes API server.

### Cluster Upgrade Plan:
1. **Planning for No Downtime:**
   - To ensure zero downtime, no new deployments or releases occur during the upgrade window. The app teams are notified beforehand to align expectations.

2. **Stakeholder Communication:**
   - Continuous updates on upgrade status are sent to stakeholders, ensuring all are aware of each upgrade stage.

3. **Steps for Upgrade:**
   - **Node Group Setup:** Create a new node group ("green") identical in capacity to the current one ("blue"). This green node group will serve as the staging area for workload migration.
   
   - **Node Cordon (Green):** Cordon the green nodes to prevent any new pods from being scheduled there initially.

   - **Control Plane Upgrade:** Upgrade the control plane first through the console (separately from worker nodes), ensuring uninterrupted access to the application. This step is separate from Terraform to avoid simultaneous upgrades, which could disrupt workloads.

   - **Green Node Upgrade:** Once the control plane is upgraded, proceed with upgrading the green node group to version 1.30 using the console.

   - **Workload Migration:** 
     - **Cordon Blue, UnCordon Green:** Transition workloads by uncordoning green nodes, allowing them to host new workloads. Cordon the blue nodes to stop new pods from scheduling there.
     - **Drain Blue Nodes:** Migrate all workloads from blue nodes by draining them, ignoring daemon sets. This gradually moves workloads to the green node group.

4. **Platform Downtime (1 Hour):**
   - A one-hour platform downtime is scheduled (not impacting application availability) to finalize the migration and allow for sanity checks.
   
5. **Final Testing and Closure:**
   - Perform sanity tests to ensure workloads are stable post-upgrade. After verification, close the task and update the ticket in Jira.

This detailed plan showcases a structured approach to a cluster upgrade, emphasizing coordination with stakeholders, risk management, and adherence to best practices for minimal service disruption.