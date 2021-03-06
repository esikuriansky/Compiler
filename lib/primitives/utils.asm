
STACKCPY:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);

        MOV(R1, FPARG(0)); 
        MOV(R2, FPARG(1)); 
        MOV(R3, FPARG(2));

STACKCPY_LOOP:      
        CMP(R3, 0);
        JUMP_EQ(STACKCPY_DONE);
        MOV(STACK(R1), STACK(R2));
        INCR(R1);
        INCR(R2);
        DECR(R3);
        JUMP(STACKCPY_LOOP);

STACKCPY_DONE:
        POP(R3);
        POP(R2);
        POP(R1);
        JUMP(DONE_UTIL);


BUILD_LIST:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        MOV(R1, FPARG(0));
        MOV(R2, SOB_NIL);

BUILD_LIST_LOOP:
        CMP(R1, 0);
        JUMP_EQ(BUILD_LIST_DONE);
        MOV(R3, FPARG(R1));
        PUSH(R2);
        PUSH(R3);
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        MOV(R2, R0);
        DECR(R1);
        JUMP(BUILD_LIST_LOOP);

BUILD_LIST_DONE:
        MOV(R0, R2);
        POP(R3);
        POP(R2);
        POP(R1);
        JUMP(DONE_UTIL);

DONE_UTIL:
        POP(FP);
        RETURN;