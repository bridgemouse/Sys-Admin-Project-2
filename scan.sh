#!/bin/bash
sudo apt-get install geoip-bin > /dev/null
array=()
grep "Invalid user" /var/log/auth.log >> holding.log
readarray array < holding.log
ipadd=""
country=""
date=""
for i in "${array[@]}"; do
        ipadd="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$i")"
        country="$(geoiplookup -s $ipadd)"
        date=$(echo "$i" | cut -c1-15)
        echo "$ipadd ""$country ""$date" >> /var/webserver_log/unauthorized.log
done
sudo rm holding.log