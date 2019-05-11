#!/bin/bash
echo "This script will create RAID 6!!!"
sleep 3s
sudo lshw -short | grep disk;
sleep 1s
sudo fdisk -l;
sleep 2s
mdadm --zero-superblock --force --verbose /dev/sd{b,c,d,e,f} &&
yes y | mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f} &&
echo "Done."
sleep 1s
echo "Checking RAID..."
sleep 1s
cat /proc/mdstat;
echo "######################################"
mdadm -D /dev/md0;
echo "Exit..."
sleep 2s
exit
