

VECTOR_SET:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);

        MOV(R0, FPARG(IMM(2))); 
        MOV(R1, INDD(FPARG(3), 1)); 
        MOV(INDD(R0, R1+2), FPARG(4)); 
        MOV(R0, SOB_VOID);

        POP(R1);
        POP(FP);
        RETURN;

