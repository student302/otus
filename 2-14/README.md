### 2-14 Users and Groups. Pluggable Authentication Modules (PAM)
pam modules: pam_time, pam_exec, pam_cap, pam_scripts
https://en.wikipedia.org/wiki/Linux_PAM

#### Preparing tests  environmentPreparing tests  environment
Vagrantfile+provision.sh make centos/7 VM + add three users day,night and friday + set passwords + PasswordAuthentication yes for sshd + install pam_scripts and nmap-ncat

1. copy vagrantfile and scripts from this repository to  your directory,
2. vagrant up

#### pam_time
This module manage accounts access by time.

1. Add this to /etc/security/time.conf
```bash
    *;*;day;Al0800-2000
    *;*;night;!Al0800-2000
    *;*;friday;Fr
	*;*;vagrant;A;0000-2400
```
first ***** - service
second ***** - terminal name
**day** - username
**Al0800-2000** - access time
2. Add this to /etc/pam.d/sshd
```bash
account required pam_nologin.so
account required pam_time.so
```
3. Check access from second terminal using every users, for example:
```bash
ssh night@127.0.0.1 -p 2222
```

####pam_exec

1. Delete previous changes from /etc/pam.d/sshd
2. Add this to /etc/pam.d/sshd
```bash
account required pam_nologin.so
account required pam_exec.so /usr/local/bin/test_login.sh
```
3. Copy script test_login.sh to /usr/local/bin/
https://gist.github.com/dmitry-lyutenko/39bf8afe5d1f6fc2d48b09c325706495

Based on the script completion code, the pam_exec module makes a decision. If 0 is returned all right and the user will be logged in, otherwise not.

####pam_script
1. this module is already installed from Vagrantfile
if not:
```bash
for pkg in epel-release pam_script; do yum install -y $pkg; done
```
2. Delete previous changes from /etc/pam.d/sshd
3.  Add this to /etc/pam.d/sshd
```bash
account required pam_nologin.so
account required pam_script.so /usr/local/bin/test_login.sh
```
test_login.sh is the same script from pam_exec

4. Test access to your VM

####pam_cap

1. For using this module we need the nmap-ncat. It hsould be allready installed from Vagrantfile.
if not:
```bash
pkg in epel-release nmap-ncat; do yum install -y $pkg; done
```
2. ssh day@127.0.0.1 -p 2222
3. try  ncat -l -p 80 and get error
```
ncat -l -p 8
Ncat: bind to 80: Permission denied. QUITTING.
```
day hasn't access for this
4. off SELintux  ( only for testing)
```bash
setenforce 0
```
5. Add this to  /etc/pam.d/sshd
```bash
auth include postlogin
auth required pam_cap.so
```
In this way, we enabled processing **capabilities** under **ssh** connection.
6. get  nessasery permission for **day** 
make file /etc/security/capability.conf and add this
```bash
cap_net_bind_service day
```
7. get essasery permission for ncat
sudo setcap cap_net_bind_service=ei /usr/bin/ncat
8. relogin to VM
```bash
ssh day@127.0.0.1 -p 2222
```
9. check your capabilities
```bash
capsh --print
Current: = cap_net_bind_service+i
```
10. try ncat -l -p 80
11. open one more terminal and do this
```bash
echo "Make Linux great again!" > /dev/tcp/127.0.0.7/80
```
You should see the message in firs terminal

###root permission
1. usermod day -G wheel
2. add this to /etc/sudoers
day ALL=(ALL) ALL
or
day ALL=(ALL) NOPASSWD: ALL


