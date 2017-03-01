
BIN_LT:
        PUSH(FP);
        MOV(FP, SP);
       
        CMP(FPARG(1),IMM(2))     ; //checks num of args = 2
        JUMP_NE(BIN_LT_NOT_VALID_ARGUMENTS) ;
       
        MOV(R0,IMM(SOB_BOOL_TRUE));
        CMP(INDD(FPARG(2),1),INDD(FPARG(3),1));
        JUMP_LT(BIN_LT_DONE);
        
        MOV(R0,IMM(SOB_BOOL_FALSE));

BIN_LT_DONE:
        POP(FP);
        RETURN;

BIN_LT_NOT_VALID_ARGUMENTS:
        SHOW("BIN_LT bad number of args", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;
