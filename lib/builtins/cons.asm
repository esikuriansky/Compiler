
CONS:
        PUSH(FP);
        MOV(FP, SP);
        CMP(FPARG(1),IMM(2));
        JUMP_NE(CONS_BAD_ARG_COUNT);

        //allocate memory for new pair
        PUSH(IMM(3));
        CALL(MALLOC);
        DROP(IMM(1));

        //create new pair
        MOV(IND(R0),IMM(T_PAIR));
        MOV(INDD(R0,IMM(1)),FPARG(IMM(2)));
        MOV(INDD(R0,IMM(2)),FPARG(IMM(3)));

        POP(FP);
        RETURN;

CONS_BAD_ARG_COUNT:
        SHOW("CONS bad arg count", FPARG(1));
        STOP_MACHINE ;
        return 1;
