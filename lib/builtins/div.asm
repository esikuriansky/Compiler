
PDIV:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(2))     ; //checks num of args = 2
        JUMP_NE(DIV_BAD_ARGS) ;

    	MOV(R0,INDD(FPARG(2),1));
        DIV(R0,INDD(FPARG(3),1));
        
        PUSH(R0);
        CALL(MAKE_SOB_INTEGER);
        DROP(IMM(1));
        
        POP(FP);
        RETURN;

DIV_BAD_ARGS:
        SHOW("DIV: bad args number:", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;
