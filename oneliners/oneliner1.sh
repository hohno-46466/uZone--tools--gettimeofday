#! /bin/sh
 
# Build gtd command with -D DEBUG option

 while [ 1 ]; do  while [ "x$x" = "x$y" ]; do sleep 0.01; y=$(gtd $gtdToffset | awk '{print $8}'); done; gtd $gtdToffset; x=$(gtd $gtdToffset | awk '{print $8}'); done
