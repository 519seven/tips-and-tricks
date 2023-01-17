Sample bash Script - Cacti Installation

chkconfig iptables off
service iptables stop
sed -i &#039;s/SELINUX=enforcing/SELINUX=disabled/g&#039; /etc/selinux/config
/usr/sbin/setenforce 0
yum update -y
yum install -y wget
mkdir -p /usr/src/cacti
cd /usr/src/cacti
yum install -y httpd
chkconfig httpd on
service httpd start
yum install -y mysql-server
chkconfig mysqld on
service mysqld start
mysqladmin -u root password dbadmin
yum install -y php php-gd php-mysql php-cli php-ldap php-snmp php-mbstring php-mcrypt
service httpd restart
yum install -y rrdtool
yum install -y net-snmp-utils
yum install -y tftp-server
chkconfig xinetd on
service xinetd start
wget http://www.cacti.net/downloads/cacti-0.8.7i-PIA-3.1.tar.gz
tar zxvf cacti-0.8.7i-PIA-3.1.tar.gz
wget http://www.cacti.net/downloads/patches/0.8.7i/settings_checkbox.patch
cd cacti-0.8.7i-PIA-3.1
yum install -y patch
patch -p1 -N &lt; ../settings_checkbox.patch
cd ..
mv -f cacti-0.8.7i-PIA-3.1/* /var/www/html/
rm -rf cacti-0.8.7i-PIA-3.1
chown -R apache:apache /var/www/html/
service httpd restart
mysql -u root -pdbadmin -e &#039;CREATE DATABASE `cacti` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;&#039;
mysql -u root -pdbadmin -e &quot;CREATE USER &#039;cactiuser&#039;@&#039;localhost&#039; IDENTIFIED BY &#039;cactiuser&#039;;&quot;
mysql -u root -pdbadmin -e &#039;GRANT ALL PRIVILEGES ON `cacti` . * TO &#039;cactiuser&#039;@&#039;localhost&#039;;&#039;
mysql -u cactiuser -pcactiuser cacti &lt; /var/www/html/cacti.sql
cat &gt; /etc/cron.d/cacti &lt;&lt;EOF
*/5 * * * * apache /usr/bin/php /var/www/html/poller.php &gt; /dev/null 2&gt;&amp;1
EOF
yum install -y gcc gcc-c++ make automake patch libtool net-snmp-devel openssl-devel mysql mysql-devel
wget http://www.cacti.net/downloads/spine/cacti-spine-0.8.7i.tar.gz
tar zxvf cacti-spine-0.8.7i.tar.gz
cd cacti-spine-0.8.7i
./configure
make &amp;&amp; make install
cp /usr/local/spine/etc/spine.conf.dist /usr/local/spine/etc/spine.conf
cd /usr/src/cacti
wget http://docs.cacti.net/_media/plugin:settings-v0.71-1.tgz -O settings.tgz
tar zxvf settings*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/settings
wget http://docs.cacti.net/_media/plugin:clog-v1.7-1.tgz -O clog.tgz
tar zxvf clog*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/clog
wget http://docs.cacti.net/_media/plugin:thold-v0.4.9-3.tgz -O thold.tgz
tar zxvf thold*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/thold
wget http://docs.cacti.net/_media/plugin:monitor-v1.3-1.tgz -O monitor.tgz
tar zxvf monitor*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/monitor
wget http://docs.cacti.net/_media/plugin:realtime-v0.5-1.tgz -O realtime.tgz
tar zxvf realtime*.tgz -C /var/www/html/plugins
mkdir -p /var/www/html/plugins/realtime/cache
chown -R apache:apache /var/www/html/plugins/realtime
yum install -y unzip
wget http://www.network-weathermap.com/files/php-weathermap-0.97a.zip
unzip php-weathermap-0.97a.zip -d /var/www/html/plugins/
chown -R apache:apache /var/www/html/plugins/weathermap
wget http://docs.cacti.net/_media/plugin:mactrack-v2.9-1.tgz -O mactrack.tgz
tar zxvf mactrack*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/mactrack
wget http://docs.cacti.net/_media/plugin:syslog-v1.22-2.tgz -O syslog.tgz
tar zxvf syslog*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/syslog
wget http://docs.cacti.net/_media/plugin:routerconfigs-v0.3-1.tgz -O routerconfigs.tgz
tar zxvf routerconfigs*.tgz -C /var/www/html/plugins
mkdir -p /var/www/html/plugins/routerconfigs/backups
chown -R apache:apache /var/www/html/plugins/routerconfigs
wget http://docs.cacti.net/_media/plugin:docs-v0.4-1.tgz -O docs.tgz
tar zxvf docs*.tgz -C /var/www/html/plugins
mv -f /var/www/html/plugins/docs* /var/www/html/plugins/docs
chown -R apache:apache /var/www/html/plugins/docs
wget http://nchc.dl.sourceforge.net/project/cacti-reportit/cacti-reportit/reportit_v073/reportit_v073.tar.gz -O reportit.tar.gz
tar zxvf reportit*.tar.gz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/reportit
wget http://docs.cacti.net/_media/plugin:rrdclean-v0.41.tgz -O rrdclean.tgz
tar zxvf rrdclean*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/rrdclean
wget http://docs.cacti.net/_media/plugin:discovery-v1.5-1.tgz -O discovery.tgz
tar zxvf discovery*.tgz -C /var/www/html/plugins
chown -R apache:apache /var/www/html/plugins/discovery
if [ &quot;$HOSTTYPE&quot; == &quot;x86_64&quot; ]; then
wget http://www6.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/wmi-1.3.14-2.el6.art.x86_64.rpm
rpm -Uvh wmi-1.3.14-2.el6.art.x86_64.rpm
elif [ &quot;$HOSTTYPE&quot; == &quot;i386&quot; ]; then
wget http://www6.atomicorp.com/channels/atomic/centos/6/i386/RPMS/wmi-1.3.14-2.el6.art.i686.rpm
rpm -Uvh wmi-1.3.14-2.el6.art.i686.rpm
fi
wget http://svn.parkingdenied.com/CactiWMI/trunk/wmi.php -O /var/www/html/scripts/wmi.php
chown -R apache:apache /var/www/html/scripts/wmi.php
service httpd restart