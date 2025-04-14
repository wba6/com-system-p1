        .data
vecA:   .word 2, 3, 4, 5      # A array
vecB:   .word 4, 5, 6, 7      # B array
res:    .word 0               # to store the final dot product

        .text
        .globl main

main:
        # Initialize pointers and counter
        la   $t0, vecA       # $t0 points to A
        la   $t1, vecB       # $t1 points to B
        li   $t2, 4          # we have 4 elements to process
        li   $s0, 0          # $s0 will accumulate the dot product

loop:
        beqz $t2, done       # if $t2 == 0, we're done

        # Load elements from A and B
        lw   $a0, 0($t0)     # load A[i] into $a0
        lw   $a1, 0($t1)     # load B[i] into $a1

        # Multiply and accumulate into $s0
        mul  $v1, $a0, $a1   # multiply A[i]*B[i], store in $v1
        add  $s0, $s0, $v1   # sum += product

        # Advance pointers & decrement counter
        addi $t0, $t0, 4     # move to next A element
        addi $t1, $t1, 4     # move to next B element
        addi $t2, $t2, -1    # count--

        j    loop           # repeat until count==0

done:
        # Store the final dot product in memory (optional)
        sw   $s0, res

        # Print the result to console
        move $a0, $s0        # put the result in $a0
        li   $v0, 1          # service: print integer
        syscall

        # Print a newline
        li   $v0, 11         # service: print character
        li   $a0, 10         # ASCII for '\n'
        syscall

        # Exit the program
        li   $v0, 10         # service: exit
        syscall

