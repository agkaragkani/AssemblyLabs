# B3

# Data declaration section
#
.data 

# Strings to be printed
#
f_string: .asciiz "\nEnter a integer:\n"
s_string: .asciiz "\nHello World!"
t_string: .asciiz "( "
fo_string: .asciiz " )\n"


# Assembly language instructions go in text segment
#
.text 
  


# Start of code section
#   
main:

# Asks for integer from user
#
li $v0, 4 
la $a0, f_string
syscall

# Gets user's input as an integer
#
li $v0, 5
syscall

# Stores $t0<-$v0
#
add $t0, $v0, $0

# Prints Hello World
#
li $v0, 4 
la $a0, s_string
syscall

#Prints "("
#
li $v0, 4 
la $a0, t_string
syscall 

#Doubles the integer
#
li $v0, 1
sll $a0, $t0, 1 
syscall



#Prints ")"
#
li $v0, 4 
la $a0, fo_string
syscall


#Terminates program
#
li $v0, 10 
syscall 
