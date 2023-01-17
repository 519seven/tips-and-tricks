#!/bin/bash

# Bash Script - Bulk Delete Directory Example

# ******************************************************************************
set -e

if [ $# -lt 1 ]; then
  echo 1>&2 "Usage: $0 <fromNum> [<toNum>]"
  exit 1
fi

START=$1
END=$2
BASE_URL=http://my.hudson.org/job/JBoss-AS-5.x-TestSuite-sun15/

doDelete() {
  if curl >/dev/null --fail --silent $1$2/doDelete
  then
    RC=0
    echo "$1$2: deleted"
  else
    RC=$?
    echo "$1$2: failed: $RC"
  fi
  return $RC
}

if [ -z "$END" ]; then
  doDelete $BASE_URL $START
else
  for i in $(seq $START $END); do
    echo $BASE_URL$i/doDelete
    doDelete $BASE_URL $i
  done
fi

# IMPROVED *********************************************************************

set -e

if [ $# -lt 2 ]; then
  echo 1>&2 "Usage: $0 jobname <fromNum> [<toNum>]"
  exit 1
fi

JOBNAME=$1
START=$2
END=$3
BASE_URL="http://somebox/job/${JOBNAME}"

doDelete() {
  if /usr/bin/curl -X POST >/dev/null --silent --fail "${1}/${2}/doDelete"
  then
    RC=0
    echo "$1/$2: deleted"
  else
    RC=$?
    echo "$1/$2: failed: $RC"
  fi
  return $RC
}

if [ -z "$END" ]; then
  doDelete $BASE_URL $START
else
  for i in $(seq $START $END); do
    echo $BASE_URL/$i/doDelete
    doDelete $BASE_URL $i
  done
fi
