FROM centos:centos7

MAINTAINER Michael Koppen <michael.koppen@googlemail.com>

# Installing Utilities
# ---------------------*
RUN yum -y install hostname sudo passwd initscripts

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all; \ 
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \ 
rm -f /lib/systemd/system/multi-user.target.wants/*;\ 
rm -f /etc/systemd/system/*.wants/*;\ 
rm -f /lib/systemd/system/local-fs.target.wants/*; \ 
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \ 
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \ 
rm -f /lib/systemd/system/basic.target.wants/*;\ 
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -v 12.0.1

# install openssh-clients for scp-command
RUN yum install -y openssh-server openssh-clients
RUN mkdir -p /var/run/sshd
RUN ssh-keygen -A

# *********************
# Creating kitchen SSH Account
RUN useradd -d /home/kitchen -m -s /bin/bash kitchen; \
  echo kitchen:kitchen | chpasswd; \
  echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers; \
  sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers; \
  echo "UseDNS no" >> /etc/ssh/sshd_config; \
  echo "UsePAM no" >> /etc/ssh/sshd_config; \
  echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config; \
  echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config; \
  sed -i -r 's/^(.*pam_nologin.so)/#\1/' /etc/pam.d/sshd;

RUN yum clean all

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/sbin/init"]