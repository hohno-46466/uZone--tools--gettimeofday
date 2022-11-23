#!/bin/sh

# gettimeofday

# Last updated: Tue Sep 14 08:47:24 JST 2021

# See also: git@github.com:hohno-46466/uZone--tools--gettimeofday.git

# public domain

DEBUG=N
FORCE=N

TDIFF_FILE=$HOME/etc/gtd-timediff.dat
GUARD_TIME=60

PNAME=$(basename $0)

ntpdate=/usr/sbin/ntpdate
# ntpdate=/usr/local/sbin/ntpdate
# ntpdate=/opt/homebrew/sbin/ntpdate

if [ ! -d $HOME/etc ] ; then mkdir $HOME/etc; fi

td=-1

while [ "x$1" != "x" ]; do
  if [ "x$1" = "x-d" -o "x$1" = "x--debug" ]; then
    DEBUG=Y
  elif [ "x$1" = "x-f" -o "x$1" = "x--force" ]; then
    FORCE=Y
  elif [ "x$1" = "x-h" -o "x$1" = "x--help" ]; then
    echo "$PNAME [-d|--debug] [-f|--force] [-h|--help]"
    exit
  fi
  shift
done


if [ -f ${TDIFF_FILE} ]; then
  z=$(egrep '^[0-9]* [0-9]*' $TDIFF_FILE | head -1)
  if [ "x$z" != "x" ]; then
    set $z
    T1s=$1 # unix time in the TDIFF_FILE
    T1u=$2 # offset in sec in the TDIFF_FILE
    T0s=$(/bin/date +%s) # current time
    td=$(( $T0s - $T1s ))
    [ "x$DEBUG" = "xY" ] && echo "DEBUG: ($z) -> ($T1s) ($T1u) || ($T0s) - ($T1s) = ($td)"
  fi
fi

if [ "x$FORCE" = "xN" -a $td -ge 0 -a $td -lt $GUARD_TIME ] ; then
  [ "x$DEBUG" = "xY" ] && echo -n "DEBUG: (1) "
  echo "$T1s $T1u" | tee $TDIFF_FILE
else
  z2=$($ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}')
  z1=$(/bin/date +%s) # z1 must be set after z2 has been set. Because settings z2 takes long time.
  [ "x$DEBUG" = "xY" ] && echo -n "DEBUG: (2) "
  echo "$z1 $z2" | tee $TDIFF_FILE
fi

exit 0
