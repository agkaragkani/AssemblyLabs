# Hello, World!
.data 

f_string: .asciiz "\nHello\t"
l_string: .asciiz "World\n"
userInput: .space 1

.text 
     
main:

li $v0, 12
la $a0, userInput
syscall

li $v0, 4
la $a0, f_string
syscall


li $v0, 4 
la $a0, l_string
syscall 

li $v0, 11
la $a0, userInput
syscall

li $v0, 10 
syscall 
