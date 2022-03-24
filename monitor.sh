#!/bin/bash
sudo apt-get install ssmpt > /dev/null
sudo apt-get install mailutils > /dev/null
NOW=$(date | cut -c1-13)
hrAgo=$(date -d "1 hours ago" | cut -c1-13)
lTime=$(date -r /var/webserver_monitor/unauthorized.log | cut -c1-17)
if [ "$hrAgo" == "$lTime" ]; then
        contents="No unauthorized attempts."
else
        contents=$(sudo sed -n '/"$hrAgo"/,/"$NOW"/p' /var/webserver_monitor/unauthorized.log)
fi
echo "Please check the attatchment" | mail -s "Unauthorized.log Update" EB907277@wcupa.edu -A "$contents"

