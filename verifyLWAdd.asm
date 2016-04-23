.text
main: addi $r1, $r0, 1
add $r2, $r1, $r1
sub $r3, $r2, $r1
sw $r3, 4($r2)
lw $r4, 4($r2)
addi $r5, $r0, 0
lw $r5, 4($r5)
bne $r3, $r0, dead
quit: halt
dead:
sll $r4, $r3, 2
sra $r5, $r4, 2
and $r4, $r1, $r1
and $r4, $r2, $r1
or $r3, $r4, $r0
lw $r4, 4($r3)
add $r10, $r4, $r0
hi:
add $r0, $r0, $r0
add $r0, $r0, $r0
addi $r1, $r0, 1
blt $r0, $r1, end
halt
end: addi $r1, $r0, 15
halt

.data
heapsize: .word 0x00000000
myheap: .word 0x00000000
