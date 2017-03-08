
STRING_REF:
        PUSH(FP);
        MOV(FP, SP);

        MOV(R0, INDD(FPARG(IMM(3)), IMM(1))); 
        PUSH(INDD(FPARG(2), R0+2));
        CALL(MAKE_SOB_CHAR);
        DROP(1)
        
        POP(FP);
        RETURN;

