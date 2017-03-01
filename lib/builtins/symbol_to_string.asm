
SYMBOL_TO_STRING:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(1));
        JUMP_NE(SYMBOL_TO_STRING_BAD_ARGS);

        CMP(INDD(FPARG(2), IMM(0)), T_SYMBOL); 
        JUMP_NE(SYMBOL_TO_STRING_BAD_TYPE);

        MOV(R0, INDD(FPARG(2), IMM(1))); //R0 = string object

        POP(FP);
        RETURN;

SYMBOL_TO_STRING_BAD_ARGS:
        SHOW("SYMBOL_TO_STRING: bad args number:", FPARG(1));
        STOP_MACHINE ;
        return 1;

SYMBOL_TO_STRING_BAD_TYPE:
        SHOW("SYMBOL_TO_STRING - bad type ", INDD(FPARG(2), IMM(0)));
        STOP_MACHINE ;
        return 1;

