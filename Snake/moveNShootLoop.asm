.text

init:
addi $r20, $r0, 470
addi $r21, $r0, 400
addi $r22, $r0, 630

loop:
add $r0, $r0, $r0
add $r0, $r0, $r0
bne $r6, $r0, spawnBullet

continue:
blt $r20, $r4, resetBullet

continue2:
blt $r21, $r4, moveBullet

next:
add $r1, $r1, $r2
j loop

moveBullet:
add $r4, $r4, $r5
j next

spawnBullet:
add $r3, $r1, $r0
addi $r4, $r0, 450
addi $r5, $r0, 10
j continue

resetBullet:
add $r3, $r1, $r0
addi $r4, $r0, 400
add $r5, $r0, $r0
j continue2

.data