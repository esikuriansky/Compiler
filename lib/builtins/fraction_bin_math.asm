/* Sum two fractions */

PLUS_FRACS: 

  PUSH(FP);
  MOV(FP, SP);
  PUSH(R1);
  PUSH(R2);
  PUSH(R3);
  PUSH(R4);
  PUSH(R5);
  PUSH(R6);

  MOV(R1, FPARG(0));
  MOV(R2, FPARG(1));

  MOV(R3, INDD(R1, 2));  // numer
  MOV(R4, INDD(R1, 3));  // demon
  MOV(R5, INDD(R2, 2));  // numer 
  MOV(R6, INDD(R2, 3));  // demon

  MUL(R3, R6);
  MUL(R5, R4);
  ADD(R3, R5);
  MUL(R4, R6);

  PUSH(1);
  PUSH(R3);
  PUSH(R4);
  CALL(MAKE_SOB_FRACTION);
  DROP(3);

  POP(R6);
  POP(R5);
  POP(R4);
  POP(R3);
  POP(R2);
  POP(R1);
  POP(FP);
  RETURN;



MUL_FRACS:

  PUSH(FP);
  MOV(FP, SP);

  PUSH(R1);
  PUSH(R2);
  PUSH(R3);
  PUSH(R4);
 

  MOV(R1, FPARG(0));
  MOV(R2, FPARG(1));

  MOV(R3, INDD(R1, 2));
  MUL(R3, INDD(R2, 2));

  MOV(R4, INDD(R1,3));
  MUL(R4, INDD(R2,3));
 
  PUSH(1);
  PUSH(R3);
  PUSH(R4);
  CALL(MAKE_SOB_FRACTION);
  DROP(3);

  POP(R4);
  POP(R3);
  POP(R2);
  POP(R1);
  POP(FP);

  RETURN;