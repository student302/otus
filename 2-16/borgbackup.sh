#!/usr/bin/env bash

#
LOG="/var/log/borg/backup.log"
BACKUP_USER="borg"
REPO_DIR="10.0.0.10:myborgrepo"
REPO="${BACKUP_USER}@${REPO_DIR}"

#log
exec > >(tee -i ${LOG})
exec 2>&1

#backup
echo "###### Backup started: $(date) ######"

echo "Transfer files ..."
borg create -v --stats --list                  \
    $REPO::'{now:%Y-%m-%d_%H:%M}'  \
    /root                                \
    /etc                                 \

echo "###### Backup ended: $(date) ######"

