;Assuming that the registers 1 and 0 are the operands and 2 the result, the multiplication is:


sub $5, $5, $5			  ;Resetting $5 and $4
sub $4, $4, $4

addi $4, $4, 1			  ;Adding 1 to $4

;;;;;;;;;;;
CONDITION:
  slt $3, $4, $1			;If $1 is bigger or equal to $4 (1), save 0 in $3, else save 1
  beq $3, $4, MULT		;If $3 is 1, so goes to MULT
  j END

MULT:
  add $2, $0, $0			;Add the first operator ($0) to the result ($2)
  sub $1, $1, $4			;Sub 1 to the second operator ($1).
  j CONDITION

END:
  j END				        ;Loop to break the execution
