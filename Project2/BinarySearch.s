.data 

original_list: .space 100 
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: \n"
str2: .asciiz "Content of original list: "
str3: .asciiz "Enter a key to search for: "
str4: .asciiz "Content of sorted list: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"
newLine: .asciiz "\n"


.text 

#This is the main program.
#It first asks user to enter the size of a list.
#It then asks user to input the elements of the list, one at a time.
#It then calls printList to print out content of the list.
#It then calls inSort to perform insertion sort
#It then asks user to enter a search key and calls bSearch on the sorted list.
#It then prints out search result based on return value of bSearch
main: 
	addi $sp, $sp -8
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	#read size of list from user
	syscall
	move $s0, $v0
	move $t0, $0
	la $s1, original_list
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	#read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	move $a0, $s1
	move $a1, $s0
	
	jal inSort	#Call inSort to perform insertion sort in original list
	
	sw $v0, 4($sp)
	li $v0, 4 
	la $a0, str2 
	syscall 
	la $a0, original_list
	move $a1, $s0
	jal printList	#Print original list
	li $v0, 4 
	la $a0, str4 
	syscall 
	lw $a0, 4($sp)
	jal printList	#Print sorted list
	
	li $v0, 4 
	la $a0, str3 
	syscall 
	li $v0, 5	#read search key from user
	syscall
	move $a3, $v0
	lw $a0, 4($sp)
	jal bSearch	#call bSearch to perform binary search
	
	beq $v0, $0, notFound
	li $v0, 4 
	la $a0, strYes 
	syscall 
	j end
	
notFound:
	li $v0, 4 
	la $a0, strNo 
	syscall 
end:
	lw $ra, 0($sp)
	addi $sp, $sp 8
	li $v0, 10 
	syscall
	
	
#printList takes in a list and its size as arguments. 
#It prints all the elements in one line.
printList:
	#Your implementation of printList here	
addi $sp, $sp, -4
move $t0, $0
sw $a0, 0($sp)
move $t1, $a0

loop1: 


li $v0, 1
lw $a0, 0($t1)
syscall

li $v0, 4 
la $a0, newLine
syscall

addi $t1, $t1, 4
addi $t0, $t0, 1
bne $t0, $a1, loop1

lw $a0, 0($sp)
addi $sp, $sp, 4



	jr $ra
	
	
#inSort takes in a list and it size as arguments. 
#It performs INSERTION sort in ascending order and returns a new sorted list
#You may use the pre-defined sorted_list to store the result
inSort:
	#Your implementation of inSort here
	
	#initializing 
	 
	addi $t1, $0, 1
	lw $t0, 0($a0) 
	sw $t0, sorted_list
	la $t0, sorted_list
	
	bne $t1, $a1, loop2check
	
	j loopend
	
	loop2check: 
	
	addi $t2, $t1, -1 #value of i-1 = j 
	sll $t3, $t1, 2       
	add $t3, $t3, $a0 
	lw $t3, 0($t3) 
	  
	
	blt $t2, 0, loopend
	sll $t4, $t2, 2
	add $t4, $t0, $t4
	lw $t4, 0($t4)
	blt $t4, $t3, loopend
	beq $t4, $t3, loopend 
	
	
	
	
	
	
	
	loop3swap: 
	addi $t5, $t2, 1
	sll $t5, $t5, 2 
	add $t6, $t0, $t5 
	sll $t4, $t2, 2 
	add $t4, $t0, $t4
	lw $t4, 0($t4)
	sw $t4, 0($t6) 
	
	addi $t2, $t2, -1 
	
	blt $t2, 0, loopend
	sll $t4, $t2, 2 
	add $t4, $t4, $t0 
	lw $t4, 0($t4) 
	bgt $t4, $t3, loop3swap
	

	
	loopend:
	
	addi $t5, $t2, 1 
	sll $t5, $t5, 2 
	add $t6, $t0, $t5
	sw $t3 0($t6)
	
	addi $t1, $t1, 1
	
	
	bne $t1, $a1, loop2check
	
	loopend2: 
	move $v0, $t0
	jr $ra
	
	

	
	
	
#bSearch takes in a list, its size, and a search key as arguments.
#It performs binary search RECURSIVELY to look for the search key.
#It will return a 1 if the key is found, or a 0 otherwise.
#Note: you MUST NOT use iterative approach in this function.

bSearch: #(A[], length, key)
	#$a0 = A[]
	#$a1 = length
	#$a2 = key
	
	
	addi $a1, $a1, -1 #n = length-1
	
recurBSearch: #Declares and searches for the value to the left first
	#$a0 = A[]
	#$a1 = n
	#$a2 = key
	#$t0 = mid
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	bltz $a1, notfound #if n < 0 return 0
	
	#midpoint
	srl $t0, $a1, 1
	
	#A[mid] == key, found
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	lw $t1, 0($t1)
	beq $t1, $a3, found
	
	#A[mid] < key 
	bgt $t1, $a3, greaterthan
	add $t1, $t0, 1
	sll $t1, $t1, 2
	add $a0, $a0, $t1
	
	sub $a1, $a1, $t0
	sub $a1, $a1, 1
	
	
	jal recurBSearch
	
	
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra
	
greaterthan: #A[mid] > key 
	sub $a1, $a1, $t0
	subi $a1, $a1, 1
	
	jal recurBSearch
	
	
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra
	
	
found: #return found
	addi $v0, $0, 1
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra
	
	
	
notfound: #return not found
	add $v0, $0, $0
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra
	
