.data
.word


.text

main: move $t0, $s0
      move $t1, $s1
      add  $t2, $t0, $t1
      add  $t3, $t2, $t1
      add  $t4, $t2, $t3
      add  $t5, $t4, $t3
      add  $t6, $t4, $t5
       add  $t7, $t6, $t5
      
finish: addi $a0, $t0, 0 
	li $v0, 1
	syscall
	li $v0, 10
	syscall    
      