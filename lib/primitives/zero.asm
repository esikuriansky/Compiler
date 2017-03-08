
ZERO:
        PUSH(FP);
        MOV(FP, SP);
        
        CMP(INDD(FPARG(2),0),T_INTEGER); 
        JUMP_NE(ZERO_CHECK_FRACTION);
        CMP(IMM(0),INDD(FPARG(2),1));
        JUMP_EQ(ZERO_DONE_TRUE);
        JUMP(ZERO_DONE_FALSE);

ZERO_CHECK_FRACTION:
        CMP(IMM(0), INDD(FPARG(2), 2));
        JUMP_EQ(ZERO_DONE_TRUE);

ZERO_DONE_FALSE:
        MOV(R0,IMM(SOB_BOOL_FALSE)); 
        POP(FP);
        RETURN;  

ZERO_DONE_TRUE:
        MOV(R0,IMM(SOB_BOOL_TRUE));   
        POP(FP);
        RETURN;
