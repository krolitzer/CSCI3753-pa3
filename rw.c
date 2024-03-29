/*
 * File: rw.c
 * Author: Chris Costello, Andy Sayler
 * Project: CSCI 3753 Programming Assignment 3
 * Create Date: 2012/03/19
 * Modify Date: 2014/03/24
 * Description: A small i/o bound program to copy N bytes from an input
 *              file to an output file. May read the input file multiple
 *              times if N is larger than the size of the input file.
 */

/* Include Flags */
#define _GNU_SOURCE

/* System Includes */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sched.h>
#include <math.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
/* Local Defines */
#define MAXFILENAMELENGTH 80
#define DEFAULT_INPUTFILENAME "rwinput"
#define DEFAULT_OUTPUTFILENAMEBASE "rwoutput"
#define DEFAULT_BLOCKSIZE 2048*128
#define DEFAULT_TRANSFERSIZE 2048*100*128
#define USAGE "USAGE: <#Processes> <SCHEDULER> (optional ->) <#Bytes to Write to Output File> <Block Size> <Input Filename> <Output Filename>"

int main(int argc, char* argv[]){

	int rv;
	int inputFD;
	int outputFD;
	char inputFilename[MAXFILENAMELENGTH];
	char outputFilename[MAXFILENAMELENGTH];
	char outputFilenameBase[MAXFILENAMELENGTH];

	ssize_t transfersize = 0;
	ssize_t blocksize = 0; 
	char* transferBuffer = NULL;
	ssize_t buffersize;

	ssize_t bytesRead = 0;
	ssize_t totalBytesRead = 0;
	int totalReads = 0;
	ssize_t bytesWritten = 0;
	ssize_t totalBytesWritten = 0;
	int totalWrites = 0;
	int inputFileResets = 0;

	pid_t pid;
	int k;
	int processes;
	
	int policy;
	struct sched_param param;


	/* Process program arguments to select run-time parameters */
	/* Set supplied transfer size or default if not supplied */
	if(argc < 2) {
		printf("%s\n", USAGE);
		exit(EXIT_FAILURE);
	} else {
		processes = atoi(argv[1]);
		if(processes < 1){
			fprintf(stderr, "Need more processes\n");
			exit(EXIT_FAILURE);
		} 
	}

	/* Set policy if supplied */
	if(argc < 3){
		policy = SCHED_OTHER;
	} else {
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

	if(argc < 4){
		transfersize = DEFAULT_TRANSFERSIZE;
	}
	else{
		transfersize = atol(argv[3]);
		if(transfersize < 1){
			fprintf(stderr, "Bad transfersize value\n");
			exit(EXIT_FAILURE);
		}
	}
	/* Set supplied block size or default if not supplied */
	if(argc < 5){
		blocksize = DEFAULT_BLOCKSIZE;
	}
	else{
		blocksize = atol(argv[4]);
		if(blocksize < 1){
			fprintf(stderr, "Bad blocksize value\n");
			exit(EXIT_FAILURE);
		}
	}
	 /* Set supplied input filename or default if not supplied */
	if(argc < 6){
		if(strnlen(DEFAULT_INPUTFILENAME, MAXFILENAMELENGTH) >= MAXFILENAMELENGTH){
			fprintf(stderr, "Default input filename too long\n");
			exit(EXIT_FAILURE);
		}
		strncpy(inputFilename, DEFAULT_INPUTFILENAME, MAXFILENAMELENGTH);
	}
	else{
		if(strnlen(argv[5], MAXFILENAMELENGTH) >= MAXFILENAMELENGTH){
			fprintf(stderr, "Input filename too long\n");
			exit(EXIT_FAILURE);
		}
		strncpy(inputFilename, argv[5], MAXFILENAMELENGTH);
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
	
	char filename[20];
  	sprintf(filename, "./outputFiles/test%d.txt", pid);

	strncpy(outputFilenameBase, filename, MAXFILENAMELENGTH);

	/* Confirm blocksize is multiple of and less than transfersize*/
	if(blocksize > transfersize){
		fprintf(stderr, "blocksize can not exceed transfersize\n");
		exit(EXIT_FAILURE);
	}
	if(transfersize % blocksize){
		fprintf(stderr, "blocksize must be multiple of transfersize\n");
		exit(EXIT_FAILURE);
	}

	/* Allocate buffer space */
	buffersize = blocksize;
	if(!(transferBuffer = malloc(buffersize*sizeof(*transferBuffer)))){
		perror("Failed to allocate transfer buffer");
		exit(EXIT_FAILURE);
	}

	/* Open Input File Descriptor in Read Only mode */
	if((inputFD = open(inputFilename, O_RDONLY | O_SYNC)) < 0){
		perror("Failed to open input file");
		exit(EXIT_FAILURE);
	}

	/* Open Output File Descriptor in Write Only mode with standard permissions*/
	rv = snprintf(outputFilename, MAXFILENAMELENGTH, "%s-%d",
			outputFilenameBase, getpid());    
	if(rv > MAXFILENAMELENGTH){
		fprintf(stderr, "Output filenmae length exceeds limit of %d characters.\n",
				MAXFILENAMELENGTH);
		exit(EXIT_FAILURE);
	}
	else if(rv < 0){
		perror("Failed to generate output filename");
		exit(EXIT_FAILURE);
	}
	if((outputFD =
				open(outputFilename,
					O_WRONLY | O_CREAT | O_TRUNC | O_SYNC,
					S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH)) < 0){
		perror("Failed to open output file");
		exit(EXIT_FAILURE);
	}

	/* Print Status */
	fprintf(stdout, "Reading from %s and writing to %s\n",
			inputFilename, outputFilename);

	/* Read from input file and write to output file*/
	do{
		/* Read transfersize bytes from input file*/
		bytesRead = read(inputFD, transferBuffer, buffersize);
		if(bytesRead < 0){
			perror("Error reading input file");
			exit(EXIT_FAILURE);
		}
		else{
			totalBytesRead += bytesRead;
			totalReads++;
		}

		/* If all bytes were read, write to output file*/
		if(bytesRead == blocksize){
			bytesWritten = write(outputFD, transferBuffer, bytesRead);
			if(bytesWritten < 0){
				perror("Error writing output file");
				exit(EXIT_FAILURE);
			}
			else{
				totalBytesWritten += bytesWritten;
				totalWrites++;
			}
		}
		/* Otherwise assume we have reached the end of the input file and reset */
		else{
			if(lseek(inputFD, 0, SEEK_SET)){
				perror("Error resetting to beginning of file");
				exit(EXIT_FAILURE);
			}
			inputFileResets++;
		}
		/* Calculate pi real quick */


	} while(totalBytesWritten < transfersize);

	/* Output some possibly helpfull info to make it seem like we were doing stuff */
	fprintf(stdout, "Read:    %zd bytes in %d reads\n",
			totalBytesRead, totalReads);
	fprintf(stdout, "Written: %zd bytes in %d writes\n",
			totalBytesWritten, totalWrites);
	fprintf(stdout, "Read input file in %d pass%s\n",
			(inputFileResets + 1), (inputFileResets ? "es" : ""));
	fprintf(stdout, "Processed %zd bytes in blocks of %zd bytes\n",
			transfersize, blocksize);

	/* Free Buffer */
	free(transferBuffer);

	/* Delete the output file*/
	if(remove(outputFilename)){
		perror("Failed to delete the output file");
		exit(EXIT_FAILURE);
	}
	/* Close Output File Descriptor */
	if(close(outputFD)){
		perror("Failed to close output file");
		exit(EXIT_FAILURE);
	}

	/* Close Input File Descriptor */
	if(close(inputFD)){
		perror("Failed to close input file");
		exit(EXIT_FAILURE);
	}

	return EXIT_SUCCESS;
}
