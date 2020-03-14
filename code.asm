addi	$1, $0, 1			# $1 = $0 + 1
jalr    $2, $1
lw      $1, 0($1)
addi	$1, $0, 0xffff			# $1 = $1 + 0xffff
add     $1, $1, $1
syscall
# lui $3, 0x8793
# ori $3, $0, 0xa3b4
# sb  $3, 0($0)
# sb  $3, 1($0)
# sh  $3, 4($0)
# sh  $3, 6($0)
# sw  $3, 0($0)
# lw  $4, 0($0)
# lbu $4, 2($0)
# lb  $4, 3($0)
# lh  $4, 0($0)
# lhu $4, 2($0)
# lw  $5, 0($0)
# ori $3, $0, 0x8192
# sb  $4, 0($0)
# lbu $4, 2($0)
# sh  $4, 6($0)
# lbu $4, 2($0)
# sh  $4, 6($0)
# lhu  $4, 2($0)
# sb  $3, 1($0)

# # jal     START
# # nop
# # EQ:
# # sllv    $1, $2, $3 
# # jal     BNE
# # nop
# # NE:
# # sllv    $1, $2, $3 
# # jal     BGEZ
# # nop
# # GEZ:
# # jal     BGTZ
# # nop
# # GTZ:
# # jal     BLEZ
# # nop
# # LEZ:
# # jal     BLTZ
# # nop
# # LTZ:
# # jal     BGEZAL
# # nop
# # GEZAL:
# # jal     BLTZAL
# # nop
# # LTZAL:
# # jal     END
# # nop


# # START:
# # ori     $3, $1, 0x1234
# # ori     $4, $3, 0x431
# # beq     $4, $3, EQ
# # sub     $4, $3, 1
# # BNE:
# # bne		$3, $4, NE	# if $3 != $4 then BNE
# # sub     $6, $0, 1
# # BGEZ:
# # bgez    $3, GEZ
# # add     $7, $3, $3
# # BGTZ:
# # bgtz    $7, GTZ
# # sub     $6, $6, 200
# # BLEZ:
# # blez    $6, LEZ 
# # addiu   $5, $3, 0x1234      
# # BLTZ:
# # bltz    $5, LTZ
# # addi    $5, $0, -1000
# # BGEZAL:
# # bgezal  $5, GEZAL
# # sub     $7, $0, 200
# # BLTZAL:
# # sw      $7, 0x2000($0)
# # lw      $7, 0x2000($0)
# # bltzal  $7, LTZAL
# # nop
# # END:
# # # ori	$3, $0, 3
# # # ori	$2, $0, 4
# # # add	$1, $2, $3
# # # sub	$3, $3, $2
# # # and $5, $3, $2
# # # or	$6, $3, $2
# # # addi $3, $7, 12
# # # xor $6, $5, $2
# # # nor $7, $6, $3
# # # addi $3, $7, 12
# # # addiu $7, $3, 192
# # # andi $3, $7, 21
# # # and $5, $3, $2
# # # xori $3, $7, 12
# # # or	$6, $3, $2
# # # ori $3, $0, 0xfffa
# # # ori	$10, 0x1234
# # # sll $4, $3, 5
# # # srl	$4, $4, 5
# # # ori $5, $0, 16
# # # sllv $3, $3, $5
# # # srav $6, $3, $5
# # # srlv $7, $3, $5
# # # ori  $5, 20
# # # sra  $7, $3, 3	   
# # # ori	$1, $0, 1
# # # ori	$2, $0, 1
# # # ori	$3, $0, 10
# # # ori	$5, $0, 1
# # # jal 	fib
# # # addu	$7, $2, $31
# # # ori	$3, $0, 10
# # # ori	$10, 28
# # # addu	$8, $31, 28
# # # jalr	$10, $8
# # # ori	$31, $10, 0
# # # nop 
# # # ori	$v0, $0, 10
# # # syscall	

# # # fib:
# # # addu	$4, $0, $2
# # # addu	$2, $2, $1
# # # subu	$1, $4, $0
# # # subu	$3, $3, $5
# # # beq	$3, $0, return
# # # nop
# # # j	fib
# # # nop	
# # # return:
# # # jr	$31
# # # nop

# # # jal     loop
# # # addu    $7, $31, $0 
# # # ori     $v0, 10
# # # syscall

# # # loop:
# # # jr      $31
# # # nop

# # # ori	$1, $0, 0x1020
# # # sw	$1, 0($1)
# # # lw	$1, 0($1)		# 
# # # ori     $3, $0, 0x1000
# # # subu    $2, $1, $3
# # # sw      $2, 0($1)		# 
# # # lw      $2, 0($1)
# # # jalr	 $2,	$2				# jump to or
# # # addu    $2, $2, $0
# # # ori     $v0, $0, 10
# # # syscall
# # # return:
# # # lw      $1, 0($1)
# # # sw      $1, 0($1)
# # # lw      $2, 0($1)		# 
# # # jr      $2					# jump to $1

