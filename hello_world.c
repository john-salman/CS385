/*
 * setitimer.c - simple use of the interval timer
 */

#include <sys/time.h>		/* for setitimer */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>		/* for pause */
#include <signal.h>		/* for signal */
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <stdint.h>

#define INTERVAL 1000 //ms between function calls

#define CPU 0
#define REG 16

void PrintHelloWorld(int sig) {

  uint64_t data;
  int fd;
  char *pat;
  int width;
  char msr_file_name[64];


  sprintf(msr_file_name, "/dev/cpu/%d/msr", CPU);
  fd = open(msr_file_name, O_RDONLY);
  if (fd < 0) {
    if (errno == ENXIO) {
      fprintf(stderr, "rdmsr: No CPU %d\n", CPU);
      exit(2);
    } else if (errno == EIO) {
      fprintf(stderr, "rdmsr: CPU %d doesn't support MSRs\n",
        CPU);
      exit(3);
    } else {
      perror("rdmsr: open");
      exit(127);
    }
  }

  if (pread(fd, &data, sizeof data, REG) != sizeof data) {
    if (errno == EIO) {
      fprintf(stderr, "rdmsr: CPU %d cannot read ", REG);
      exit(4);
    } else {
      perror("rdmsr: pread");
      exit(127);
    }
  }

  close(fd);

  printf("DATA: %ld\n", data);
  fflush(NULL);
}





int main(int argc, char *argv[]) {

  struct itimerval settings;	/* for setting itimer */

  // if (signal(SIGALRM, (void (*)(int)) PrintHelloWorld) == SIG_ERR) {
  //   perror("Unable to catch SIGALRM");
  //   exit(1);
  // }
  if(signal(SIGALRM, PrintHelloWorld) == SIG_ERR) {
    fprintf(stderr, "Unable to catch SIGALRM\n");
  }


  settings.it_value.tv_sec = INTERVAL/1000;
  settings.it_value.tv_usec = (INTERVAL*1000) % 1000000;	
  
  settings.it_interval = settings.it_value;
  

  if (setitimer(ITIMER_REAL, &settings, NULL) == -1) {
    perror("error calling setitimer()");
    exit(1);
  }

  while (1); 
}
