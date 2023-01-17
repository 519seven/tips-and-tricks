BASH Code Samples ~ Sample Scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#!/bin/bash

nginxconf=' /etc/nginx/nginx.conf'

status=$(grep limit_rate $nginxconf)
if [ $? -eq 0 ]
then
    echo "Web server rate limit feature is already set"
    exit
fi

echo "Setting web server rate limit feature"

cat - > $nginxconf <<EOF
user www-data;
worker_processes  1;

error_log  /var/log/nginx/error.log;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
    # multi_accept on;
}

http {
    include       /etc/nginx/mime.types;
    limit_rate_after 1m;
    limit_rate 100k;

    access_log  /var/log/nginx/access.log;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    #keepalive_timeout  65;
    keepalive_timeout  305;
    tcp_nodelay        on;
    send_timeout       5m;

    gzip  on;
    gzip_disable "MSIE [1-6]\.(?!.*SV1)";

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;

}
EOF

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
