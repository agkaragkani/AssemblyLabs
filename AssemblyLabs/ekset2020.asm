.data

enter: .asciiz  "\nenter num: \n "
.align 2 
string: .space 100 

.text

main:
la $s1,string
li $t2,0

Process:

addi $t2,$t2,1


li $v0,4
la $a0,enter
syscall

li $v0,5
syscall

move $a1,$v0

sb $a1,0($s1)
addi $s1,$s1,1

ble $t2,5,Process

li $t3,10
sb $t3,0($s1)

j print

print:

li $v0,4
la $a0,string
syscall

exit:

li $v0,10