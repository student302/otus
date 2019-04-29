# Howe work for Linux Administration course #
## 1-1. Build and update kernel for CentOS7 # 1-1 is 1 month and 1 task:

### 1. Update your CentOS and install tools for core building:
yum -y update && yum -y groupinstall "Developement tools"  
yum -y install git wget openssl-devel

### 2. Check kernel version:
uname -rs

### 3. Download and unpack new core:
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.37.tar.xz  
tar -xvf linux-4.19.37.tar.xz  
cd /linux-4.19.37
mv linux-4.19.37 linux

### 4. Copy kernel configs and build:
#### here I got openssl fatal errors like this - "scripts/sign-file.c:25:30: fatal error: openssl/opensslv.h: No such file or directory" 
#### solution is "yum -y install openssl-devel"

yum -y install openssl-devel  
cp /boot/config-3.10.0-957.10.1.el7.x86_64 /usr/src/linux/.core  
yes "" | make oldconfig) # I choosed all kernel options because I got this error https://access.redhat.com/solutions/2515741 in the other case  
make -j4 && make modules_install && make -j4 install # -j4 allow 4 jobs at once. Look at make --help

### 5. make new kernel as default

grub2-set-default 'CentOS Linux (4.19.37) 7 (Core)'

reboot

### 6. Check new kerner version

uname -rs

### p.s.
### 1. I worked in Windows 10 and VirtualBox 6
### 2. I choosed yes "" | make oldconfig) for all kernel options because I got this error https://access.redhat.com/solutions/2515741 in the other case.

