MAKE_SOB_SYMBOL:
  PUSH(FP);
  MOV(FP, SP);
  PUSH(IMM(2));
  CALL(MALLOC);
  DROP(1);
  MOV(IND(R0), IMM(T_SYMBOL));
  MOV(INDD(R0, 1), FPARG(0));
  POP(FP);
  RETURN;

