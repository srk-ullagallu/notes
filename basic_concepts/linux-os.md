# Basics
## 👤 **User & Permissions**  

- `$` → **Normal User**  
- `#` → **Root User**  

- **whoami:** Displays the **current user name**.  
- **command1;command2:** Run **multiple commands** on a single line.  
- **date:** Display the **current date**.  

---

## 📄 **File Operations**

- **file hello.txt:** Shows the **type of file**.  
- **cat hello.txt:** Display the **content of the file**.  
- **head filename:** View the **first 10 lines** of a file.  
- **tail filename:** View the **last 10 lines** of a file.  
- **wc filename:** Count **lines, words, and characters** in a file.  

### 📝 **File System Navigation Commands**
- **pwd:** Show **current directory path**.  
- **ls:** List files and directories.  
- **cd dir:** Change to a **specific directory**.  
- **cd -:** Switch to the **previous directory**.  
- **cd ~:** Move to the **home directory**.  
- **mkdir dir:** Create a **new directory**.  
- **mkdir -p dir/subdir:** Create **parent directories if they don't exist**.  
- **cp src dest:** **Copy** files/directories.  
- **mv src dest:** **Move or rename** files/directories.  
- **rm file:** **Delete a file**.  
- **rmdir dir:** **Remove empty directory**.  

---

## 🛠️ **Command Shortcuts**

- **Tab Completion:** Auto-complete file/folder names.  
- **Continuing Command on Next Line (\\):** Extend commands across multiple lines.  
- **history:** Show **command history**.  
- **!number:** Execute the **command by its number** from history.  
- **!!:** Repeat the **last command**.  
- **!string:** Execute the **most recent command starting with 'string'**.  

---

## 🧠 **Editing Command Line Shortcuts**

- **Ctrl + A:** Jump to the **beginning of the line**.  
- **Ctrl + E:** Jump to the **end of the line**.  
- **Ctrl + U:** Clear **from the cursor to the beginning** of the line.  
- **Ctrl + K:** Clear **from the cursor to the end** of the line.  
- **Ctrl + <:** Jump to the **start of the previous word**.  
- **Ctrl + >:** Jump to the **end of the next word**.  
- **Ctrl + R:** **Search** command history.  

---

## 📂 **Linux File System (LFS)**

| **Directory** | **Purpose** |
|--------------|------------|
| `/`          | **Root directory** (Top of the file system tree). |
| `/home`      | **User home directories**. |
| `/boot`      | **Boot loader files**. |
| `/root`      | **Root user's home directory**. |
| `/etc`       | **System configuration files**. |
| `/bin`       | Essential **user commands**. |
| `/sbin`      | Essential **system commands** (Root only). |
| `/var`       | **Variable data** (e.g., logs). |
| `/usr`       | **User programs and libraries**. |
| `/tmp`       | **Temporary files** (Cleared after reboot). |
| `/dev`       | **Device files** (e.g., USB, disk drives). |

---

## 📊 **Inodes (Index Nodes)**

### 🛡️ **What is an Inode?**
- An inode is a **metadata structure** that stores information about files/directories in a Unix-like file system.

### 📋 **Inode Stores:**
- **File type** (regular file, directory).  
- **File size**.  
- **Owner (UID/GID)**.  
- **Permissions** (read/write/execute).  
- **Timestamps** (created, modified, accessed).  
- **Number of hard links**.  
- **Location of data blocks**.  

### ❌ **Inode Does NOT Store:**
- **File Name**.  

### 🧑‍💻 **View Inode Number:**  
```bash
ls -i filename
```

---

## 🔗 **Links in Linux**

### 🔄 **Hard Link**  
- **ln <name> <originalfile>**  
- Acts as **another name for the original file**.  
- Shares the **same inode** as the original file.  
- Deleting the original file **does not affect** the hard link.  
- ❌ Cannot span **across partitions**.  
- ❌ Cannot link **directories**.  

### 🧠 **Soft Link (Symbolic Link)**  
- **ln -s <originalfile> <linkname>**  
- Works like a **shortcut** to the original file/folder.  
- Has a **different inode** from the original file.  
- ✅ Can span **across partitions**.  
- ✅ Can link **directories**.  
- If the original file is deleted, the soft link **becomes broken**.  

### **SSH (Secure Shell)**
- **Purpose**: SSH is a protocol used to securely connect to remote systems for executing commands, transferring files, and managing remote servers.
- **Default Port**: SSH operates on port **22**.

### **SSH Configuration Files**
- `~/.ssh/config`: A user-specific SSH configuration file where you can define settings for each remote host, such as aliases, custom ports, and keys to use.
- `/etc/ssh/ssh_config`: The system-wide SSH client configuration file, defining default settings for all users on the system.
- `~/.ssh/known_hosts`: Stores fingerprints of previously connected hosts to verify their identity and avoid “man-in-the-middle” attacks.

### **Common SSH Commands**
- `ssh-keygen`: Generates SSH key pairs (public and private) for secure authentication.
- `ssh-copy-id -i .ssh/key-with-pass.pub user@remotehost`: Copies your public key to a remote server’s `authorized_keys` file to enable passwordless SSH login.
- `eval $(ssh-agent)`: Starts the SSH agent in the current shell session to manage keys.
- `ssh-add`: Adds private keys to the SSH agent for easier authentication.

### **SSH Server Configuration**
- `/etc/ssh/sshd_config`: The main SSH server configuration file, used to control access settings and authentication methods.
  - `PermitRootLogin yes`: Allows root user login via SSH (often set to “no” for security).
  - `PasswordAuthentication yes`: Enables password-based login. (Can be set to "no" if using key-based authentication only.)

### **Service Control**
- `systemctl reload sshd`: Reloads the SSH daemon configuration to apply changes made in `sshd_config` without disconnecting existing sessions.

# cron

### **What is Cron?**
- **Cron** is a time-based job scheduler in Unix-like operating systems used to automate repetitive tasks such as running scripts, performing backups, or clearing logs at specified intervals.

### **Common Cron Commands**
- `crontab`: Command to manage cron jobs for the current user.
  - `crontab -l`: List all scheduled cron jobs.
  - `crontab -r`: Remove all scheduled cron jobs.
  - `crontab -e`: Edit the current user’s cron jobs.
  - `crontab filename`: Load cron jobs from a specified file.

### **Crontab Format**
Each line in a crontab file represents a scheduled job, with the format:
```
* * * * * command
```
The fields appear in the following order:
1. **Minutes** (0 - 59)
2. **Hours** (0 - 23)
3. **Day of Month** (1 - 31)
4. **Month** (1 - 12, or jan, feb, etc.)
5. **Day of Week** (0 - 6, where Sunday = 0 or 7, or sun, mon, etc.)
6. **Command**: The actual command or script to execute

**Example**: `30 2 * * 1 /path/to/script.sh` — Runs `script.sh` at 2:30 AM every Monday.

### **System-Wide Cron Files and Directories**
- `/etc/crontab`: The system-wide crontab file, where each job line includes a user name after the time fields.
- `/etc/cron.d/`: Directory for additional cron job files, often used by packages to schedule specific tasks.
- `/etc/cron.hourly/, /etc/cron.daily/, /etc/cron.weekly/, and /etc/cron.monthly/`: Directories containing scripts to be run hourly, daily, weekly, or monthly.

### **Understanding Cron Expressions: Tips**
1. **Learn Each Field’s Range and Meaning**: 
   - Memorize the field order as **minutes, hours, day of month, month, day of week**.
2. **Use Wildcards (`*`) for Flexible Scheduling**: 
   - Asterisk (`*`) means "any value" in a field.
   - Example: `0 * * * *` means every hour on the hour.
3. **Combine Values with Commas and Ranges**:
   - Use commas (`,`) to separate multiple values. 
   - Example: `0 9,17 * * 1-5` means 9 AM and 5 PM, Monday to Friday.
4. **Use Slash for Intervals**: 
   - The `/` symbol allows you to specify intervals.
   - Example: `*/10 * * * *` means every 10 minutes.
5. **Refer to Tools for Help**:
   - Use tools like [crontab.guru](https://crontab.guru) or `man 5 crontab` to test and understand cron expressions.


# Process Management and Services
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

# Log Management

### **Log Management in Linux**

Linux logs events for auditing and troubleshooting in the `/var/log` directory, where log files are created and organized. Logs capture system and process events and are accessible with text utilities like `less` and `tail`.

**Logging Services:**
- **systemd-journald**: Collects log messages from the kernel, boot process, daemon output, and syslog events, organizing them into an indexed journal that does not persist across reboots by default.
- **rsyslog**: Reads messages from `systemd-journald` and saves them to persistent files in `/var/log`, sorting by program and message priority.

**Common Log Files in `/var/log`:**
- `/var/log/messages`: General system events.
- `/var/log/secure`: Security and authentication messages.
- `/var/log/maillog`: Mail server messages.
- `/var/log/cron`: Cron job logs.
- `/var/log/boot.log`: Boot process logs.

**Syslog Message Priorities:**
- **0 (emerg)**: System is unusable.
- **1 (alert)**: Immediate action required.
- **2 (crit)**: Critical condition.
- **3 (err)**: Non-critical error.
- **4 (warning)**: Warning.
- **5 (notice)**: Significant event.
- **6 (info)**: Informational.
- **7 (debug)**: Debugging messages.

**Configuration Files:**
- `/etc/rsyslog.conf` and `/etc/rsyslog.d/`: Configuration for `rsyslog`.
- `/etc/systemd/journald.conf`: Config for `systemd-journald`.

**Log Management Commands:**
- **`journalctl`**: View logs from `systemd-journald`.
  - `journalctl -n 5`: Show last 5 messages.
  - `journalctl -f`: Follow log output.
  - `journalctl --since today`: Show today’s messages.
- **`timedatectl`**: Manage system time and timezone.
  - `timedatectl set-timezone America/Phoenix`: Set timezone.
  - `timedatectl set-ntp true`: Enable NTP.

**Example Log Entry Breakdown:**
- **Timestamp**: When the log was recorded.
- **Host**: Source of the message.
- **Program/Process Name and PID**: Sender of the message.
- **Message**: Actual log content.

### **Log Rotation**
- **logrotate**: Rotates and compresses logs to manage disk usage in `/var/log`.

This setup enables Linux systems to maintain detailed, organized, and accessible logs for effective system auditing and troubleshooting.


