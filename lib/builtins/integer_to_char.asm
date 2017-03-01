
INTEGER_TO_CHAR:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(1));
        JUMP_NE(INTEGER_TO_CHAR_BAD_ARGS);

        CMP(INDD(FPARG(2), IMM(0)), T_INTEGER); 
        JUMP_NE(INTEGER_TO_CHAR_BAD_TYPE);

        //create new object
        PUSH(INDD(FPARG(2), 1));
        CALL(MAKE_SOB_CHAR);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

INTEGER_TO_CHAR_BAD_ARGS:
        SHOW("INTEGER_TO_CHAR: bad args number:", FPARG(1));
        STOP_MACHINE ;
        return 1;

INTEGER_TO_CHAR_BAD_TYPE:
        SHOW("INTEGER_TO_CHAR - bad type ", INDD(FPARG(2), IMM(0)));
        STOP_MACHINE ;
        return 1;

