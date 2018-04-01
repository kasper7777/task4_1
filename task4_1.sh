#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"
DIRECTORY="$(pwd)"
exec 1> $DIRECTORY/task4_1.out


### CPU ###
info=$(cat /proc/cpuinfo | grep "model name" | cut -c 14- |sort |uniq)
echo "CPU: $info"

### RUM ###
info_memory=$(cat /proc/meminfo | grep "MemTotal" | cut -c 20- |sort |uniq)
echo "RUM: $info_memory"

### Motherboard ###
echo "Motherboard:" `sudo dmidecode --type baseboard | grep Manufacturer: | cut -c 15- || echo "Unknovn"`

### Serial number ###
echo 'System Serial Number:' `dmidecode -s system-serial-number  || echo 'Unknow'`

### System ###
echo 'OS Distribution:' `lsb_release -d -s || echo 'Unknown'`
echo 'Kernel version:' `uname -r || echo 'Unknown'`
echo 'Installation date:' `ls -alct /|tail -1|awk '{print $6, $7, $8}' || echo 'Unknown'`
echo 'Hostname:' $(hostname) || echo 'Unknown'
echo "Uptime:" `uptime -p`
echo 'Processes running:' `ps -A | wc -l`
 
### Users logged in: ### 
echo "Users logged in:" `who --count | grep user | cut -c 9- |sort |uniq`

### network ###
ip -o -4 a l | awk '{print " "$2" :", $4}'
