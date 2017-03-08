
APPLY:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	PUSH(R4);
	PUSH(R5);



	MOV(R4, IMM(0));			
	MOV(R1, FPARG(3));			
	MOV(R2, SP);
				
APPLY_PUSH_LOOP:
  CMP(R1, SOB_NIL);
  JUMP_EQ(APPLY_PUSH_LOOP_DONE);
  PUSH(INDD(R1,1));
  ADD(R4, 1);
  MOV(R1, INDD(R1, 2));
  JUMP(APPLY_PUSH_LOOP);

APPLY_PUSH_LOOP_DONE:
	MOV(R1, SP);
	DECR(R1);

APPLY_REVERSE_LOOP:
	CMP(R2, R1);
	JUMP_GE(APPLY_REVERSE_LOOP_DONE);
	MOV(R3, STACK(R2));
	MOV(STACK(R2), STACK(R1));
	MOV(STACK(R1), R3);
	INCR(R2);
	DECR(R1);
	JUMP(APPLY_REVERSE_LOOP);

APPLY_REVERSE_LOOP_DONE:
	PUSH(R4);			
	MOV(R1, FPARG(2));		
	PUSH(INDD(R1, 1));		
	PUSH(FPARG(-1));		
	MOV(R2, FPARG(-2));
	ADD(R4, 3);		
	PUSH(R4);
	PUSH(FP);	
	MOV(R3, FP);
	SUB(R3, 4);			
	SUB(R3, FPARG(1));	
	PUSH(R3);
	CALL(STACKCPY);
	DROP(3);
	MOV(FP, R2);	
	ADD(R3, R4);
	MOV(SP, R3);
	JUMPA((void *) INDD(R1, 2));

  POP(R5);
  POP(R4);
  POP(R3);
  POP(R2);
  POP(R1);
  POP(FP);
  RETURN;
