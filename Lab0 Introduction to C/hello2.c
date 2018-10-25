#include <stdio.h> 
int main()

{

char str1[50], str2[30];

printf("Please enter your name:");
scanf("%[^\n]s", str1);

 printf("Welcome to CSE031 %s\n", str1);

return (0);

}

