#! /bin/sh

ntpdate -q ntp.nict.jp | tail -1 | awk '{print $10}'
