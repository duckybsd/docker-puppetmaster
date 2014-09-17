FROM centos:centos6
MAINTAINER Alex Leonhardt <aleonhardt.py@gmail.com>
#
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum -y install wget tar puppet puppet-server make gcc ruby-devel rubygems-devel rubygems nginx supervisor puppetdb-terminus
RUN gem install unicorn --no-rdoc --no-ri
RUN cp /usr/share/puppet/ext/rack/config.ru /etc/puppet
#
ADD site.pp /etc/puppet/manifests/site.pp
RUN mkdir -p /etc/puppet/environments/{dev,stg,prd}/{modules,manifests}/
RUN chown -R puppet:puppet /etc/puppet/
#
ADD unicorn.conf /etc/puppet/unicorn.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD puppet.conf /etc/puppet/puppet.conf
ADD puppetdb.conf /etc/puppet/puppetdb.conf
ADD supervisord.conf /etc/supervisord.conf
#
ADD start-puppetmaster.sh /opt/start-puppetmaster.sh
WORKDIR /var/lib/puppet
VOLUME ['/etc/puppet/environments']
#
EXPOSE 8140
CMD ["/opt/start-puppetmaster.sh"]

