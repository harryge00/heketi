# set author and base
FROM centos:centos7
MAINTAINER Luis Pabón <lpabon@redhat.com>

LABEL version="1.0"
LABEL description="Centos 7 docker image for Heketi"

ADD heketi /usr/bin/heketi

# post install config and volume setup
VOLUME /etc/heketi
ADD heketi.json /var/lib/heketi/heketi.json
ADD heketi-cli /usr/bin/heketi-cli
ADD load_cluster /usr/bin/load_cluster 
ADD init_heketi.sh /usr/bin/init_heketi.sh
# expose port, set user and set entrypoint with config option
ENTRYPOINT ["/usr/bin/heketi"]
EXPOSE 8080

CMD ["-config=/var/lib/heketi/heketi.json"]