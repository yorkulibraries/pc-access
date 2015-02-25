#!/bin/sh

# 
# The output of this script are the IP addresses of workstations that are in-use.
#
# How it works: 
#     extracts ping logs from the past 2 hours, 
#     load time and IP into a database table
#     run mysql query to retrieve the IP addresses that have ping'ed the server in the last 5 minutes or less. 
#     If a machine is in-use, it would ping the server every 5 minutes.
# 
# 
# This script must be run as root (or a user that can read /var/log/ping.log)
#
# WORKSTATION
#     each workstation must be setup to ping the server 
#     every 5 minutes after a user logged on (eg: use windows scheduled task).
#     On Windows: ping -n 3 SERVER_IP 
#     On Linux: ping -c 3 SERVER_IP 
#
# SERVER iptables
#     iptables -N LOGPING
#     iptables -A INPUT -p icmp -j LOGPING 
#     iptables -A LOGPING -j LOG --log-prefix "PING " 
# 
# SERVER /etc/rsyslog.conf - the following rules need to be added 
#    $template pinglogformat,"%TIMESTAMP:::date-mysql%, %msg%\n"
#    :msg, contains, "PING " /var/log/ping.log;pinglogformat
#
# SERVER mysql database 
#     CREATE DATABASE ping;
#     GRANT ALL PRIVILEGES ON ping.* TO 'ping_db_user'@'localhost' IDENTIFIED BY 'ping_db_password'
#     CREATE TABLE pings(id integer auto_increment primary key, ip varchar(15), time datetime);
# 
# SERVER ~/.my.cnf 
#    [clientping]
#    user=ping_db_user
#    password=ping_db_password
#    database=ping
#    host=localhost
# 

PING_INTERVAL=5
PING_LOG=/var/log/ping.log
DATABASE=ping
MYSQL="mysql --defaults-group-suffix=$DATABASE"
THIS_HOUR=`date +"%Y%m%d%H"`
PREVIOUS_HOUR=`date +"%Y%m%d%H" -d  "1 hour ago"`

# load pings in the past 2 hours (at most)
grep "${THIS_HOUR}\|${PREVIOUS_HOUR}" $PING_LOG | sed -n 's/\([0-9]\{14\}\), .\+SRC=\([0-9.]\+\).\+/\1,\2/p' | $MYSQL  -e "truncate table pings; load data local infile '/dev/stdin' into table pings fields terminated by ',' lines terminated by '\n' (time,ip);"

# print occupied list to STDOUT
$MYSQL -sN -e "select ip from pings where time >= (NOW() - INTERVAL ${PING_INTERVAL} MINUTE);" | sort -u

