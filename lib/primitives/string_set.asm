
STRING_SET:
        PUSH(FP);
        MOV(FP, SP);
        MOV(R0, INDD(FPARG(IMM(3)), IMM(1)));  
        MOV(INDD(FPARG(IMM(2)), R0+2), INDD(FPARG(4),1)); 
        MOV(R0, SOB_VOID);
        POP(FP);
        RETURN;



 