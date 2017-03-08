

MAKE_STRING:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        CMP(FPARG(1),IMM(2)); 
        JUMP_NE(MAKE_STRING_EMPTY);
        MOV(R1,INDD(FPARG(3),1));
        JUMP(MAKE_STRING_CONT);

MAKE_STRING_EMPTY:
	MOV(R1, -1);     

MAKE_STRING_CONT:
        MOV(R0,INDD(FPARG(2),1));

MAKE_STRING_LOOP:
        CMP(R0, IMM(0));
        JUMP_EQ(MAKE_STRING_END);
        PUSH(R1);
        DECR(R0);
        JUMP(MAKE_STRING_LOOP);

MAKE_STRING_END:
        PUSH(INDD(FPARG(2),1)); 
        CALL(MAKE_SOB_STRING);
        DROP(INDD(FPARG(2),1)); 
        DROP(1); 

        POP(R3);
        POP(R2);
        POP(R1);
        POP(FP);
        RETURN;

