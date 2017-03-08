
VECTOR_LENGTH:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        MOV(R1, FPARG(IMM(2)));
        PUSH(INDD(R1, 1));
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));
        POP(R1);
        POP(FP);
        RETURN;