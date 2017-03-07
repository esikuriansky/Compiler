

VECTOR_SET:
        PUSH(FP);
        MOV(FP, SP);
         
        MOV(R0, FPARG(IMM(2))); // POINTER TO VECTOR
        MOV(R1, INDD(FPARG(3), 1)); // OFFSET

        MOV(INDD(R0, R1+2), FPARG(4)); 
        
        MOV(R0, SOB_VOID);

        POP(FP);
        RETURN;

