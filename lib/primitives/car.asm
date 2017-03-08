
CAR:
        PUSH(FP);
        MOV(FP, SP);


        MOV(R0,INDD(FPARG(IMM(2)),IMM(1))); 
        POP(FP);
        RETURN;

