# Process Management
A **process** is simply a running instance of a program. Each process is assigned a unique Process ID (PID) and fair amount of dedicated  system resources to complete its job independently.All process are running isolated

- Kernel is the main component in the OS it can efficiently manages the System resources and has capable of convert system calls into binary instructions to interact with H/W and vice-versa
- Kernel has many features but out of that Namespaces and cGroups plays a vital role in the containers world
- Namespaces are a feature of the Linux kernel that partitions kernel resources such that one set of processes sees one set of resources while another set of processes sees a different set of resources and it Prevent interfearece b/w 2 process
- Namespaces provides isolations different levels each and every process has it's own set of
  - PID
  - N/W[Each container get it's own n/w stack[IPaddresses,RoutingTables,firewallrules]]
  - USERS/Groups
  - Hostname
  - FileSystem[mount/umount]

- cGroups are allocating and managing compute resources at process level[ensuring each and every process gets fair distribution and preventing any single process from monopolizing system resources.][assign and control system resources to a process]

Here’s an overview of the Linux commands and concepts you’ve listed:

### **Daemon Process**
- A **daemon** is a background process that runs independently of a terminal session, often started during system boot, performing specific functions (e.g., `httpd` for web services, `sshd` for SSH access). Ever running process in the system

### **Process Management Commands**
- `top`: Displays a dynamic, real-time view of system processes, showing CPU and memory usage.
- `ps aux`: Lists all running processes, with details like user, CPU/memory usage, and command.
- `ps -ef`: Shows a full-format listing of all processes with parent-child relationships.
- `ps lax`: Provides a more detailed view, including priority and scheduling information.
- `pstree`: Displays a hierarchical tree of processes, showing parent-child relationships.

### **Process Control Commands**
- `sleep 1000 &`: Runs the `sleep` command in the background for 1000 seconds, allowing the shell to continue.
- `fg`: Brings a background job to the foreground.
- `bg`: Sends a suspended job back to the background to run.
- `jobs`: Lists all jobs running in the current shell session, showing job IDs and statuses.
- `ps j`: Displays process information related to job control, including session ID and process group.

#### Specific Job Control
- `fg %1`: Brings job number 1 to the foreground.
- `bg %1`: Sends job number 1 to the background to continue running.

### **System Monitoring Commands**
- `w`: Shows who is logged on and their activity.
- `uptime`: Displays system uptime, load averages, and the current time.

### **Process Search and Termination**
- `pgrep -lu bob`: Lists processes running under user `bob`, displaying their PIDs.
- `pkill`: Terminates processes based on name or other criteria.

### **System Information**
- `lscpu`: Displays detailed information about the CPU architecture, including cores, threads, and cache.

### **Killing Processes**
- `kill -9 <PID>`: Forcibly terminates a process with the specified Process ID (PID) using signal `9` (SIGKILL), which cannot be caught or ignored by the process.


# Controlling Services and Daemons
Here’s an overview of the `systemd` daemon and commonly used `systemctl` commands:

### **systemd Daemon**
- `systemd` is the core service manager for modern Linux distributions, responsible for booting the system, managing system services, and handling processes.
- It **activates system resources, server daemons, and processes** both at boot time and during regular operation, streamlining service and process management.

### **Key `systemctl` Commands**
- **List Active Services**:
  - `systemctl list-units --type=service`: Lists all currently active services (units) on the system.
  - `systemctl list-unit-files --type=service`: Lists all installed services (unit files), showing if they’re enabled or disabled.

- **Service Control**:
  - `systemctl <action> <service-name>`: Common actions include:
    - `status`: Displays the current status of a service.
    - `start`: Starts a service immediately.
    - `stop`: Stops a running service.
    - `restart`: Stops and then restarts a service.
    - `reload`: Reloads a service’s configuration without stopping it.
    - `enable`: Enables a service to start automatically at boot.
    - `disable`: Disables a service from starting at boot.
    - `daemon-reload`: Reloads systemd manager configuration to recognize new or modified unit files.

- **View Dependencies**:
  - `systemctl list-dependencies <service-name>`: Lists all services and units that a specified service depends on, helping to understand inter-service relationships.


This `systemd` service file, `backend.service`, is used to define and manage a custom **Backend Service** that runs a Node.js application. Here’s a breakdown of its configuration:

```ini
[Unit]
Description=Backend Service
```
- The **[Unit]** section provides metadata about the service.
- `Description`: A brief description of the service (e.g., “Backend Service”).

```ini
[Service]
User=expense
Environment=DB_HOST="<MYSQL-SERVER-IPADDRESS>"
ExecStart=/bin/node /app/index.js
SyslogIdentifier=backend
```
- The **[Service]** section defines how the service should run.
- `User=expense`: Specifies that the service will run under the `expense` user account.
- `Environment=DB_HOST="<MYSQL-SERVER-IPADDRESS>"`: Sets an environment variable (`DB_HOST`) with the IP address of the MySQL server.
- `ExecStart=/bin/node /app/index.js`: Specifies the command to start the Node.js application, pointing to the `index.js` file.
- `SyslogIdentifier=backend`: Sets an identifier for logging, making it easier to filter logs for this service.

```ini
[Install]
WantedBy=multi-user.target
```
- The **[Install]** section defines the target at which the service will start.
- `WantedBy=multi-user.target`: Ensures that the service is started when the system reaches the `multi-user` run level, suitable for non-graphical multi-user systems.

### Usage
1. **Enable the Service**: `sudo systemctl enable backend.service` (to start at boot).
2. **Start the Service**: `sudo systemctl start backend.service`.
3. **Check Status**: `sudo systemctl status backend.service` to view the current status and logs.
4. **Stop/Restart**: Use `sudo systemctl stop backend.service` or `sudo systemctl restart backend.service` as needed.

This setup allows `systemd` to manage the backend service efficiently, ensuring it starts at boot and is isolated under the specified user with the necessary environment variables.

It sounds like you're describing the general data flow process in a computer system. Here’s a breakdown of the typical flow:

1. **Process** → **RAM**: A process (a running program) requires data or instructions to execute. These are initially loaded from the storage (like a hard drive or SSD) into the **RAM (Random Access Memory)** because it's faster to access than long-term storage.

2. **RAM** → **CPU**: The CPU (Central Processing Unit) needs data and instructions to execute tasks. It fetches them from RAM because RAM provides quicker access than other storage. The CPU processes this data to perform calculations or logic operations.

3. **CPU** → **H/W (Hardware)**: If the process involves interacting with hardware (e.g., a GPU for graphics processing, hard drive for storage, or a network card for sending data), the CPU will communicate with the appropriate hardware component.

4. **H/W** → **CPU**: The hardware performs its function (like rendering an image or saving a file) and sends any necessary results or responses back to the CPU.

5. **CPU** → **RAM**: The CPU might store processed data back into RAM for quick access, especially if the data is needed for further processing.

6. **RAM** → **Process**: The updated data or results in RAM are accessed by the process, which can then proceed with the next steps or update accordingly.

To summarize the cycle:
1. A **Process** needs data → loaded into **RAM**.
2. **RAM** provides data to the **CPU** for processing.
3. **CPU** might interact with other **Hardware** components for specific tasks.
4. Hardware results go back to the **CPU**.
5. **CPU** may update data in **RAM**.
6. The **Process** uses updated data from RAM.

This flow continues in loops as the program executes, depending on the complexity and requirements of the task.
