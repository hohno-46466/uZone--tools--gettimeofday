#! /bin/sh

echo "$(/usr/sbin/ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}') $(/bin/date +%s)" | awk '{print $2, $1}'
