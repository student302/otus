How to get access to system without password:
1.  init=/bin/sh

Press "e" when system starting, add  init=/bin/sh to the end of the line started from linux16, press  сtrl-x. Theh you should remount / to the Read-Write:

mount -o remount.rw /

Then you can change root passwd

2. rd.break

Press "e" when system starting, add rd.break to the end of the line started from linux16, press  сtrl-x. Theh you should remount /sysroot to the Read-Write:

mount -o remount,rw /sysroot
chroot /sysroot
passwd root
touch /.autorelabel

3.  rw init=/sysroot/bin/sh

Press "e" when system starting, change ro to rw init=/sysroot/bin/sh at the line started from linux16, press  сtrl-x. Theh you should remount /sysroot to the Read-Write:

chroot /sysroot
passwd root
touch /.autorelabel

