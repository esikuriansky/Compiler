
CHAR_TO_INTEGER:
        PUSH(FP);
        MOV(FP, SP);

        PUSH(INDD(FPARG(2), 1));
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

