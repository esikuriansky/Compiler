
VECTOR_LENGTH:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(1));  // arguments number
        JUMP_NE(VECTOR_LENGTH_NOT_VALID_ARGS);

        CMP(INDD(FPARG(IMM(2)),IMM(0)),T_VECTOR); 
        JUMP_NE(VECTOR_LENGTH_BAD_TYPE);

        //access & return length
        PUSH(INDD(FPARG(IMM(2)), IMM(1)));
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));


        POP(FP);
        RETURN;

VECTOR_LENGTH_NOT_VALID_ARGS:
        SHOW("VECTOR_LENGTH bad number of args",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

VECTOR_LENGTH_BAD_TYPE:
        SHOW("VECTOR_LENGTH - bad arg type",INDD(FPARG(IMM(2)),IMM(0)));
        STOP_MACHINE ;
        return 1;
