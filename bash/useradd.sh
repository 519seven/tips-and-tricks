#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# conditionals
# getopts
# Linux:
# - useradd
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ADMINDIR=/home/admin
ADMINGROUP=admin
BASEDIR=/home
USRSHELL=/bin/bash

USERNAME=""
NORMAL=""
ADMIN=""
ARGS=""
TRUE=0
FALSE=1

usage(){
    echo "Usage: $0 {-a|-n} [ -c GECOS ] {-u username}"
    echo ""
    echo " -a          : Create an admin account"
    echo " -n          : Create a normal account"
    echo " -c GECOS    : Set the GECOS field for the new user account"
    echo " -u username : Set the LOGIN name"
    echo ""
    exit 1 
}

isUserExits(){
    grep $1 /etc/passwd > /dev/null
    [ $? -eq 0 ] && return $TRUE || return $FALSE
}

createNewUser(){
    /usr/sbin/useradd "$@"
}

while getopts anc:u: option
do
        case "${option}"
        in
                a) ADMIN="TRUE";;
                n) NORMAL="TRUE";;
                c) GECOS=${OPTARG};;
                u) USERNAME=${OPTARG};;
                \?) usage
                    exit 1;;
        esac
done

[ "$USERNAME" == "" ] && usage
[ "$USERNAME" != "" -a "$ADMIN" == ""  -a "$NORMAL" == ""  ] && usage
[ "$ADMIN" == "TRUE"  -a "$NORMAL" == "TRUE"  ] && usage

if [ $(id -u) -ne 0 ] 
then
    echo "You must be root to run this script!"
    exit 2
fi

[ "$GECOS" != "" ] && ARGS="-c $GECOS"

if [ "$ADMIN" == "TRUE" ]
then
    if ( ! isUserExits $USERNAME )
    then 
        createNewUser -s $USRSHELL -g $ADMINGROUP -d $ADMINDIR $ARGS $USERNAME
    else
        echo "Username \"$USERNAME\" exists in /etc/passwd"
        exit 3
    fi
fi

if [ "$NORMAL" == "TRUE" ]
then
    if ( ! isUserExits $USERNAME )
    then 
        createNewUser -m -b $BASEDIR -s $USRSHELL $ARGS $USERNAME
    else
        echo "Username \"$USERNAME\" exists in /etc/passwd"
        exit 3
    fi
fi

exit 0