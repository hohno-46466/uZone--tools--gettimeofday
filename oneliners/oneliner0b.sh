#! /bin/sh

echo "export gtdOffset=$(/usr/sbin/ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}')"