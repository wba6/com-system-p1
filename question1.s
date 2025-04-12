        .data
arr:    .word 11, 22, 33, 44, 55, 66, 0, 0, 0, 0   # 10 elements
a:      .word 0                                    # space to store final sum

        .text
        .globl main

main:
        la   $t0, arr       # $t0 points to start of arr
        li   $t1, 0         # i = 0
        li   $s0, 0         # a = 0 (using $s0 to hold 'a')

loop:
        li   $t2, 10        # constant 10
        beq  $t1, $t2, end  # if i == 10, break

        lw   $t3, 0($t0)    # load arr[i]
        add  $s0, $s0, $t3  # a += arr[i]

        addi $t0, $t0, 4    # move pointer to arr[i+1]
        addi $t1, $t1, 1    # i++

        j    loop

end:
        # Print the result (a)
        move $a0, $s0       # put 'a' into $a0
        li   $v0, 1         # print integer service
        syscall

        # Print a newline
        li   $v0, 11        # print character service
        li   $a0, 10        # ASCII code for '\n'
        syscall

        # Exit program
        li   $v0, 10
        syscall

