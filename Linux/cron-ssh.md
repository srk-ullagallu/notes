# SSH

Here’s an overview of SSH (Secure Shell) and some commonly used files and commands for SSH configuration and management:

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

