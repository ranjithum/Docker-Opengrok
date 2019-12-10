#!/bin/bash

# start the tomcat service
/usr/share/tomcat/bin/start_tomcat.sh &

# start the cron service
crond

# run dummy forever
while true
do
	sleep 100
done
