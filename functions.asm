# xSpim Memory Demo Program

#  Data Area
.data

space:
    .asciiz " "

newline:
    .asciiz "\n"

dispArray:
    .asciiz "\nCurrent Array:\n"

convention:
    .asciiz "\nConvention Check\n"

myArray:
	.word 0 33 123 -66 332 -1 -223 453 9 45 -78 -14  

#Text Area (i.e. instructions)
.text

main:
    ori     $v0, $0, 4          
    la      $a0, dispArray 
    syscall

    ori     $s1, $0, 12
    la      $s0, myArray

    add     $a1, $0, $s1
    add     $a0, $0, $s0
 
    jal     DispArray

    ori     $s2, $0, 0
    ori     $s3, $0, 0
    ori     $s4, $0, 0
    ori     $s5, $0, 0
    ori     $s6, $0, 0
    ori     $s7, $0, 0
    
    add     $a1, $0, $s1
    add     $a0, $0, $s0

    jal     PrintReverse

    add     $s1, $s1, $s2
    add     $s1, $s1, $s3
    add     $s1, $s1, $s4
    add     $s1, $s1, $s5
    add     $s1, $s1, $s6
    add     $s1, $s1, $s7

    add     $a1, $0, $s1
    add     $a0, $0, $s0
    jal     DispArray

    j       Exit

DispArray:
    addi    $t0, $0, 0 
    add     $t1, $0, $a0

dispLoop:
    beq     $t0, $a1, dispend
    sll     $t2, $t0, 2
    add     $t3, $t1, $t2
    lw      $t4, 0($t3)

    ori     $v0, $0, 1
    add     $a0, $0, $t4
    syscall

    ori     $v0, $0, 4
    la      $a0, space
    syscall

    addi    $t0, $t0, 1
    j       dispLoop    

dispend:
    ori     $v0, $0, 4
    la      $a0, newline
    syscall
    jr      $ra 

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi $v0, $zero, -1
    addi $v1, $zero, -1
    addi $a0, $zero, -1
    addi $a1, $zero, -1
    addi $a2, $zero, -1
    addi $a3, $zero, -1
    addi $k0, $zero, -1
    addi $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

PrintReverse:
    #TODO: write your code here, $a0 stores the address of the array, $a1 stores the length of the array
    addi $sp, $sp, -16
    sw $s2, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $ra, 0($sp)

    #s0 is the length of the array - 1
    addi $s0, $a1, -1

    #s1stroes address of array
    move $s1, $a0

PrintReverseLoop:
    blt $s0, $zero, PrintReverseExit

    li $t0, 4
    mult $s0, $t0
    mflo $t1

    addu $t2, $t1, $s1

    lw $s2, 0($t2)

    li $v0, 1
    move $a0, $s2
    syscall

    addi $s0, $s0, -1

    jal ConventionCheck

    j PrintReverseLoop

PrintReverseExit:
    # Do not remove this line
    lw $s2, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $ra, 0($sp)

    addi $sp, $sp, 16
    jr      $ra
