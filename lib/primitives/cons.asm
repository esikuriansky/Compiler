
CONS:
        PUSH(FP);
        MOV(FP, SP);
        

        PUSH(FPARG(3));
        PUSH(FPARG(2));
        CALL(MAKE_SOB_PAIR);
        DROP(2);

        POP(FP);
        RETURN;
