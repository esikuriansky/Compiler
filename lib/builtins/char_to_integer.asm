
CHAR_TO_INTEGER:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(1));
        JUMP_NE(CHAR_TO_INTEGER_BAD_ARGS);

        CMP(INDD(FPARG(2), IMM(0)), T_CHAR); 
        JUMP_NE(CHAR_TO_INTEGER_BAD_TYPE);

        //create new object
        PUSH(INDD(FPARG(2), 1));
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

CHAR_TO_INTEGER_BAD_ARGS:
        SHOW("CHAR_TO_INTEGER: bad args number:", FPARG(1));
        STOP_MACHINE ;
        return 1;

CHAR_TO_INTEGER_BAD_TYPE:
        SHOW("CHAR_TO_INTEGER - bad type ", INDD(FPARG(2), IMM(0)));
        STOP_MACHINE ;
        return 1;

