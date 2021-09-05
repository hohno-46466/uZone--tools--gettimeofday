#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/time.h>
#include <math.h>

struct timeval tv;
struct timezone tz;

// #define DEBUG
/*
#ifdef DEBUG
bool debugFlag = true;
# else // DEBUG
bool debugFlag = false;
#endif // DEBUG
*/

#define MINIBUFFLEN (32)

bool debugFlag = false;
float fx = 0.0;
char *pname = NULL;

// ---------------------------------------------------------

void exit_after_help() {
  fprintf(stderr, "usage: %s [-h|--help] [-d] [offset]\n", pname);
  exit(1);
}


// ---------------------------------------------------------
//
int main(int argc, char **argv) {

  pname = argv[0];

  for(int i = 1; i < argc; i++) {

    if ((argv[i][0] == '-') && (argv[i][1] == 'h')) {
      // -h : show help then exit
      exit_after_help();
      /*NOTREACHED*/
  
    } else if ((argv[i][0] == '-') && (argv[i][1] == 'd')) {
      // -d : debug mode
      debugFlag = true;

    } else if ((argv[i][0] == '-') && (argv[i][1] == '-')) {
      // No long options are supported
      exit_after_help();
      /*NOTREACHED*/
  
    } else if (strlen(argv[i]) < MINIBUFFLEN) {
      if (sscanf(argv[i], "%f", &fx) != 1) {
        fx = 0.0;
      }
    }
  }

  int retval = 0;
  if ((retval = gettimeofday(&tv, &tz)) != 0) {
    exit (retval);
  }

  if (debugFlag) {
    printf("DEBUG: %ld %6ld ", tv.tv_sec, tv.tv_usec);
  }

  int offset1 = (int)fabsf(fx);
  int offset2 = (fabsf(fx) - offset1) * 1000000; // 0 <= offset2 < 1000000

  if (fx > 0.0) {
    tv.tv_sec  += offset1;
    tv.tv_usec += offset2;
    if (tv.tv_usec >= 1000000) {  // in this case, 1000000 <= tv.tv_usec < 2000000
      tv.tv_sec  += 1;
      tv.tv_usec -= 1000000;
    }

  } else if (fx < 0.0) {
    tv.tv_sec  -= offset1;
    tv.tv_usec -= offset2;
    if (tv.tv_usec < 0) { // in this case, -1000000 < tv.tv_usec < 0
      tv.tv_sec  -= 1;
      // tv.tv_usec = 1000000 - (abs(tv.tv_usec) % 1000000);
      tv.tv_usec += 1000000;
    }

  } else {
    // do nothing
  }

  if (debugFlag) {
    printf("%f %d %d -> ", fx, offset1, offset2);
  }

  printf("%ld %6ld\n", tv.tv_sec, tv.tv_usec);

  exit (0);
}
