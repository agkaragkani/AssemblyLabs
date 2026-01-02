#LAB 5 
#Eva Pantazi
#Alexandra Gkaragkani



# Data declaration section
#
.data 


# Strings to be printed
#

info:            .asciiz   "\nThis is a program that computes Fibonacci numbers from 0-24!"
message:         .asciiz   "\n\nPlease enter a number in the range 0-24 or -1 to Quit.\n"
wrong_num:       .asciiz   "\nThis number is outside the allowable range.\n"
quit_message: 	 .asciiz   "\nThe program has terminated.\n"
result_message:  .asciiz   "\nThe Fibonacci number F   is: "

ascii:           .space 10


# Assembly language instructions go in text segment
#
.text


# Start of code section
#   
main:


#------------Registers used-----------------

# $t0 -> number from user
# $t1 -> fibonacci number/result
# $t2 -> help pointer that contains $t0 in ascii
# $t3 -> result message to be modified
# $t4 -> stands for Fn-2
# $t5 -> stands for Fn-1 
# $t6 -> counter for recursion in fib()
# $s0 -> has value of 10 for divion
# $s1 -> contains the first digit of 2-digit $t0
# $S2 -> contains the second digit of 2-digit $t0
#------------------------------------------- 




la $t3, result_message			# loads the address of the result message in $t3 register

li $v0, 4                               # prints a message to user that this is a fibonacci-computing program
la $a0, info
syscall



Promt_User:

     # Prints message to get the integer from user

        li $v0, 4             		# system call code for printing string = 4 
        la $a0, message 		# loads address of string to be printed into $a0 
        syscall               		# calls operating system to perform operation # specified in $v0 


     # Reads the number into $t0

        li $v0, 5          		# system call code for reading integer = 5 (read integer) 
	syscall                		# calls operating system to perform operation specified in $v0 
        move $t0, $v0    		# moves number from $v0 to $t0

	
        beq $t0,-1,Quit
        blt $t0, 0, notValid		# conditions that check whether the user's input is in allowable range or not(0 <= t0 <=24).
        bgt $t0, 24, notValid		# if eather condition is true,it jumps to notValid function and prints suitable message.



# Copies number into the stack, to be used as the "n" from fib() 

	addi $sp, $sp, -8		# enlarges the stack, to make room for the number
	sw $t0, 0 ($sp)			# adds number to top of stack
	sw $ra, 4($sp)

	jal fib				# calls fibonacci  function

	lw $t1, 0($sp)			# takes the result from top of stack, stored there by fib()
	lw $ra, 4($sp)			# restore return address
	addi $sp, $sp, 8		# restores stack pointer
	

  
	j convert_to_ASSCI	
 
       





fib:

	lw $t0, 0($sp)			# takes the parameter from top of stack
	addiu $sp, $sp, 4
	       
	bgt $t0, 1, recursion		# condition in which, if the user's input is greater than 1 recursion starts, in order to compute the fibonacci number
				        # in every other case (if t0=0 or t0=1) t0 is returned from the fib function (because f(0)=0, f(1)=1)
	 			       
	move $t1, $t0 			# move $t1, $t0 is optional
	addi $sp, $sp, -4	        # enlarges the stack
	sw $t1, 0($sp)			# stores the result to the stack in register $t1
			
	jr $ra


recursion:
	
	addi $sp, $sp, -4		# enlarges the stack	
	sw $t0, 0($sp)			# stores user's input to the stack
													

	addi $t6, $0, 0	   		# initializes registers, so as to prepare them for the first recursion.
	addi $t4, $0, 0			# i.e t4 stands for f(0), t5 stands for f(1), t6 stands for recursion's counter.						
	addi $t5, $0, 1    
	sub $t0, $t0, 1			# reduces user's input by 1 digit, because we want the recursion to be repeated n-1 times

  recurse:				# start of recursion


	addi $t6, $t6, 1		# increases counter
					
	add  $t1, $t5, $t4		# [Fn = Fn-1 + Fn-2] stores to $t1(Fn) the values of $t5(Fn-1) and $t4(Fn-2)							
	addi $t4, $t5, 0		# The register $t4 takes then the value of $t5, the previous Fn-1
	addi $t5, $t1, 0		# And the previous Fn-1 takes the value of $t1(Fn)
								
		
						
	     bne $t6, $t0, recurse	# while $t6 is not equal to $t0, continues the recursion	
	        
	 	lw $t0, 0($sp)		# restores the value of $t0			
	 	sw $t1, 0($sp)		# stores to the stack the result of the recursion, the fibonacci number	
	
						
	 	jr $ra			# returns the address	





convert_to_ASSCI:
	
	la $t2, ascii			# loads the address of ascii in $t2 register		
	
	
	ble $t0, 9, oneDigit		# checks if $t0 belongs to [0,9] or [10,24] and jumps to suitable function
	ble $t0, 24, twoDigits

		

notValid:
	
	li $v0, 4			# prints error message for wrong number
	la $a0, wrong_num
	syscall

        j Promt_User			# jumps to main menu
	


oneDigit:		

	addi $t2, $t0, 48		# adds 48 to $t0 (user's input) to create the ASCII form of the number and store it in $t2
	sb $t2, 23($t3)			# stores $t2 to the byte of the result message that is required	
	li $t2,32			# initializes $t2 register to 32,ASCII's equevalent for space
	sb $t2 ,24($t3)			# in the occasion tha a two-digit integer had proceded we store $t2 to the byte of the second digit so as to overwrite it
		 
        j print

twoDigits:

	li $s0, 10			# initializes $s0 to 10
	
	div $t0, $s0			# divides the user's input ($t0) with 10
	             
	mflo $s1   			# stores to $s1 the quotient, first digit
	mfhi $s2   			# stores to $s2 the remainder, second dgit       


	addi $t2, $s1, 48		# adds 48 to $s1 first digit, to create the ASCII form of the number and stores it in $t2
	sb $t2, 23($t3)			# stores $t2 to the byte of the result message that is required
	
	li $t2, 0			# initializes $t2 to 0
	addi $t2, $s2, 48		# adds 48 to $s2 second digit, to create the ASCII form of the number and stores it in $t2
	sb $t2, 24($t3)			# stores $t2 to the byte right next to the one of the first digit

	
	j print





print:

	li $v0, 4			# prints full result message
	la $a0, ($t3)
	syscall


	li $v0, 1			# prints the fibonacci result
	move $a0, $t1
	syscall

	j Promt_User




# Exits the program
#

Quit:

	li $v0, 4			# prints quit message
	la $a0, quit_message
	syscall

	li $v0, 10			# terminates program
	syscall


