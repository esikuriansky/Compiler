
SET_CAR:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);

        MOV(R1, FPARG(2));
        MOV(INDD(R1,IMM(1)), FPARG(3));
        MOV(R0, SOB_VOID);

        POP(R1);
        POP(FP);
        RETURN;
