How to get access to system without password:
1. Press "e" when system starting, add  init=/bin/sh to the end of the line started from linux16. Theh you should remount / to the Read-Write:

mount -o remount.rw /

Then you can change root passwd

2. 
