FROM ubuntu:18.04
MAINTAINER ranjithum

RUN apt-get update && \
    apt-get install ssh tomcat8 python3 python3-pip git wget tar cron pkg-config autoconf -y

RUN wget -q https://github.com/oracle/opengrok/releases/download/1.1/opengrok-1.1.tar.gz && \
    tar -xf opengrok-1.1.tar.gz && \
    python3 -m pip install /opengrok-1.1/tools/opengrok-tools.tar.gz

RUN git clone https://github.com/universal-ctags/ctags

RUN cd ctags && ./autogen.sh && ./configure && make -j4 && make install

RUN mkdir -p /var/opengrok/data /var/opengrok/etc /var/opengrok/source /root/.ssh && \
    touch /root/.ssh/config /home/id_rsa && \
    chmod 400 /home/id_rsa

COPY open-grok_syncer.sh /var/opengrok/etc/
COPY indexer_cron /etc/cron.d/indexer_cron

RUN chmod 0644 /etc/cron.d/indexer_cron && \
    crontab /etc/cron.d/indexer_cron

RUN cp /opengrok-1.1/lib/source.war /var/lib/tomcat8/webapps/suckit.war

RUN rm -rf /ctags /opengrok-1.1 /opengrok-1.1.tar.gz && \
    apt remove autoconf pkg-config build-essential -y

CMD /etc/init.d/cron start; /etc/init.d/tomcat8 start; while true ; do sleep 100; done;
