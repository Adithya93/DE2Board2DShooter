.text

init:
addi $r20, $r0, 470 
addi $r28, $r0, 100 
addi $r21, $r0, 400
add $r4, $r21, $r0
add $r9, $r4, $r0 
addi $r22, $r0, 590
addi $r29, $r0, 30 
addi $r1, $r0, 300
add $r3, $r1, $r0
add $r8, $r3, $r0
addi $r11, $r0, 300 
addi $r13, $r0, 40
addi $r27, $r0, 4
add $r14, $r11, $r0
add $r15, $r13, $r0 
addi $r19, $r0, 16 
addi $r7, $r0, 50

loop:
add $r0, $r0, $r0
add $r0, $r0, $r0
bne $r6, $r0, spawnBullet

continue:
blt $r4, $r13, resetBullet

alsoContinue:
blt $r9, $r13, resetSecondBullet

continue2:
blt $r4, $r21, moveBullet

hideBullet:
bne $r4, $r21, continue3
add $r3, $r1, $r0

continue3:
blt $r9, $r21, moveSecondBullet

hideSecondBullet:
bne $r9, $r21, continue4
add $r8, $r1, $r0

continue4:
blt $r13, $r15, moveEnemyBullet

hideEnemyBullet:
add $r14, $r11, $r0

next:
jal moveEnemy


shouldEnemyDie1:
addi $r23, $r13, 20
blt $r4, $r23, checkEnemyCollision1X1
j shouldEnemyDie2

checkEnemyCollision1X1:
addi $r23, $r11, -20 
blt $r23, $r3, checkEnemyCollision1X2
j shouldEnemyDie2

checkEnemyCollision1X2:
addi $r23, $r11, 20 
blt $r3, $r23, killEnemy
j shouldEnemyDie2

shouldEnemyDie2:
addi $r23, $r13, 20
blt $r9, $r23, checkEnemyCollision2X1
j movePlayer

checkEnemyCollision2X1:
addi $r23, $r11, -20 
blt $r23, $r8, checkEnemyCollision2X2
j movePlayer

checkEnemyCollision2X2:
addi $r23, $r11, 20 
blt $r8, $r23, killEnemy
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
addi $r23, $r0, 4
blt $r19, $r23, decide 
jal incrDifficulty
decide:
addi $r23, $r19, -1
and $r23, $r17, $r23
bne $r23, $r0, restart
jal spawnEnemyBullet

restart:
bex startPause
j loop

startPause:
setx 0
j pause


incrDifficulty:
blt $r18, $r19, goBack
add $r18, $r0, $r0
sra $r19, $r19, 1 
sll $r7, $r7, 1
goBack:
jr $ra


moveBullet:
sub $r4, $r4, $r5
j continue3

moveSecondBullet:
sub $r9, $r9, $r10
j continue4


spawnBullet:
blt $r4, $r21, spawnSecondBullet
add $r3, $r1, $r0
addi $r4, $r21, -20
addi $r5, $r0, 50
addi $r25, $r25, 1
and $r6, $r0, $r6 
j continue


spawnSecondBullet:
add $r8, $r1, $r0
addi $r9, $r21, -20
addi $r10, $r0, 50
addi $r25, $r25, 1
and $r6, $r0, $r6 
j continue


resetBullet:
add $r3, $r1, $r0
add $r4, $r0, $r21
add $r5, $r0, $r0
j alsoContinue


resetSecondBullet:
add $r8, $r1, $r0
add $r9, $r0, $r21
add $r10, $r0, $r0
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
add $r16, $r0, $r7
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


pause:
bex resume
j pause

resume:
setx 0
j loop


win:
addi $r30, $r0, 1
j endGame

lose:
addi $r30, $r0, -1

endGame:
halt

.data