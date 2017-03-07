
ZERO:
        PUSH(FP);
        MOV(FP, SP);
        
        MOV(R0,IMM(SOB_BOOL_TRUE));   

        CMP(INDD(FPARG(2),0),T_INTEGER); 
        JUMP_NE(ZERO_MUST_BE_FRACTION);

        CMP(IMM(0),INDD(FPARG(2),1));
        JUMP_EQ(ZERO_DONE);
        
        //it's not zero
        MOV(R0,IMM(SOB_BOOL_FALSE));
        JUMP(ZERO_DONE);

ZERO_MUST_BE_FRACTION:

        CMP(IMM(0), INDD(FPARG(2), 2));
        JUMP_EQ(ZERO_DONE);
        MOV(R0,IMM(SOB_BOOL_FALSE));

ZERO_DONE:
        POP(FP);
        RETURN;
