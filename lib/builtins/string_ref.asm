
STRING_REF:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(2));              //arg count check
        JUMP_NE(STRING_REF_BAD_ARG_COUNT);

        /* Validate Argumet Types*/

        CMP(INDD(FPARG(2), IMM(0)), T_STRING);
        JUMP_NE(STRING_REF_BAD_TYPE);
        
        CMP(INDD(FPARG(3),0), T_INTEGER); 
        JUMP_NE(STRING_REF_BAD_TYPE);
        
        
        MOV(R0, INDD(FPARG(IMM(3)), IMM(1)));   //r0 = index
        CMP(R0, INDD(FPARG(IMM(2)), IMM(1)));    
        JUMP_GT (STRING_REF_INDEX_OUTOFBAND);   //index is out of band

        /* make sob char */
        PUSH(INDD(FPARG(2), R0+2));
        CALL(MAKE_SOB_CHAR);
        DROP(1)
        
        POP(FP);
        RETURN;

STRING_REF_BAD_ARG_COUNT:
        SHOW("STRING_REF bad args count", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

STRING_REF_BAD_TYPE:
        SHOW("STRING_REF - bad types", R0);
        STOP_MACHINE ;
        return 1;

STRING_REF_INDEX_OUTOFBAND:
        SHOW("STRING_REF index is out of band", INDD(FPARG(IMM(3)), IMM(1)));
        STOP_MACHINE ;
        return 1;