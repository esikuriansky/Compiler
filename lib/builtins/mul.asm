

PMUL:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(2))     ; //checks num of args = 2
        JUMP_NE(MUL_BAD_ARGS) ;

    	MOV(R0,INDD(FPARG(2),1));
        MUL(R0,INDD(FPARG(3),1));
        
        PUSH(R0);
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

MUL_BAD_ARGS:
        SHOW("MUL: bad args number:", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;
