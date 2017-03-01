
SET_CAR:
        PUSH(FP);
        MOV(FP, SP);

        CMP(FPARG(1),IMM(2));  // arguments number
        JUMP_NE(SET_CAR_NOT_VALID_ARGUMENTS);

        CMP(INDD(FPARG(IMM(2)),IMM(0)),T_PAIR); //bad type
        JUMP_NE(SET_CAR_NOT_A_PAIR);

        MOV(INDD(FPARG(IMM(2)),IMM(1)), FPARG(3)); //set!
        POP(FP);
        RETURN;

SET_CAR_NOT_VALID_ARGUMENTS:
        SHOW("SET_CAR bad number of args",FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

SET_CAR_NOT_A_PAIR:
        SHOW("SET_CAR - arg is not a pair type ",INDD(FPARG(IMM(2)),IMM(0)));
        STOP_MACHINE ;
        return 1;
