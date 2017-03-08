
VECTOR_REF:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);

        MOV(R1, FPARG(IMM(3)));
        MOV(R0, INDD(R1, IMM(1))); 
        MOV(R1, FPARG(IMM(2)));
        MOV(R0, INDD(R1, R0+2)); 
        
        POP(R1);
        POP(FP);
        RETURN;


