export JAVA_HOME=/usr/lib/jvm/jre
export JAVA_OPTS=-Djava.awt.headless=true
export CATALINA_HOME=/usr/share/tomcat
export CATALINA_BASE=/usr/share/tomcat
export CATALINA_PID=/usr/share/tomcat/temp/tomcat.pid
export CATALINA_OPTS="-Xms512M -Xmx1024M -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true"

/usr/share/tomcat/bin/catalina.sh start
