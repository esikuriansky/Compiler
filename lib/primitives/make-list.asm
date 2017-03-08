
MAKE_LIST:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        PUSH(R4);
        PUSH(R5);
        PUSH(R6);
        MOV(R1, FPARG(0));
        MOV(R2, SOB_NIL);

MAKE_LIST_LOOP_123:
        CMP(R1, 0);
        JUMP_EQ(MAKE_LIST_DONE);
        MOV(R3, FPARG(R1));
        PUSH(R2);
        PUSH(R3);
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        MOV(R2, R0);
        DECR(R1);
        JUMP(MAKE_LIST_LOOP_123);

MAKE_LIST_DONE:

        MOV(R0, R2);
        POP(R6);
        POP(R5);
        POP(R4);
        POP(R3);
        POP(R2);
        POP(R1);
        POP(FP);
        RETURN;
