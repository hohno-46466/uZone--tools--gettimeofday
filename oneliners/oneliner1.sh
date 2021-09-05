#! /bin/sh
 
gtdToffset=${1-$gtdToffset}

while [ 1 ]; do  while [ "x$x" = "x$y" ]; do sleep 0.01; set $(gtd -d $gtdToffset); y=$8; done; gtd -d $gtdToffset; set $(gtd -d $gtdToffset); x=$8; sleep 0.5; done
