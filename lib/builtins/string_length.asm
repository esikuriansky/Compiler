
STRING_LENGTH:
        PUSH(FP);
        MOV(FP, SP);

        PUSH(INDD(FPARG(IMM(2)), IMM(1)));
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));

        POP(FP);
        RETURN;