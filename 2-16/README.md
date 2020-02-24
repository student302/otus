### Otus.2-17. BackupOtus.2-17. Backup

I used the Borg Backup for this task.

#### 1. Vagrant up.1. Vagrant up.

2.  copy script to borg-client1
vagrant plugin install vagrant-scp
vagrant scp borgbackup.sh borg-client1:/opt/scripts

#### 3. Copy ssh-key from borg-client1:/root/.ssh/id_rsa.pub to borg-server:~borg/.ssh/authorized_keys manually

open two terminals, go to vagrant ssh to severs and copy ssh key

#### 4. go to borg-client1 and run backup

run backup manualy 
```bash
borg create --stats --list borg@10.0.0.10:myborgrepo::"MyFirstBackup-{now:%Y-%m-%d_%H:%M:%S}" /etc /root
```
run script
```bash
bash /opt/scripts/borgbackup.sh
```
#### 5. show repo list
```bash
borg list borg@10.0.0.10:myborgrepo
```

#### 5. add every 10min backup task to /etc/crontab on borg-client1 (already added from Vagrantfile)
```bash
cat /etc/crontab
sudo echo " 10  *  *  *  * bash /opt/scripts/borgbackup.sh >/dev/null" >> /etc/crontab
```
#### 6. borg diff is tool for search difference between archives, for example:
```shell
[root@borg-client1 .ssh]# borg diff borg@10.0.0.10:myborgrepo2::MyFirstBackup-2020-02-24_10:13:07 MyFirstBackup-2020-02-24_12:09:34 
+26 B     -26 B root/.config/borg/security/06c6565849bff7b71a2f77950777376c9eaaf4338cb440706926dd66f3c98b00/manifest-timestamp
added       8.89 kB etc/nanorc
```



