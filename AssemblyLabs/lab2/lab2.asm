# LAB 2

# Eva Pantazi
# Alexandra Gkaragkani



# Data declaration section
#
.data 



# Strings to be printed


first_num:     .asciiz "\nPlease enter the first number: \n"       
operation:     .asciiz "\nPlease enter the operation: (+, -, *, /) \n"
second_num:    .asciiz "\n\nPlease enter the second number: \n"
result:        .asciiz "\nThe result is: \n"
d_string:      .asciiz ".................... \n"
error:         .asciiz "\nThe operation you chose is not valid. Try again!\n"
div_error:     .asciiz "\nThe division with zero is not feasible. Try again!\n"


# Assembly language instructions go in text segment
#
.text 


# Start of code section
#   
main:




# Asks for the 1st integer from user
#
li $v0, 4 
la $a0, first_num
syscall

# Prints d_string
#
li $v0, 4
la $a0, d_string
syscall

# Gets user's input as the 1st integer
#
li $v0, 5
syscall

# Stores the 1st integer $t0<-$v0
#
move $t0,$v0





# Asks for the operation from user
#
li $v0, 4 
la $a0, operation
syscall


# Prints d_string
#
li $v0, 4
la $a0, d_string
syscall


# Gets user's operation as a symbol
#
li $v0, 12
syscall


# Stores the operation $t1<-$v0
#
move $t1,$v0


# Encoding ASCII symbols
#
li $t4, 43         # 43 is the ASCII decimal number for '+'
li $t5, 45         # 45 is the ASCII decimal number for '-'
li $t6, 42         # 42 is the ASCII decimal number for '*'
li $t7, 47         # 47 is the ASCII decimal number for '/'




# Asks for the 2nd integer from user
#
li $v0, 4 
la $a0, second_num
syscall

# Prints d_string
#
li $v0, 4
la $a0, d_string
syscall

# Gets user's input as the 2nd integer
#
li $v0, 5
syscall

# Stores the 2nd integer $t2<-$v0
#
move $t2, $v0




# Branches for operations
#
beq $t1, 43, addition
beq $t1, 45, subtraction
beq $t1, 42, multiplication
beq $t1, 47, division


else:
 li $v0, 4                             #Checks if the user has given wrong
 la $a0, error                         #character for operation, prints the
 syscall                               #suitable message and exits the program
 j exit



# Using functions for each operation
# between the integers given


addition:
  add $t3,$t0,$t2
  j print
  


subtraction:
  sub $t3,$t0,$t2
  j print



multiplication:                    
  mult $t0,$t2                         # We used mult instead of mul for numbers bigger than 16-bits
  mflo $t3                             # The product from the multiplication is moved from register lo->t3
  j print



division:


beq $t2,$0,not_div                    # Checks if the 2nd integer is 0
                                      # and goes to not_div label
                                      
div $t0, $t2                          #If the 2nd integer isn't zero, the division can be done.
mflo $t3                              #The quotinet of the division is moved from register lo to t3
j print       

                 
                              
not_div:                   
                                         
li $v0, 4                             # Prints a message of erroe and exits the program           
la $a0, div_error
syscall
j exit





# Prints the result
#
print:

li $v0, 4
la $a0, result
syscall

li $v0, 1
move $a0, $t3
syscall

j exit


# Terminates program
#
exit:

li $v0, 10          
syscall 






