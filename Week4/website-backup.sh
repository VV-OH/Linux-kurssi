#!/bin/bash

DATE=$(date +%Y%m%d-%H%M)

rsync -av /var/www/html/ \
ubuntu@86.50.20.159:/backups/www/$DATE/

rsync -av /home/ubuntu/viikko2/counter.db \
ubuntu@86.50.20.159:/home/ubuntu/viikko2/

if [ $? -eq 0 ]; then
    echo "$(date): SUCCESS" >> /home/ubuntu/website-backup.log
else
    echo "$(date): FAILED" >> /home/ubuntu/website-backup.log
fi

ssh ubuntu@86.50.20.159 "
cd /backups/www &&
ls -1dt */ | tail -n +3 | xargs -r rm -rf
"
