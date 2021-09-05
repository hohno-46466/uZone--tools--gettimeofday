#! /bin/sh
 
gtdOffset=${1-$gtdOffset}

while [ 1 ]; do  while [ "x$x" = "x$y" ]; do sleep 0.02; set $(gtd -d $gtdOffset); y=$8; done; gtd -d $gtdOffset; set $(gtd -d $gtdOffset); x=$8; sleep 0.5; done
