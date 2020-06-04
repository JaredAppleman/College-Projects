/*
Jared Appleman (alone)
Operating Systems Spring 2020
shell.c
Dr. Diesburg
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <unistd.h>
#include <sys/types.h>

#define True 1
#define False 0

int getInput();
int tokenize(char* userInput,char* lastCommandBuffer);
int execute(char** stringArray,char* userInput);
int waitpid(pid_t pid, int *status, int options);




int main(int argc, char *argvt[]){
  int returnValue;
  
  while(1){
    returnValue = getInput();
    if (returnValue == -1){
      break;}}}

int getInput(){
  char userInput[800];
  char lastCommandBuffer[800];
  int returnValue;
  
  printf("Prompt$ ");
  fgets(userInput,800,stdin);
  //makes a deep copy of userInput since the string will change when tokenized
  strncpy(lastCommandBuffer,userInput,800);
  //calls token with the userInput and a copy of it 
  returnValue = tokenize(userInput,lastCommandBuffer);
  return returnValue;}

int tokenize(char* userInput,char* lastCommandBuffer){
  //make array of strings to pass to execution
  char separator[2] = " ";
  char* token = NULL;
  char* stringArray[10];
  int pointerArrayIndex = 0;
  int arrayIndex = 0;
  char* string;
  int stringLength;
  int returnValue;
  //makes tokes
  token = strtok(userInput, separator);
  stringArray[pointerArrayIndex] = token;
  while (token != NULL){
    pointerArrayIndex = pointerArrayIndex + 1;
    token = strtok(NULL, separator);
    stringArray[pointerArrayIndex] = token;}
  //goes through array of strings, replaces newline character
  //i honestly forget why i needed this, think we talked about it in class
  while (1){
    string = stringArray[arrayIndex];
    stringLength = strlen(string);
    if (string[stringLength-1] == '\n'){
      string[stringLength-1] = '\0';
      break;}
    arrayIndex++;}
  //calls execution with array of tokens (array of strins) and copy of original user input
  returnValue = execute(stringArray,lastCommandBuffer);
  return returnValue;}


int execute(char** stringArray,char* lastCommandBuffer){
  //decides what to execute with tokens
  int returnInt;
  int returnValue;
  int pidArrayIndex;
  char cwd[80];
  char* directory;
  static int pidArrayCounter = 0;
  static int pidArray[5] = {0,0,0,0,0};
  static char lastCommand[800];
  //exit
  if (strncmp(stringArray[0],"exit",5)== 0){
    return -1;}
  //change directory
  else if (strncmp(stringArray[0],"cd",2)== 0){
    /*
    //hardcode to test syntax of chdir stuff
    directory = getenv("HOME");
    printf("%s\n",directory);
    chdir(directory);
    getcwd(cwd,80);
    setenv("PWD",cwd,1);}
    */
    
    //if no arguments for cd...
    if (stringArray[1] == NULL){
	directory = getenv("HOME");
	chdir(directory);
	setenv("PWD",directory,1);
      }
    //if cd has argument
    else{
      returnInt = chdir(stringArray[1]);
      if (returnInt == -1){
	printf("Error: Directory not found :(\n");
      }
      else{
	getcwd(cwd,80);
	setenv("PWD",cwd,1);}
      //sets last command
      strncpy(lastCommand,lastCommandBuffer,800);
      return 0;
    }}
  

  //showpid 
  else if (strncmp(stringArray[0],"showpid",7)== 0){
    for (pidArrayIndex = 0;pidArrayIndex <= 4;pidArrayIndex++){
      printf("%d\n",pidArray[pidArrayIndex]);}
    //sets last command
    strncpy(lastCommand,lastCommandBuffer,800);
    return 0;}

  //last command
  else if (strncmp(stringArray[0],"lc",2)== 0){
    //copies last valid command into buffer
    strncpy(lastCommandBuffer,lastCommand,800);
    //calls tokenize with last valid command and a copy of last valid command
    returnValue = tokenize(lastCommand,lastCommandBuffer);
    return returnValue;}

  //Fork :)
  else {
    pid_t pid = fork();
    //if child...
    if (pid == 0){
      returnInt = execvp(stringArray[0],stringArray);
      if (returnInt == -1){
	printf("Error: Command could not be executed\n");
	return -1;}
    }
    //if parent...
    else {
      pidArray[pidArrayCounter] = pid;
      pidArrayCounter++;
      if (pidArrayCounter >= 5){
	pidArrayCounter = 0;}
      waitpid(-1, NULL,0);
      //sets last command
      strncpy(lastCommand,lastCommandBuffer,800);
      return 0;
    }}
}
