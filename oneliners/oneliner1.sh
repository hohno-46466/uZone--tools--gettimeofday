#! /bin/sh
 
# Build gtd command with -D DEBUG option

gtdToffset=${1-$gtdToffset}

while [ 1 ]; do  while [ "x$x" = "x$y" ]; do sleep 0.01; set $(gtd $gtdToffset); y=$8; done; gtd $gtdToffset; set $(gtd $gtdToffset); x=$8; sleep 0.5; done
