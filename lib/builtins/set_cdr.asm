
SET_CDR:
        PUSH(FP);
        MOV(FP, SP);


        MOV(INDD(FPARG(IMM(2)),IMM(2)), FPARG(3));
        MOV(R0, SOB_VOID);

        POP(FP);
        RETURN;
