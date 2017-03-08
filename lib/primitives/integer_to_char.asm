
INTEGER_TO_CHAR:
        PUSH(FP);
        MOV(FP, SP);

        PUSH(INDD(FPARG(2), 1));
        CALL(MAKE_SOB_CHAR);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

