
BIN_EQ:
        PUSH(FP);
        MOV(FP, SP);
       
        CMP(FPARG(1),IMM(2))     ; //checks num of args = 2
        JUMP_NE(BIN_EQ_NOT_VALID_ARGUMENTS) ;
        
        // SHOW("Arg1: ", FPARG(2));
        // SHOW("Arg2: ", FPARG(3));

        MOV(R0,IMM(SOB_BOOL_TRUE));
        CMP(INDD(FPARG(2),1),INDD(FPARG(3),1));
        JUMP_EQ(BIN_EQ_DONE);
        
        MOV(R0,IMM(SOB_BOOL_FALSE));

BIN_EQ_DONE:
        POP(FP);
        RETURN;

BIN_EQ_NOT_VALID_ARGUMENTS:
        SHOW("BIN_EQ bad number of args", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;
