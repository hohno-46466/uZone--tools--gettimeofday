#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/time.h>
#include <math.h>

struct timeval tv;
struct timezone tz;

// #define DEBUG

#ifdef DEBUG
bool debugFlag = true;
# else // DEBUG
bool debugFlag = false;
#endif // DEBUG

#define MINIBUFFLEN (32)
float fx;

void exit_after_help() {
  fprintf(stderr, "usage: gettimeofday [-h|--help] [offset]\n");
  exit(1);
}

int main(int argc, char **argv) {

  if (argc == 1) {
    if (debugFlag) {
      printf("Debug: no args\n");
    } 

  } else if ((argv[1][0] == '-') && (argv[1][1] == 'h')) {
    exit_after_help();
    /*NOTREACHED*/

  } else if ((argv[1][0] == '-') && (argv[1][1] == '-')) {
    exit_after_help();
    /*NOTREACHED*/

  } else if (strlen(argv[1]) < MINIBUFFLEN) {
    fx = 0.0;
    sscanf(argv[1], "%f", &fx);
    // printf("c: [%f]\n", fx);
  }

  int retval = 0;
  if ((retval = gettimeofday(&tv, &tz)) != 0) {
	exit (retval);
  }

  if (debugFlag) {
    printf("DEBUG: %ld %6ld ", tv.tv_sec, tv.tv_usec);
  }

  int offset1 = (int)fabsf(fx);
  int offset2 = (fabsf(fx)-offset1) * 1000000;

  if (fx > 0.0) {
    tv.tv_sec  += offset1;
    tv.tv_usec += offset2;
    if (tv.tv_usec > 1000000) {  // tv.tv_usec can not be greater than 2000000
      tv.tv_sec  += 1;
      tv.tv_usec %= 1000000;
    }

  } else if (fx < 0.0) {
    tv.tv_sec  -= offset1;
    tv.tv_usec -= offset2;  // tv.tv_usec can not be less than -2000000
    if (tv.tv_usec < 0) {
      tv.tv_sec  -= 1;
      tv.tv_usec = 1000000 - (abs(tv.tv_usec) % 1000000);
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
