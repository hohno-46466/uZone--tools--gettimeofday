#! /bin/sh

# gettimeofday

# See also: git@github.com:hohno-46466/uZone--tools--gettimeofday.git

DEBUG=N

TDIFF_FILE=$HOME/etc/gtd-timediff.dat
GUARD_TIME=60

td=-1

if [ "x$1" = "x-d" -o "x$1" = "x--debug" ]; then
  DEBUG=Y
fi

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

if [ $td -ge 0 -a $td -lt $GUARD_TIME ] ; then
  [ "x$DEBUG" = "xY" ] && echo -n "DEBUG: (1) "
  echo "$T1s $T1u" | tee $TDIFF_FILE
else
  z2=$(/usr/sbin/ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}')
  z1=$(/bin/date +%s) # z1 must be set after z2 has been set. Because settings z2 takes long time.
  [ "x$DEBUG" = "xY" ] && echo -n "DEBUG: (2) "
  echo "$z1 $z2" | tee $TDIFF_FILE
fi

exit 0
