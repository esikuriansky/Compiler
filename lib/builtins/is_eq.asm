
IS_EQ:
        PUSH(FP);
        MOV(FP, SP);
        CMP(FPARG(1),IMM(2)); //arg count check
        JUMP_NE(IS_EQ_NOT_VALID_ARGUMENTS);

        MOV(R0,IMM(SOB_BOOL_TRUE));
        
        CMP(IND(FPARG(2)),IND(FPARG(3))); //checks if same type
        JUMP_NE(IS_EQ_FALSE);

        //check if type is simple int/char/symbol

        CMP(IND(FPARG(2)),T_INTEGER) ;
        JUMP_EQ(IS_EQ_SIMPLE);
        CMP(IND(FPARG(2)),T_CHAR) ;
        JUMP_EQ(IS_EQ_SIMPLE);
        CMP(IND(FPARG(2)),T_SYMBOL) ;
        JUMP_EQ(IS_EQ_SIMPLE);
        
        JUMP_NE(IS_EQ_COMPLEX); //type is not simple

IS_EQ_SIMPLE:
        CMP(INDD(FPARG(2),1),INDD(FPARG(3),1))  ; //checks if same value
        JUMP_NE(IS_EQ_FALSE);
        JUMP(IS_EQ_DONE);

IS_EQ_COMPLEX:
        CMP(FPARG(2),FPARG(3)); //checks addresses are equal
        JUMP_EQ(IS_EQ_DONE);

IS_EQ_FALSE:
        MOV(R0,IMM(SOB_BOOL_FALSE));

IS_EQ_DONE:
        POP(FP);
        RETURN;

IS_EQ_NOT_VALID_ARGUMENTS:
        SHOW("IS_EQ bad arg count",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;