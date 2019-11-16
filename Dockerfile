FROM ubuntu:18.04
MAINTAINER ranjithum

RUN apt-get update && \
    apt-get install ssh tomcat8 python3 python3-pip git wget tar cron pkg-config autoconf -y

RUN wget -q https://github.com/oracle/opengrok/releases/download/1.3.3/opengrok-1.3.3.tar.gz && \
    tar -xf opengrok-1.3.3.tar.gz
    
RUN python3 -m pip install /opengrok-1.3.3/tools/opengrok-tools.tar.gz

RUN git clone https://github.com/universal-ctags/ctags && \
    cd ctags && git reset --soft f00bd6f0604c0ed2790ef514668a2f06f6f86d92 && ./autogen.sh && ./configure && make -j4 && make install

COPY open-grok_syncer.sh /var/opengrok/etc/
COPY indexer_cron /etc/cron.d/indexer_cron
COPY start_service.sh start_service.sh

RUN mkdir -p /var/opengrok/data /var/opengrok/etc /var/opengrok/source /root/.ssh && \
    touch /root/.ssh/config /home/id_rsa && \
    chmod 400 /home/id_rsa && \
    chmod 0644 /etc/cron.d/indexer_cron && \
    crontab /etc/cron.d/indexer_cron && \
    cp /opengrok-1.1/lib/source.war /var/lib/tomcat8/webapps/suckit.war && \
    rm -rf /ctags /opengrok-1.3.3.tar.gz

CMD ./start_service.sh
