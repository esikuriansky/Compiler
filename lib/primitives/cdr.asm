
CDR:
        PUSH(FP);
        MOV(FP, SP);

        MOV(R0,INDD(FPARG(IMM(2)),IMM(2))); 
        POP(FP);
        RETURN;

