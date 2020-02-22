#!/bin/bash

for pkg in epel-release pam_script; do yum install -y $pkg; done

yum install -y pam_script nmap-ncat
sudo useradd day && sudo useradd night && sudo useradd friday

echo "Otus2019"|sudo passwd --stdin day &&\
echo "Otus2019" | sudo passwd --stdin night && \
echo "Otus2019" | sudo passwd --stdin friday && \
echo "Otus2019" | sudo passwd --stdin root \

sudo sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
systemctl restart sshd.service
