
REMAINDER:
        PUSH(FP);
        MOV(FP, SP);

    	MOV(R0,INDD(FPARG(2),1));
        REM(R0,INDD(FPARG(3),1));
        
        PUSH(R0);
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

