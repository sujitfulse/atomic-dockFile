FROM jcajka/fedora22-ppc64le
MAINTAINER "Sujit Fulse" <sujitfulse@gmail.com>


RUN dnf update -y; \
dnf install -y rpm-ostree httpd git nscd; \
dnf clean all

RUN mkdir -p /home/working; \

cd /home/working; \

git clone https://git.fedorahosted.org/git/fedora-atomic.git; \

mkdir -p /srv/rpm-ostree/repo && cd /srv/rpm-ostree/ && ostree --repo=repo init --mode=archive-z2

ADD rpm-ostree.conf /etc/httpd/conf.d/

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart

ADD run-apache.sh /run-apache.sh

RUN chmod -v +x /run-apache.sh

WORKDIR /home/working
CMD ["/run-apache.sh"]
