#FROM sspreitzer/shellinabox:ubuntu
FROM harbor.westwell-research.com/hub/sspreitzer/shellinabox:ubuntu

RUN printf "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse\ndeb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse\ndeb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse\ndeb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse" |tee /etc/apt/sources.list 

RUN apt-get update && apt-get install -y python2-minimal

ADD binary/kubectl /usr/local/bin/kubectl

RUN chmod 0755 /usr/local/bin/kubectl

ADD scripts/run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

ADD scripts/entrypoint.sh /usr/local/sbin/
