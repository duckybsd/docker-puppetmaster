Docker PuppetMaster
===================

Overview
--------
- Base build is Centos6 but no real reason to not change it to centos7 I guess
- Based on configs required for puppet 3.7.x
- Uses unicorn as app server (instead of passenger)
- Uses nginx to proxy to app (instead of apache)


Build
-----
```bash
$> (sudo) docker build -t your-user/puppetmaster:0.version . 
```

Config
------
- Exposes PORT 8140 (start docker with: -p 8140:8140)
- Exposes VOLUME /etc/puppet/environments/ (to use: -v /local/path/to/environments:/etc/puppet/environments)

Run (with persistent storage for /etc/puppet/environments)
----------------------------------------------------------
```bash
$> (sudo) docker run -d -p 8140:8140 -v /var/data/puppet:/etc/puppet/environments  your-user/puppetmaster:0.version
```

