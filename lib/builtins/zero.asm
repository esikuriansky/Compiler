
ZERO:
        PUSH(FP);
        MOV(FP, SP);
     
        CMP(FPARG(1),IMM(1)); 
        JUMP_NE(ZERO_NOT_VALID_ARGUMENTS) ;

        CMP(INDD(FPARG(2),0),T_INTEGER); 
        JUMP_NE(ZERO_NOT_A_INTEGER) ;
        
        //it's zero
        MOV(R0,IMM(SOB_BOOL_TRUE));
        CMP(IMM(0),INDD(FPARG(2),1));
        JUMP_EQ(ZERO_DONE);
        
        //it's not zero
        MOV(R0,IMM(SOB_BOOL_FALSE));

ZERO_DONE:
        POP(FP);
        RETURN;

ZERO_NOT_VALID_ARGUMENTS:
        SHOW("[ZERO] Wrong num of args.",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

ZERO_NOT_A_INTEGER:
        SHOW("[ZERO] Non-valid argument type.",INDD(FPARG(2),0));
        STOP_MACHINE ;
        return 1;
