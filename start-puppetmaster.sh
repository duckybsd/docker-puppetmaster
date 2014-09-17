#! /bin/bash

echo "**********************************"
echo Creating initial puppet certs by starting/stopping puppetmaster
if [ ! -d /var/lib/puppet/ssl ]; then
  /etc/init.d/puppetmaster start
  /etc/init.d/puppetmaster stop
else
  echo "| not required"
fi

echo "**********************************"
echo "Puppet certs, keys, ca"
echo "**********************************"
find /var/lib/puppet/ssl/
echo "**********************************"
echo "**********************************"
echo "Active unicorn configuration"
echo "**********************************"
cat /etc/puppet/unicorn.conf
echo "**********************************"
echo "Active puppet master configuration"
echo "**********************************"
cat /etc/puppet/puppet.conf
echo "**********************************"
echo
echo "**********************************"
echo "Running nginx"
echo "**********************************"
/etc/init.d/nginx start
echo
echo "**********************************"
echo "Starting unicorn"
echo "**********************************"
/usr/bin/unicorn -Dc /etc/puppet/unicorn.conf
echo
echo
echo "**********************************"
echo "Nginx logging"
echo "**********************************"
echo
tail -f /var/log/nginx/*log

