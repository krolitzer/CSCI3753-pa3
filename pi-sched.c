/*
 * File: pi-sched.c
 * Author: Chris, Costello Andy Sayler
 * Project: CSCI 3753 Programming Assignment 3
 * Create Date: 2012/03/07
 * Modify Date: 2014/03/24
 * Description:
 * 	This file contains a simple program for statistically
 *      calculating pi using a specific scheduling policy.
 */

/* Local Includes */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <errno.h>
#include <sched.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define DEFAULT_ITERATIONS 10000000
#define RADIUS (RAND_MAX / 2)
#define USAGE "USAGE: <#processes> <Scheduler>"

inline double dist(double x0, double y0, double x1, double y1){
	return sqrt(pow((x1-x0),2) + pow((y1-y0),2));
}

inline double zeroDist(double x, double y){
	return dist(0, 0, x, y);
}

int main(int argc, char* argv[]){

	long i;
	long iterations;
	struct sched_param param;
	int policy, processes;
	double x, y;
	double inCircle = 0.0;
	double inSquare = 0.0;
	double pCircle = 0.0;
	double piCalc = 0.0;
	pid_t pid;
	int k;

	iterations = DEFAULT_ITERATIONS;
	/* Set default policy if not supplied */
	/* Set iterations if supplied */
	if(argc > 1){
		processes = atoi(argv[1]);
		if(processes < 1){
			fprintf(stderr, "Need more processes\n");
			exit(EXIT_FAILURE);
		}
	} else {
		fprintf(stderr, "%s\n", USAGE);
		exit(EXIT_FAILURE);
	}
	/* Set policy if supplied */
	if(argc > 2){
		if(!strcmp(argv[2], "SCHED_OTHER")){
			policy = SCHED_OTHER;
		}
		else if(!strcmp(argv[2], "SCHED_FIFO")){
			policy = SCHED_FIFO;
		}
		else if(!strcmp(argv[2], "SCHED_RR")){
			policy = SCHED_RR;
		}
		else{
			fprintf(stderr, "Unhandeled scheduling policy\n");
			exit(EXIT_FAILURE);
		}
	}

	/* Set process to max prioty for given scheduler */
	param.sched_priority = sched_get_priority_max(policy);

	/* Set new scheduler policy */
	fprintf(stdout, "Current Scheduling Policy: %d\n", sched_getscheduler(0));
	fprintf(stdout, "Setting Scheduling Policy to: %d\n", policy);
	if(sched_setscheduler(0, policy, &param)){
		perror("Error setting scheduler policy");
		exit(EXIT_FAILURE);
	}
	fprintf(stdout, "New Scheduling Policy: %d\n", sched_getscheduler(0));

	// Fork the number of processes.
 
	for(k = 0; k < processes; k++) {
		pid = fork();
		if(pid == 0) {
			break; 
		}
	}
	if(pid == 0) {
		printf("New Process %d\n", getpid());
	} else {
		printf("Parent Process\n"); 
		while ((pid = waitpid(-1, NULL, 0))) {
			if (errno == ECHILD) {
				break;
			}
		}
		printf("Done with all processes\n"); 
		return 0; 
	}

	/* Calculate pi using statistical methode across all iterations*/
	for(i=0; i<iterations; i++){
		x = (random() % (RADIUS * 2)) - RADIUS;
		y = (random() % (RADIUS * 2)) - RADIUS;
		if(zeroDist(x,y) < RADIUS){
			inCircle++;
		}
		inSquare++;
	}

	/* Finish calculation */
	pCircle = inCircle/inSquare;
	piCalc = pCircle * 4.0;

	/* Print result */
	fprintf(stdout, "pi = %f\n", piCalc);

	return 0;
}
