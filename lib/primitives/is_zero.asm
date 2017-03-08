
ZERO:
        PUSH(FP);
        MOV(FP, SP);
     
        MOV(R0,IMM(SOB_BOOL_TRUE));
        CMP(IMM(0),INDD(FPARG(2),1));
        JUMP_EQ(ZERO_DONE);
        
        MOV(R0,IMM(SOB_BOOL_FALSE));

ZERO_DONE:
        POP(FP);
        RETURN;

