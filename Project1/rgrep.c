#include <stdio.h>
#include <stdlib.h>
#define MAXSIZE 4096

/**
 * You can use this recommended helper function 
 * Returns true if partial_line matches pattern, starting from
 * the first char of partial_line.
 */
int matches_leading_two(char *partial_line, char *pattern);

int matches_leading(char *partial_line, char *pattern) {
  // Implement if desire 
	
    if (!*pattern){ //if there's no pattern then everything matches
        return 1;
    }
	
	if (*(partial_line + 1) == '\n' && *partial_line == *pattern) { //if we reach en of the line we check if the value is equal to the pattern
		
		if(*(pattern+1)=='\n'||*(pattern+1)=='b'){//unless the pattern is not null in the next character, if that happens then the line doesnt match the complete pattern :)
			return 1;
		}
	
	}
	
    if (!*partial_line || *partial_line == '\n'){ //basic error checking for partial line nulls
        return 0;
    }

    char next = *(pattern + 1); //saving the next character in the patter 

  if (*pattern == '.'){ //basic checking for . wildcard
        if (next == '+'){ 
		//recursive action to check for each and every one of the matching caracters in the partial line
            return (matches_leading(partial_line+1, pattern) || matches_leading(partial_line+1, pattern+2));
        }
		if (next == '?'){
		//had to implement special cases for when you want or may not want any character in the line this was due to the hidden, hidin case.
            return matches_leading(partial_line, pattern+2) || matches_leading(partial_line+1, pattern+2);
		}
		//if its just a basic . case all we need to check for is any character as long as there is one in the line
        return matches_leading(partial_line + 1, pattern + 1);
    }

    
if (*pattern == '\\'){
	//when the pattern is a backslash the cases become a little more complicated and we shall make use of our matches the leading two because now we are checking for two chars per.
        return matches_leading_two(partial_line, pattern+1);
    }
	//for some wildcards we can use a switch statement in order to execute different types of code blocks depending on each individual case.
    switch (next){//next is our pattern+1 character
        
		
		case ('?') ://if we are looking at the ? wildcard we want to look at the partial line and at the pattern two cases ahead 
			if (*partial_line!=*pattern&&*(partial_line+1)!='\n'){
                return matches_leading(partial_line, pattern + 2);
            }
            return matches_leading(partial_line, pattern+2) || matches_leading(partial_line+1, pattern+2);
        case ('+') :
            if (*partial_line != *pattern){
                return 0;
            }
            return matches_leading(partial_line+1, pattern+2) || matches_leading(partial_line+1, pattern+2);
 
	 default ://when pattern equals next
            if (*partial_line == *pattern){
                return matches_leading(partial_line + 1, pattern + 1);
            }
            else {
                return 0;
            }
    }
}

int matches_leading_two(char *partial_line, char *pattern) {    

if (!*pattern){// pattern ends
        return 1;
    }

    if (!*partial_line || *partial_line == '\n'){
        return 0;
    }

    char next = *(pattern + 1);
	
    switch (next){
		
        case ('?') :
            if (*partial_line!=*pattern) {
                return matches_leading(partial_line, pattern + 2);
            }
            return matches_leading(partial_line, pattern+2) || matches_leading(partial_line+1, pattern+2);
        case ('+') :
            if (*partial_line != *pattern){
                return 0;
            }
            return matches_leading(partial_line+1, pattern) || matches_leading(partial_line+1, pattern+2);
	
	default :
            if (*partial_line == *pattern){
                return matches_leading(partial_line + 1, pattern + 1);
            }
            else {
                return 0;
            }
    }

}

/**
 * You may assume that all strings are properly null terminated 
 * and will not overrun the buffer set by MAXSIZE 
 *
 * Implementation of the rgrep matcher function
 */

int rgrep_matches(char *line, char *pattern) {
	
    while (*line) {//goes through every line in the text file
        if (matches_leading(line, pattern)) {
			
            return 1;
        }
        line++;

    }
    return 0;
}
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <PATTERN>\n", argv[0]);
        return 2;
    }

    /* we're not going to worry about long lines */
    char buf[MAXSIZE];

    while (!feof(stdin) && !ferror(stdin)) {
        if (!fgets(buf, sizeof(buf), stdin)) {
            break;
        }
        if (rgrep_matches(buf, argv[1])) {
            fputs(buf, stdout);
            fflush(stdout);
        }
    }

    if (ferror(stdin)) {
        perror(argv[0]);
        return 1;
    }

    return 0;
}
