#!/bin/sh

# set -x
ntpdate=/usr/sbin/ntpdate
# ntpdate=/usr/local/sbin/ntpdate
# ntpdate=/opt/homebrew/sbin/ntpdate
echo "export gtdOffset=$($ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}')"
