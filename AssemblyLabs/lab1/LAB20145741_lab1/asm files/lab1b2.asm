# B2

# Data declaration section
#
.data    

#Strings to be printed
#
ask_string:    .asciiz "\nEnter a 20-character string: \n"
out_string1:   .asciiz "\nHello, "    
your_string:   .space 20  
out_string2:   .asciiz "World! \n"  

# Assembly language instructions go in text segment
#
.text     


# Start of code section
#

main: 

#Asks for string from user
#
li $v0, 4
la $a0, ask_string
syscall

#Get user's input as text
#
li $v0, 8
la $a0, your_string
li $a1, 20
syscall


#Prints Hello
#
li $v0, 4            
la $a0, out_string1 
syscall              
  
                   
#Prints user's input
#
li $v0, 4
la $a0, your_string
syscall


#Prints World
#
li $v0, 4
la $a0, out_string2
syscall



#Terminates program
#
li $v0, 10          
syscall 