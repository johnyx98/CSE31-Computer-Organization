#include <stdio.h>
int main() 

{
int x;

 printf("Enter the number of lines for the punishment:");

scanf("%d", & x);

if (x<0) {
printf("You entered an incorrect value for the number of lines!");

}

for(int i =0; i<=x; i++) {

printf("C programming language is the best!\n" );

}
 return (0);
}
