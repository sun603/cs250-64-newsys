#include <stdio.h>
#include <string.h>
#include <stdlib.h>
char* sub_string(char *in_string,int start_index, int end_index){
	char *out_string;
	out_string = (char*)malloc(sizeof(char)*(100 ));
	strncpy(out_string, (in_string+(start_index-1)),(end_index - start_index+1));
	return out_string;
}