FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]

WORKDIR /home/root

COPY init.sql exec_sql_init.sh ./
COPY exec_sql_init_cron /etc/cron.d/exec_sql_init_cron


ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && \
    apt-get install -y -q curl gnupg sudo dialog apt-utils nano && \
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list && \
    apt-get update && \
    apt-get install -y systemd cron less mssql-tools && \
    chmod 0777 exec_sql_init.sh && \
    chmod 0644 /etc/cron.d/exec_sql_init_cron && \    
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && \
    source ~/.bashrc

RUN crontab /etc/cron.d/exec_sql_init_cron

CMD ["cron", "-f"]

