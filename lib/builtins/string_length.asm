
STRING_LENGTH:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(1));  // arguments number
        JUMP_NE(STRING_LENGTH_NOT_VALID_ARGS);

        CMP(INDD(FPARG(IMM(2)),IMM(0)),T_STRING); 
        JUMP_NE(STRING_LENGTH_BAD_TYPE);

        //access & return length
        PUSH(INDD(FPARG(IMM(2)), IMM(1)));
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));


        POP(FP);
        RETURN;

STRING_LENGTH_NOT_VALID_ARGS:
        SHOW("STRING_LENGTH bad number of args",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

STRING_LENGTH_BAD_TYPE:
        SHOW("STRING_LENGTH - bad arg type",INDD(FPARG(IMM(2)),IMM(0)));
        STOP_MACHINE ;
        return 1;
