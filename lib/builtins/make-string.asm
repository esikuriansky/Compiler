

MAKE_STRING:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);

        /* check how many params */
        CMP(FPARG(1),IMM(2)); 
        JUMP_NE(MAKE_STRING_NO_DEFAULT_VALUE);
        
        /* check char arg */
        CMP(INDD(FPARG(3),0), T_CHAR);
        JUMP_NE(MAKE_STRING_INVALID_ARGUMENTS);

        /* load default value */
        MOV(R1,INDD(FPARG(3),1));
        JUMP(MAKE_STRING_FUNC);


MAKE_STRING_NO_DEFAULT_VALUE:
		MOV(R1, -1); /* default value */        

MAKE_STRING_FUNC:
        MOV(R0,INDD(FPARG(2),1)); /* string length */

MAKE_STRING_LOOP:
        CMP(R0, 0);
        JUMP_EQ(MAKE_STRING_DONE);
        PUSH(R1);
        DECR(R0)           ;
        JUMP(MAKE_STRING_LOOP);


MAKE_STRING_DONE:
        PUSH(INDD(FPARG(2),1)); /* string length */
        CALL(MAKE_SOB_STRING);
        DROP(INDD(FPARG(2),1)); /* string lenght */
        DROP(1); /* length number */

        POP(R1);
        POP(FP);
        RETURN;

MAKE_STRING_INVALID_ARGUMENTS:
        SHOW("MAKE_STRING runtime error: invalid argumetns",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;