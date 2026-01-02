# LAB 3
# Eva Pantazi
# Alexandra Gkaragkani




# Data declaration section
#
.data 



# Strings to be printed

message1:          .asciiz      "Please enter your string:\n"
message2:          .asciiz      "\nThe now processed string is:\n"



.align 2
User_String:       .space 100  
Processed_String:  .space 100




# Assembly language instructions go in text segment
#
.text 



# Start of code section
#   
main:                            


jal Get_Input
jal Process
jal Print_Output
j Terminate



#Subroutines
#



#------------Registers used------------
# 
# For input and output we use $s registers

#  $s0: stores the input from user           
#  $s1: stores the new processed string
#  $t0: stores each word
#  $t1: holds each byte of the word
#  $t2: counts the bytes of $t1
#  $t3: counts the bytes of $s1
#  $t4: counter for space
#  $t5: help counter for srl

#---------------------------------------


Get_Input:


li $v0, 4                      # Asks for string from user
la $a0, message1
syscall


li $v0, 8                      # Gets user's input as a string
la $a0, User_String
li $a1, 100
syscall


move $s0, $a0                  # Stores the input from user
                               # to $s0 register

jr $ra                         # Holds the return address for the subroutine






Process:

li $t4, 0                      # Initializes counter for space to zero
li $t2, 0                      # and the counter for bytes to zero

la $s1, Processed_String       # Sets the address of the Processed_String to $s1
             
lw $t0, 0($s0)                 # Loads the first word of the string



loop: 

blt $t2, 4, Masking

li $t2, 0
addi $s0, $s0, 4
lw $t0, 0($s0)                 # The register $t0 gets the 
j Masking                      # 4 bytes of the next word                


Masking:


andi $t1, $t0, 0x00000FF       # $t1 holds the LSB/first character given
srl $t5, $t0, 8
move $t0, $t5
              
addi $t2, $t2, 1



beq $t1, 10, finish            # Checks for /n in the input string



#--------ASCII TABLE--------
#---------------------------

# 0-47       Symbols
# 58-64      Symbols
# 91-96      Symbols
# 123-127    Symbols

# 48-57      Numbers
# 97-122     Lowercase letters

# 65-90      Uppercase letters  

#-----------------------------


# Branches
#

ble $t1, 47, Delete
ble $t1, 57, Save
ble $t1, 64, Delete
ble $t1, 90, Edit
ble $t1, 96, Delete
ble $t1, 122, Save
j Delete



Save:                           

addi $t4, $0, 0
sb $t1, 0($s1)                 # Stores each byte to the new processed
addi $s1, $s1, 1               # string $s1

j loop                         # And returns back to the loop for next byte






Edit: 

addi $t1, $t1, 32              # In ASCII, every lowercase letter with its
j Save                         # respective uppercase have 32 decimal
                               # numbers difference




Delete:


beq $t4, 0, space              # Checks the counter for space
j loop

space:
li $t1, 32                     # In ASCII, space is decimal 32
li $t4, 1

sb $t1, ($s1)                  # Stores each byte to the new processed
addi $s1, $s1, 1               # string $s1

j loop                         # And returns back to the loop for next byte



finish:
jr $ra



Print_Output:

li $v0, 4                      # Prints a suitable message
la $a0, message2
syscall


li $v0, 4                      
la $a0, Processed_String       # Prints the new processed string
syscall

jr $ra



Terminate:                     # Exits the program

li $v0, 10
syscall



