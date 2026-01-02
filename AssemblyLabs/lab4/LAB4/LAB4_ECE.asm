#LAB 4 
#Eva Pantazi
#Alexandra Gkaragkani



# Data declaration section
#
.data 

.align 2
phone_catalogue:      .space 600         # Each registration contains 3 fields:
                                         # 3 strings of 20 bytes( 20 for each registration)


# Strings to be printed
#

message:             .asciiz "\nPlease determine operation, entry (E), inquiry (I) or quit (Q):\n"
errorString:         .asciiz "\nThe operation you chose is invalid. Please try again!\n" 
fullCatalogue:       .asciiz "\nThe catalogue is full! Can't make more registrations.\n"
inquiryString:       .asciiz "\nPlease enter the entry number you wish to retrieve: \n"
entryString:         .asciiz "\nThank you, the new entry is the following:\n"
noRegistration:      .asciiz "\n There is no such registration in the phone catalogue.\n"
quitMessage:         .asciiz "\nThe program has terminated.\n"
dot:                 .asciiz ". "

 
lname:         .asciiz "\nPlease enter the last name: \n"
fname:         .asciiz "\nPlease enter the first name: \n"
number:        .asciiz "\nPlease enter phone number: \n"


#----------------Registers----------------

#  $s0 -> register for phone_catalogue                                 
#  $s1 -> initialize register with 60 (bytes of one registration)
#  $t0 -> counter for entries to the phone catalogue
#  $t1 -> character from user
#  $t2 -> string of one registration
#  $t3 -> each byte of the registation
#  $t4 -> processed string 
#  $t5 -> help register for $t0
#  $t6 -> initilized to zero



#------------ASCII-------------

# E - 69
# I - 73
# Q - 81

#----------------------------


# Assembly language instructions go in text segment
#
.text

# Start of code section
#   
main:

la $s0, phone_catalogue                            # Stores the phone catalogue to a $s register                   


addi $s1, $0, 60                                    
addi $t0, $0, 0                                    # Initializes the registration counter to zero



Prompt_User:

	li $v0, 4                                  # Asks for operation from user
    la $a0, message
  	syscall


  	li $v0, 12                                 # Gets user's input as a character
  	syscall

  	move $t1, $v0                              # Stores the character in $t1 register


  	beq $t1, 81, Quit
 	bne $t1, 69, Inquiry                       # Checks user's input and goes to the 
 	jal Get_Entry                              # respective subroutines

	j Prompt_User                              # After any process it comes back to Propt_User


Get_Entry:

	beq   $t0, 10, Full_catalogue              # If the registation counter is equal to 10, which
                                               # is the limit of our phone catalogue, goes to Full_Catalogue

	addi  $t0, $t0, 1                          # Otherwise it adds an entry to the counter


	addiu $sp, $sp, -8                         # Adjusts the stack to store 2 items/ It is -8 because the stack grows downwards
	sw    $ra, 0($sp)                          # Saves the return address
	sw    $t0, 4($sp)

	addi  $t0, $t0, -1                         # Each entry contains 60 bytes and is on address: 60*(n-1) + $s0 (phone_catalogue)
	mul   $t2, $s1, $t0                        # n - number of entry
	addu  $t2, $t2, $s0
	move  $a1, $t2                             # Stores the address of the registration to $a1 
                                               # since it's an argument for jal procedures


	jal Get_Last_Name                          
	addi $a1, $v0, 20                          # Moves 20 bytes to get the first name and stores
                                               # the string to $a1 as the new argument for Get_First_Name

	jal Get_First_Name                         
	addi $a1, $v0, 20                          # It does the same to get the phone number

	jal Get_Number        


	lw $t0, 4($sp)                             # Restores the value of $t0 because we modified the counter 
                                               # for entries and we need the initial value for printing

	move $a1, $t0                              # Move the $t0 -> $a1 to be an argument in Print_Entry

        li $v0, 4                              # Prints a suitable message for printing the new entry
    	la $a0, entryString
		syscall
        
	jal Print_Entry                            # Goes to subroutine to print the entry
	
	lw $t0, 4($sp)                             # Restores from stack
	lw $ra, 0($sp)
	addiu $sp ,$sp, 8                          # Restores the space of the stack
	
	
	jr $ra                                                         



Get_Last_Name:

	 li $v0, 4                                 # Asks for the last name from user
 	 la $a0, lname
 	 syscall

 	 li $v0, 8                      
 	 la $a0, ($a1)                             # Gets the last name from user
 	 li $a1, 20
 	 syscall
	
	 move $v0, $a0

         jr $ra
  
  
Get_First_Name:

	 li $v0, 4                                 # Asks for the first name from user
 	 la $a0, fname
 	 syscall

 	 li $v0, 8                      
 	 la $a0, ($a1)                             # Gets the first name from user
 	 li $a1, 20
 	 syscall
	
	 move $v0, $a0

         jr $ra

Get_Number:

	 li $v0, 4                                 # Asks for the phone number from user
 	 la $a0, number
 	 syscall

 	 li $v0, 8                      
 	 la $a0, ($a1)                             # Gets the phone number from user
 	 li $a1, 20
 	 syscall
	
	 move $v0, $a0

         jr $ra

Print_Entry:


	addiu $sp, $sp, -4                         # Adjusts the stack to store 1 item
	sw    $ra, 0($sp)                          # Saves the return address
	

	li $v0, 1                                  # Prints the number of the registration                       
	move $a0, $a1
	syscall

	
	li $v0, 4                                  # Prints a dot
	la $a0, dot
	syscall

	move $t5, $a1                              # Moves to $t5 to modify the string


	addi  $t6, $0, 0 	                   # Finds the place of each registation in the catalogue
	addi  $t5, $t5, -1                     # Each entry contains 60 bytes and is on address: 60*(n-1) + $s0 (phone_catalogue)
	mul   $t6, $s1, $t5
	addu  $t6, $t6, $s0
	
	
	la  $a1, 0($t6)                            # Gets the first 20 bytes to $a1 (last name)
	jal print                                  # and goes to subroutine print

	la  $a1, 20($t6)                           # Gets the next 20 bytes (first name)
	jal print

	la  $a1, 40($t6)                           # Gets the phone number
	jal print
	
	lw $ra, 0($sp)                             # Restores the return address from the stack 
	addiu $sp, $sp, 4                          # Adjusts the size of the stack

	jr $ra
	
	
	
print:
	
      move $t4, $a1                        # Moves the argument to $t4 to process and print the string

 	    loop:                              # Loop to print each byte of the string
		
		
		lb $t3, 0($t4)                     # Loads the first byte of $t4

		beq $t3, 10, Space                 # If $t3 is \n it goes to leave a space and 
                                                   # continues with the next string of the registration
		                             

		li $v0, 11                         # Prints a single character of the string
		la $a0, ($t3)
		syscall
 
		addi $t4, $t4, 1                   # Increases $t4 by one to load the next byte
	        

	        
		
		j loop                             # Jumps to loop to print the next byte
		
	

Space:
	li $t3, 32                                 # Deletes \n and replaces it with a space

	li $v0, 11                                 # Prints a character - space
	la $a0, ($t3)
	syscall
	
		
jr $ra





Inquiry:
        

        bne $t1, 73, Error                        # The user didn't enter any of the letters E, Q, I 
                                                  # and goes to Error


        li $v0, 4                                 # Otherwise it asks for operation from user
    	la $a0, inquiryString
  	syscall
		
	
        li $v0, 5                                 # Gets user's input as an integer
  	syscall

	
        move $a1, $v0                             # Moves the integer to $a1 

	bgt $a1, $t0, notFound                       # Checks if there is a registation with the number given from user


	jal Print_Entry                           # Goes to subroutine Print_Entry
	
        j Prompt_User


	
Error:
 
 	li $v0, 4                                 # Prints a message of error on the
	la $a0, errorString                       # screen in case of wrong input
 	syscall
	
	j Prompt_User                             # Goes back to the menu


Full_catalogue:                                    

	li $v0, 4
	la $a0, fullCatalogue                     # Prints a message that there is no more
	syscall                                   # space in the catalogue

	j Prompt_User                       

notFound:
   
        li $v0, 4
	la $a0, noRegistration                    # Prints a message that there is no such registration
	syscall  

        j Prompt_User


# Exits the program
#

Quit:

  li $v0, 4
  la $a0, quitMessage                             # Prints a message for the termination of the program
  syscall  

  li $v0, 10
  syscall
                                   