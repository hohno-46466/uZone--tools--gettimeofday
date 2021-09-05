#! /bin/sh

TDIFF_FILE=$HOME/etc/timediff
DEBUG=N

x=-1

if [ "x$1" = "x-d" -o "x$1" = "x--debug" ]; then
  DEBUG=Y
fi

if [ -f ${TDIFF_FILE} ]; then
  z=$(egrep '^[0-9]* [0-9]*' $TDIFF_FILE | head -1)
  if [ "x$z" != "x" ]; then
    set $z
    z1=$1 # unix time
    z2=$2 # offset in sec
    t1=$(/bin/date +%s)
    t0=$(( $t1 - $z1 ))
    [ "x$DEBUG" = "xY" ] && echo "DEBUG: ($z) -> ($z1) ($z2) || ($t1) - ($z1) = ($t0)"
  fi
fi

if [ $t0 -ge 0 -a $t0 -lt 30 ] ; then
  [ "x$DEBUG" = "xY" ] && echo -n "(1) "
  echo "$z1 $z2" | tee $TDIFF_FILE
else
  z2=$(/usr/sbin/ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}')
  z1=$(/bin/date +%s) # z1 must be set after z2 is ready
  [ "x$DEBUG" = "xY" ] && echo -n "(2) "
  echo "$z1 $z2" | tee $TDIFF_FILE
fi

