
STRING_SET:
        PUSH(FP);
        MOV(FP, SP);
        CMP(FPARG(1),IMM(3));              //arg count check
        JUMP_NE(STRING_SET_BAD_ARG_COUNT);

        /* Validate Argumet Types*/

        CMP(INDD(FPARG(IMM(2)),IMM(0)),T_STRING);
        JUMP_NE(STRING_SET_BAD_TYPE);
        
        CMP(INDD(FPARG(3),0), T_INTEGER); 
        JUMP_NE(STRING_SET_BAD_TYPE);
        
        CMP(INDD(FPARG(4),0), T_CHAR); 
        JUMP_NE(STRING_SET_BAD_TYPE);
        
        MOV(R0, INDD(FPARG(IMM(3)), IMM(1)));   //r0 = index
        CMP(R0, INDD(FPARG(IMM(2)), IMM(1)));    
        JUMP_GT (STRING_SET_INDEX_OUTOFBAND);   //index is out of band

        MOV(INDD(FPARG(IMM(2)), R0+2), INDD(FPARG(4),1));   //set! (+2 to skip type and length)
        
        MOV(R0, SOB_VOID);
        POP(FP);
        RETURN;

STRING_SET_BAD_ARG_COUNT:
        SHOW("STRING_SET bad args count", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

STRING_SET_BAD_TYPE:
        SHOW("STRING_SET - bad types", R0);
        STOP_MACHINE ;
        return 1;

STRING_SET_INDEX_OUTOFBAND:
        SHOW("STRING_SET index is out of band", INDD(FPARG(IMM(3)), IMM(1)));
        STOP_MACHINE ;
        return 1;