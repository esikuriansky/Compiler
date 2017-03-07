
SET_CAR:
        PUSH(FP);
        MOV(FP, SP);

        MOV(INDD(FPARG(IMM(2)),IMM(1)), FPARG(3)); //set!
        MOV(R0, SOB_VOID);

        POP(FP);
        RETURN;
