---
title: CCDC Notes
date: 2023-08-01
tags: [ctf,ccdc,blue_team]
---

# Red Team & Blue Team Considerations

## Red Team Tools & Tactics

Some notes I made while hanging around CCDC folks. 

### Cobalt Strike
- A powerful red team tool combining **Metasploit** features with **beaconing** capabilities.
- Often leverages `rundll32.exe` for execution.

### XAMPP
- A simple way to establish a reverse shell.

### Kerberoasting
- Exploiting service tickets for credential extraction.

### Windows Hash Storage
- Equivalent to `/etc/hashes` in Linux.
- Located in `C:\Windows\System32\Config\SAM`.
- Unauthorized access to this directory should raise concern.

### LSASS Credential Dumping
- Tools like **Mimikatz** ([GitHub](https://github.com/ParrotSec/mimikatz)) can extract password hashes.
- **LSASS process monitoring** is crucial; unauthorized access may indicate credential theft.
- [Microsoft guide](https://www.microsoft.com/en-us/security/blog/2022/10/05/detecting-and-preventing-lsass-credential-dumping-attacks/) on preventing LSASS attacks.

---

## System Security & Hardening

### Administrator Account Security
- `net user Administrator *` does **not** save in history (safe for password changes).
- `net user Administrator <random>` **does** save in history (not recommended).

### Group Policy Management
- Use `rsop` to check applied **Group Policies** (they may overlap and disable security settings).
- `gpupdate` updates policies; requires **relogin** and may take time.

### Domain & Workgroup Security
- Profile **domain/workgroup** to understand security implications.
- **Emergency "break glass" accounts** should be pre-configured.
- **Do not disable user accounts** unless necessary.
- **Avoid deleting accounts** when disabling suffices.

### Password & Credential Security
- **Change default passwords** on all systems.
- Cached logins allow authentication without a domain controller.
  - The **number of cached logins** can be adjusted in security settings.
- **Use TOTP-based MFA** (e.g., Google Authenticator).
- Red teams may **manipulate system time** to break TOTP.

---

## Active Directory & Incident Response

### Common Active Directory Tasks
- **Reset passwords**
- **Create/Delete user accounts**
- **Monitor Splunk logs** (`IP_ADDRESS:8000` for access)

### Security Monitoring
- **Monitor system file access**:
  - `C:\Windows\System32\Config\SAM` (Windows password hashes)
  - If **unprivileged users** access `System32`, investigate immediately.
- **Monitor suspicious application behavior**, especially in:
  - `C:\Intel\`
  - `C:\AMD\` (Red teams often store tools here)

### Windows Privilege Hierarchy
- **SYSTEM**: Most privileged Windows account, equivalent to `root` in Linux.
  - Bypasses most **syscall validation**.
  - Allows **direct hardware access** via drivers.
- **Administrator**: Less privileged than SYSTEM, but still a high-risk account.

---

## Kubernetes & Cloud Security

### Kubernetes Control Plane Security
- **Raft with etcd** for state management.
- **Longhorn**: Persistent storage management (PVC, PBC).
- **Time-series databases** in Kubernetes (TCSB).

### Cloud Services
- **AWS Lex**: AI-driven chatbot service.
- **Fluentd** ([fluentd.org](https://www.fluentd.org/)): Log aggregation.

---

## Miscellaneous Security Considerations
- **If a user has an active session**, changes (e.g., password updates) may not take effect until logout.
- Some services may **fail after password changes**, requiring manual intervention.
- **Avoid unnecessary deletions**—disable instead.
- Review **NCAE Cyber Games** checklist and set up a **VM** for testing.


## Snort 

there is something like a snort, it is suppsed to be a IDS , can be used as a packet logger or packet sniffer


## Locking and expiring an account 

#### Locking

`passwd -l username` locks the account, puts a ! in the shadow file  eg :-

Before locking 

`user:$6$asjdhfjaweh$:...` 

After Locking

`user:!$6$asjdhfjaweh$:...` 

but this only blocks password blocking 

Does NOT block access via non-password methods such as:

- SSH keys
- su (if a privileged user)
- cron jobs
- Other services that bypass password authentication

Good for temporary disabling of an account while allowing other automated or non-password-based access.

#### Expiring an Account

Expiring an account marks the user as no longer valid after a specific date or immediately.

`chage -E 0 username` (the -E flag sets an expiration date, 0 meaning immediate expiration).

#### SELinux 

SELinux can run in one of three modes: enforcing, permissive, or disabled.

- Enforcing mode : the selinux policy is enforced, default mode of operation 
- Permissive mode : the system acts as if SElinux is enforcing the policy , it emits cases into logs but does not deny any operations 
- disabled mode : Disabled mode is strongly discouraged; not only does the system avoid enforcing the SELinux policy, it also avoids labeling any persistent objects such as files, making it difficult to enable SELinux in the future. Files get changed and then you have to label entire filesystem .

selinux format 

`user:role:type:level`

eg : `system_u:object_r:cert_t:s0`

apache httpd_t is allowed to read cert_t types 


#### Network bridge 
connect 2 LANs together 
Since network bridges are Layer 2 devices, they forward packets to sub-LANs using MAC addresses
If the bridge does not know the source MAC addresses, the packet is broadcasted to all nodes. When a match is found, the MAC address is annotated in the designated table. 


