.text

init:
addi $r20, $r0, 470 
addi $r28, $r0, 100 
addi $r21, $r0, 400
add $r4, $r21, $r0 
addi $r22, $r0, 630
addi $r29, $r0, 100 
addi $r1, $r0, 300
add $r3, $r1, $r0
addi $r11, $r0, 300 
addi $r13, $r0, 40
addi $r27, $r0, 4 

loop:
add $r0, $r0, $r0
add $r0, $r0, $r0
bne $r6, $r0, spawnBullet

continue:
blt $r4, $r13, resetBullet

continue2:
blt $r4, $r21, moveBullet

hideBullet:
add $r3, $r1, $r0

next:
jal moveEnemy

checkEnemyCollisionY:
addi $r23, $r13, 20
blt $r4, $r23, checkEnemyCollisionX1
j movePlayer

checkEnemyCollisionX1:
addi $r23, $r11, -20 
blt $r23, $r3, checkEnemyCollisionX2
j movePlayer

checkEnemyCollisionX2:
addi $r23, $r11, 20 
blt $r3, $r23, killEnemy
j movePlayer

movePlayer:
add $r1, $r1, $r2
j loop



moveBullet:
sub $r4, $r4, $r5
j next

spawnBullet:
add $r3, $r1, $r0
addi $r4, $r21, -20
addi $r5, $r0, 50
addi $r25, $r25, 1
and $r6, $r0, $r6 
j continue

resetBullet:
add $r3, $r1, $r0
add $r4, $r0, $r21
add $r5, $r0, $r0
j continue2



spawnEnemy:
sra $r23, $r22, 1 
sub $r24, $r23, $r1 
add $r11, $r23, $r24 
addi $r13, $r0, 40 
jr $ra


moveEnemy:
sll $r12, $r2, 2 
sra $r23, $r25, 2 
add $r12, $r23, $r12
addi $r23, $r22, -50 
blt $r23, $r11, checkIfMovingRight
blt $r11, $r29, checkIfMovingLeft 
incr:
add $r11, $r11, $r12 
jr $ra 


checkIfMovingRight:
blt $r0, $r12, reverse
j incr

checkIfMovingLeft:
blt $r12, $r0, reverse
j incr

reverse:
sub $r12, $r0, $r12 
j incr


killEnemy:
addi $r13, $r0, 0 
addi $r11, $r0, 0 
addi $r26, $r26, 1 
blt $r27, $r26, endGame
jal spawnEnemy 
j movePlayer


endGame:
halt

.data