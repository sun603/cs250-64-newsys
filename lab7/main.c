#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main() {        
  int start_index, end_index;        
  char *in_string;         
  char *out_string;    /* Code to receive inputs from user */ 
  //in_string = (char*)malloc(sizeof(char)*200);
  char in[100];
  in_string = in;
  printf("Enter a string: ");
  scanf("%s",in_string);
  printf("Enter the start index:");
  scanf("%d",&start_index);
  printf("Enter the end index:");
  scanf("%d",&end_index);
  /* Code to print the sub-string */    
  out_string = (char*)sub_string(in_string, start_index, end_index);    
  printf("The substring of the given string is '%s'\n",out_string);
 
  return 0; 
} 