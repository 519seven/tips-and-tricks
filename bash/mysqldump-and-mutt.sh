Bash Script Sample for Backing Up MySQL

#!/bin/bash
HDBS="db1 db2 db3 db4"
BAK="/sout/email"
[ ! -d $BAK ] && mkdir -p $BAK || :
/bin/rm $BAK/*
NOW=$(date +"%d-%m-%Y")
ATTCH="/sout/backup.$NOW.tgz"
[ -f $ATTCH ] && /bin/rm $ATTCH  || :
MTO="you@yourdomain.com"
for db in $HDBS
do
 FILE="$BAK/$db.$NOW-$(date +"%T").gz"
 mysqldump -u admin -p'password' $db | gzip -9 > $FILE
done
tar -jcvf $ATTCH $BAK
 mutt -s "DB $NOW" -a $ATTCH $MTO <<EOF
DBS $(date)
EOF
[ "$?" != "0" ] &&  logger "$0 - MySQL Backup failed" || :
