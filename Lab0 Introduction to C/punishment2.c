#include <stdio.h>

int main()

{
int x, y; 

printf("Enter the number of lines for the punishment:");

scanf("%d", &x);

if (x<0) {
printf("You entered an incorrect value for the number of lines!");
 return (0);
}
 
printf("Enter the line for which we want to make a typo:");

scanf("%d", &y); 

if (y>x || y<0) {

printf("You entered an incorrect value for the line typo!");
 return (0);
}



for(int i = 0; i<=x; i++) {

  if (i == y){
printf("C programming language is the bet!\n");
  }
 else 
printf("C programming language is the best!\n");


 }
return(0);

}






