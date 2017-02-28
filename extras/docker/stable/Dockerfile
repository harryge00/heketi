# set author and base
FROM centos:centos7
MAINTAINER Luis Pabón <lpabon@redhat.com>

LABEL version="1.0"
LABEL description="Centos 7 docker image for Heketi"

COPY heketi /usr/bin/heketi

# post install config and volume setup
VOLUME /etc/heketi
VOLUME /var/lib/heketi

# expose port, set user and set entrypoint with config option
ENTRYPOINT ["/usr/bin/heketi"]
EXPOSE 8080

WORKDIR /etc/heketi

CMD ["-config=/etc/heketi/heketi.json"]
