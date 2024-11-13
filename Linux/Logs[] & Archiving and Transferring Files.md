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

