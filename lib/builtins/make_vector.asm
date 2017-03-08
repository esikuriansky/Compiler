

MAKE_VECTOR:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);

        CMP(FPARG(1), IMM(2)); 
        JUMP_NE(MAKE_VECTOR_EMPTY);

        MOV(R1,FPARG(3));
        JUMP(MAKE_VECTOR_START);

MAKE_VECTOR_EMPTY:
        MOV(R1, SOB_ZERO);

MAKE_VECTOR_START:
        MOV(R0,INDD(FPARG(2),1)); 
   
MAKE_VECTOR_LOOP:
        CMP(R0, IMM(0));
        JUMP_EQ(MAKE_VECTOR_DONE);
        PUSH(R1); 
        SUB(R0, 1);
        JUMP(MAKE_VECTOR_LOOP);

MAKE_VECTOR_DONE:
        PUSH(INDD(FPARG(2),1));
        CALL(MAKE_SOB_VECTOR);
        DROP(INDD(FPARG(2),1)); 
        DROP(1); 
        POP(R1);
        POP(FP);
        RETURN;