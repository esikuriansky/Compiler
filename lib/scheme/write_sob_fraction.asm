/**/


WRITE_SOB_FRACTION:
  PUSH(FP);
  MOV(FP, SP);

  PUSH(R1);

  MOV(R0, FPARG(0));
  MOV(R0, INDD(R0, 1));
  CMP(R0, IMM(0));

  JUMP_NE(L_DONE_SIGN);

  /*MOV(R1, IMM('-'));
  PUSH(R1);
  CALL(PUTCHAR);
  DROP(1);*/

  L_DONE_SIGN:
  
  // Numerator
  MOV(R0, FPARG(0));
  MOV(R0, INDD(R0, 2));
  PUSH(R0);
  CALL(WRITE_INTEGER);
  DROP(1);
  
  // Dividing Slash
  MOV(R0, IMM('/'));
  PUSH(R0);
  CALL(PUTCHAR);
  DROP(1);
  
  // Numerator
  MOV(R0, FPARG(0));
  MOV(R0, INDD(R0, 3));
  PUSH(R0);
  CALL(WRITE_INTEGER);
  DROP(1);
  
  POP(R1);
  POP(FP);
  RETURN;