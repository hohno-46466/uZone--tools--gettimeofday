#! /bin/sh

# set -x
ntpdate=/usr/sbin/ntpdate
# ntpdate=/usr/local/sbin/ntpdate
# ntpdate=/opt/homebrew/sbin/ntpdate
echo "$($ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}') $(/bin/date +%s)" | awk '{print $2, $1}'
