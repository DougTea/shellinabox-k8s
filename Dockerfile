FROM sspreitzer/shellinabox:ubuntu

RUN apt update

RUN apt install -y python2-minimal

ADD binary/kubectl /usr/local/bin/kubectl

RUN chmod 0755 /usr/local/bin/kubectl

ADD scripts/run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

ADD scripts/entrypoint.sh /usr/local/sbin/