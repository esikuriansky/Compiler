
LOWER:
	
	PUSH(FP);
 	MOV(FP, SP);
 	PUSH(R1);
 	PUSH(R2);
 	PUSH(R3);
 	PUSH(R4);
 	PUSH(R10);


 	MOV(R1, FPARG(1));
 	MOV(R2, IMM(1));     
  MOV(R3, FPARG(2));

  CMP(R1, IMM(1));
  JUMP_EQ(LOWER_END_TRUE);

  CMP(IND(R3), T_FRACTION);
  JUMP_EQ(LOWER_LOOP);

  // TRANSFORM ARG TO FRACTION
  PUSH(1);
  PUSH(INDD(R3, 1));
  PUSH(1);
  CALL(MAKE_SOB_FRACTION);
  DROP(3);
  MOV(R3, R0);

LOWER_LOOP:
	
	MOV(R4, FPARG(R2 + 2));

	CMP(IND(R4), T_FRACTION);
	JUMP_EQ(CONT_LOWER_LOOP);

	PUSH(1);
  PUSH(INDD(R4, 1));
  PUSH(1);
  CALL(MAKE_SOB_FRACTION);
  DROP(3);
  MOV(R4, R0);

CONT_LOWER_LOOP:
	PUSH(R4);
	PUSH(R3);
	CALL(MINUS_FRACS);
	DROP(2);

	MOV(R10, INDD(R0,2));
	CMP(R10, 0);
	JUMP_LT(LOWER_END_FALSE);

	ADD(R2, 1);
	CMP(R2, R1);
	JUMP_EQ(LOWER_END_TRUE);
	MOV(R3, R4);
	JUMP(LOWER_LOOP);

LOWER_END_FALSE:
	MOV(R0, IMM(SOB_BOOL_FALSE));
	POP(R10);
	POP(R4);
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;

LOWER_END_TRUE:
	MOV(R0, IMM(SOB_BOOL_TRUE));
	POP(R10);
	POP(R4);
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;