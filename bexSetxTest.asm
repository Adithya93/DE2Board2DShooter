.text
addi $r1, $r0, 5
setx 3
add $r2, $r1, $r1
bex good

fail:
halt

good:
sll $r3, $r2, 2
setx 0

end:
halt




.data