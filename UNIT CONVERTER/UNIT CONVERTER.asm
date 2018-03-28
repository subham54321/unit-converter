.data
msg:.asciiz "\t \t \t \t \t COA PROJECT \n"
msg2:.asciiz "Project Member: \n*Dedicated to APALA GHOSH\n"
msg3:.asciiz"\n \n \nPlease select the desired converter:\n1-Length Converter \n2-Temperature Converter\n"
msg4:.asciiz"Enter the Length in(cm)\n"
msg5:.asciiz"Select the desired unit you want to convert to:\n1-Meter 2-Foot 3-Kilometer(Km) 4-Inch\n"
msg6:.asciiz"Enter the Temperature in Kelvin\n"
msg7:.asciiz"Select the desired unit you want to convert to:\n1-Celcius 2-Fahrenheit\n"
ansmsg:.asciiz "Your answer is: "
menumsg:.asciiz"\nPlease enter 1 to go back to the main menu or any other key to exit\n"
ty:.asciiz"\n \t \t \t \t Thank You! :)"
ipl:.word 0 #ipl-input length 
itemp:.word 0 #itemp-input temp
.text 
main:
li $t1,1
li $t2,2
li $t3,3
li $t4,4


la $a0,msg
li $v0,4
syscall

la $a0,msg2
li $v0,4
syscall

menu:
la $a0,msg3
li $v0,4
syscall

li $v0,5 			#read int value for desired operation
syscall
move $t0,$v0

beq $t0,$t1,len
beq $t0,$t2,temp

len:				#length main menu
la $a0,msg4
li $v0,4
syscall

li $v0,5 #read length in cm 
syscall
move $t0,$v0
sw $t0,ipl

la $a0,msg5
li $v0,4
syscall

li $v0,5 	       #read desired conversion scale(int input)
syscall
move $t0,$v0

beq $t0,$t1,m
beq $t0,$t2,f
beq $t0,$t3,km
beq $t0,$t4,i


m:
lw $s0,ipl 		#loading the input length in $s0 register
div $s0,$s0,100

la $a0,ansmsg
li $v0,4
syscall

move $a0,$s0 		#printing the converted length in meter
li $v0,1
syscall

j prompt

f:
li.s $f1,0.0328084
lw $s0,ipl
mtc1 $s0,$f12		#for moving the int value from int register to float register
cvt.s.w $f12,$f12
mul.s $f12,$f12,$f1

la $a0,ansmsg
li $v0,4
syscall

li $v0,2 #printing the converted length in foot
syscall

j prompt

km:
li.s $f1,0.00001
lw $s0,ipl
mtc1 $s0,$f12		#for moving the int value from int register to float register
cvt.s.w $f12,$f12
mul.s $f12,$f12,$f1

la $a0,ansmsg
li $v0,4
syscall

li $v0,2                #printing the converted length in km 
syscall

j prompt

i:
li.s $f1,0.393701
lw $s0,ipl
mtc1 $s0,$f12		#for moving the int value from int register to float register
cvt.s.w $f12,$f12
mul.s $f12,$f12,$f1

la $a0,ansmsg
li $v0,4
syscall

li $v0,2                #printing the converted length in inch
syscall

j prompt

temp:

la $a0,msg6
li $v0,4
syscall

li $v0,5		#read temp in kelvin
syscall
move $t0,$v0
sw $t0,itemp

la $a0,msg7		#option for celcius and fahrenheit
li $v0,4
syscall

li $v0,5		#read option
syscall

beq $v0,$t1,cel
beq $v0,$t2,fah

cel:
lw $s0,itemp
li.s $f1,273.15
mtc1 $s0,$f12		#for moving the int value from int register to float register
cvt.s.w $f12,$f12
sub.s $f12,$f12,$f1

la $a0,ansmsg
li $v0,4
syscall

li $v0,2 #temp in celcius will be printed,since the only $f12 can be displayed using call code/its argument 
syscall

j prompt

fah:
lw $s0,itemp
li.s $f1,1.8
li.s $f2,459.67
mtc1 $s0,$f12		#for moving the int value from int register to float register
cvt.s.w $f12,$f12
mul.s $f12,$f12,$f1
sub.s $f12,$f12,$f2

la $a0,ansmsg
li $v0,4
syscall

li $v0,2 #temp in fahrenheit will be printed 
syscall

prompt:
la $a0,menumsg #to prompt for menu msg
li $v0,4
syscall

li $v0,5
syscall
bne $v0,$t1,exit
j menu

exit:		#termination label for the whole program
la $a0,ty       #thanks message
li $v0,4
syscall

li $v0,10	#termination call code
syscall
.end main
