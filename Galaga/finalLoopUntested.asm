.text

init:
addi $r20, $r0, 470 
addi $r28, $r0, 100 
addi $r21, $r0, 400
add $r4, $r21, $r0 
addi $r22, $r0, 590
addi $r29, $r0, 30 
addi $r1, $r0, 300
add $r3, $r1, $r0
addi $r11, $r0, 300 
addi $r13, $r0, 40
addi $r27, $r0, 4
add $r14, $r11, $r0
add $r15, $r13, $r0 
addi $r19, $r0, 8  

loop:
add $r0, $r0, $r0
add $r0, $r0, $r0
bne $r6, $r0, spawnBullet

continue:
blt $r4, $r13, resetBullet

continue2:
blt $r4, $r21, moveBullet

hideBullet:
bne $r4, $r21, continue3
add $r3, $r1, $r0

continue3:
blt $r13, $r15, moveEnemyBullet

hideEnemyBullet:
add $r14, $r11, $r0

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

wrapPlayer:
blt $r22, $r1, respawnLeft
blt $r1, $r29, respawnRight
j checkPlayerCollisionY

respawnLeft:
add $r1, $r29, $r0
j checkPlayerCollisionY

respawnRight:
add $r1, $r22, $r0
j checkPlayerCollisionY

checkPlayerCollisionY:
addi $r23, $r21, -20
blt $r23, $r15, checkPlayerCollisionX1
j shouldEnemyShoot

checkPlayerCollisionX1:
addi $r23, $r1, -20
blt $r23, $r14, checkPlayerCollisionX2
j shouldEnemyShoot

checkPlayerCollisionX2:
addi $r23, $r1, 20
blt $r14, $r23, lose
j shouldEnemyShoot


shouldEnemyShoot:
addi $r17, $r17, 1
jal incrDifficulty
addi $r23, $r19, -1
and $r23, $r17, $r23
bne $r23, $r0, restart
jal spawnEnemyBullet

restart:
j loop


incrDifficulty:
blt $r18, $r19, goBack
add $r18, $r0, $r0
sra $r19, $r19, 1 
goBack:
jr $ra


moveBullet:
sub $r4, $r4, $r5
j continue3

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
blt $r22, $r11, checkIfMovingRight
blt $r11, $r29, checkIfMovingLeft 
incr:
add $r11, $r11, $r12 
jr $ra 


spawnEnemyBullet:
add $r14, $r11, $r0
addi $r15, $r13, 20
addi $r16, $r0, 50
addi $r18, $r18, 1
jr $ra

moveEnemyBullet:
add $r15, $r15, $r16
j next


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
blt $r27, $r26, win
jal spawnEnemy 
j movePlayer


win:
addi $r30, $r0, 1
j endGame

lose:
addi $r30, $r0, -1

endGame:
halt

.data