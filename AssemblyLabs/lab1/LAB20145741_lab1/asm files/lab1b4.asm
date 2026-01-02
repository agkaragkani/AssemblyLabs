#B4

# Data declaration section
#
.data    

#Strings to be printed
#
out_string:   .asciiz "\nHello World!"    
ask_char:     .asciiz "\nEnter a character:\n"
t_string: .asciiz "( "
f_string: .asciiz " )\n"


# Assembly language instructions go in text segment
#
.text     


# Start of code section
#

main: 


#Asks for character from user
#
li $v0, 4
la $a0, ask_char
syscall


#Gets user's input as a character
#
li $v0, 12
syscall


#Stores the character in $t0
#
move $t0, $v0



#Prints Hello World!
#
li $v0, 4            
la $a0, out_string
syscall              
 
#Prints "("
#
li $v0, 4 
la $a0, t_string
syscall

 
                   
#Prints user's input
#
li $v0, 11
move $a0, $t0
syscall

#Prints ")"
#
li $v0, 4 
la $a0, f_string
syscall



#Terminates program
#
li $v0, 10          
syscall 