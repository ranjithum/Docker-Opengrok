#!/bin/bash

# start the tomcat service
/etc/init.d/tomcat8 start

# start the cron service
/etc/init.d/cron start

# Run dummy forever
while true
do
	sleep 100
done
