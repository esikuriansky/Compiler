
MAKE_LIST:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);

        // SHOW("Amount of arguments: ", FPARG(0));

        /* R1: Counter */
        MOV(R1, FPARG(0));

        // ; The pair
        MOV(R2, SOB_NIL);

MAKE_LIST_LOOP:
        CMP(R1, 0);
        JUMP_EQ(MAKE_LIST_DONE);

        MOV(R3, FPARG(R1));

        // Make pair
        PUSH(R2);
        PUSH(R3);
        CALL(MAKE_SOB_PAIR);
        DROP(2);

        // New pair is old value
        MOV(R2, R0);

        // PUSH(R3);
        // CALL(WRITE_SOB);
        // DROP(1);

        DECR(R1);
        JUMP(MAKE_LIST_LOOP);


MAKE_LIST_DONE:

        // PUSH(R2);
        // CALL(WRITE_SOB);
        // DROP(1);

        // Return
        MOV(R0, R2);

        POP(R3);
        POP(R2);
        POP(R1);

        POP(FP);
        RETURN;
