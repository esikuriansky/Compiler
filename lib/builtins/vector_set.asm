

VECTOR_SET:
        PUSH(FP);
        MOV(FP, SP);
         

        MOV(INDD(FPARG(IMM(2)), R0+2), FPARG(4)); 
        
        MOV(R0, SOB_VOID);
        POP(FP);
        RETURN;

