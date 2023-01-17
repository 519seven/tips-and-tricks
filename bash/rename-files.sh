#!/bin/bash 
# BASH Code Samples ~ Renaming files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### Replace existing filename with new name

TIMESTAMP=`date '+%Y%m%d'`
for f in "$@"
do
	EXTENSION=${f##*.}
	FILENAME=`basename $f | sed 's/\(.*\)\..*/\1/'`
	DIRPATH=`dirname $f`
	cp "$f" "$DIRPATH/$FILENAME$TIMESTAMP.$EXTENSION"
done

#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### Rename list of files from bash shell

for i in *.png; do mv -v $i `basename $i .png`.test.png; done

# ------------------------------------------------------------------------------
# Full script for renaming files
# ------------------------------------------------------------------------------
# Full script for renaming files
# Loop through every file in a directory
# This script will add numbers and padding to the beginning of the filename
# Unless there are already 4 numbers at the beginning, then it will skip them
# This one will rename everything with the same basename to keep them in sync
# pcapABCD.pcap ----> 0123-pcapABCD.pcap
# pcapABCD.json ----> 0123-pcapABCD.json
# This script also has issues when filenames have spaces, which is why I put
# quotes around ${filename} in the "prename" call; also, rename might be old
# so I switched to Perl's rename program
#############################################################
#!/bin/bash

cd /data/artifacts/pcaps/replay

# Renaming files to have 4 digits at the beginning, skip if there are already 4
pattern=[0-9][0-9][0-9][0-9]*
j=0
for i in `ls -1 *pcapng`; do
  filename=$(basename "$i")
  filename="${filename%.*}"
  new_j=$(printf %04d $j)
  case ${filename} in
    $pattern)
      echo "skipping $filename"
      ;;
    *)
      # Run prename -n to do a dry-run
      prename -v "s/^/${new_j}-/" "${filename}.*"
      ;;
  esac
  j=$((j+1))
done

# Renaming files to remove 4 digits from the beginning
#j=0
#for i in `ls -1 *.json`; do
#  filename=$(basename "$i")
#  filename="${filename%.*}"
#  # if there are 4 digits on the front, remove them
#  newname=$(echo "$i" | sed 's/^[0-9]{4}-*//' -)
#  echo "i=${i}"
#  echo "newname=${newname}"
#  #mv "$i" "$newname"
#  #rename "s/^/${new_j}-/" ${filename}*
#  j=$((j+1))
#done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
