/*
 * setitimer.c - simple use of the interval timer
 */

#include <sys/time.h>		/* for setitimer */
#include <unistd.h>		/* for pause */
#include <signal.h>		/* for signal */

#define INTERVAL 1000


void PrintHelloWorld(void);

int main(int argc, char *argv[]) {

  struct itimerval it_val;	/* for setting itimer */

  if (signal(SIGALRM, (void (*)(int)) PrintHelloWorld) == SIG_ERR) {
    perror("Unable to catch SIGALRM");
    exit(1);
  }

  it_val.it_value.tv_sec =     INTERVAL/1000;
  it_val.it_value.tv_usec =    (INTERVAL*1000) % 1000000;	
  it_val.it_interval = it_val.it_value;
  if (setitimer(ITIMER_REAL, &it_val, NULL) == -1) {
    perror("error calling setitimer()");
    exit(1);
  }

  while (1) 
    pause();

}

/*
 * DoStuff
 */
void PrintHelloWorld(void) {

  printf("Hello World!\n");

}
