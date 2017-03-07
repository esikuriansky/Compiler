
SET_CDR:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(2));  // arguments number
        JUMP_NE(SET_CDR_NOT_VALID_ARGUMENTS);

        CMP(INDD(FPARG(IMM(2)),IMM(0)),T_PAIR); //bad type
        JUMP_NE(SET_CDR_NOT_A_PAIR);

        MOV(INDD(FPARG(IMM(2)),IMM(2)), FPARG(3)); //set!

        POP(FP);
        RETURN;

SET_CDR_NOT_VALID_ARGUMENTS:
        SHOW("SET_CDR bad number of args",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

SET_CDR_NOT_A_PAIR:
        SHOW("SET_CDR - arg is not a pair type ",INDD(FPARG(IMM(2)),IMM(0)));
        STOP_MACHINE ;
        return 1;
