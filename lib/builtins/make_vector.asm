/* 
   FPARG[2] - the len number
   FPARG[3) - fill if given
*/


MAKE_VECTOR:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);

        /* ====== FIND DEFAULT VALUE =====*/
        /* If single argumetn - no default value */
        CMP(FPARG(1), IMM(2)); //checks num of args = 2
        JUMP_NE(MAKE_VECTOR_NO_DEFAULT_VALUE);

        /* If there is default value*/
        MOV(R1,FPARG(3));
        JUMP(MAKE_VECTOR_BODY);

MAKE_VECTOR_NO_DEFAULT_VALUE:
        CMP(FPARG(1),IMM(1)); /* make sure a value has been passed as an arg */
        JUMP_NE(MAKE_VECTOR_INVALID_ARGUMENTS);

        CMP(INDD(FPARG(IMM(2)), IMM(0)),T_INTEGER); //arg type is integer
        JUMP_NE(MAKE_VECTOR_INVALID_ARGUMENTS);

        MOV(R1, SOB_ZERO);

MAKE_VECTOR_BODY:
        MOV(R0,INDD(FPARG(2),1)); /* actual length of list */

        /* Push items to stack */
MAKE_VECTOR_LOOP:
        CMP(R0, 0);
        JUMP_EQ(MAKE_VECTOR_DONE);
        PUSH(R1) ; //initialize the vector with 0
        DECR(R0)           ;
        JUMP(MAKE_VECTOR_LOOP);

MAKE_VECTOR_DONE:
        PUSH(INDD(FPARG(2),1)); /* arg count */
        CALL(MAKE_SOB_VECTOR);
        DROP(INDD(FPARG(2),1)); /* amount of arguments pushed */
        DROP(1); /* length item */
        
        POP(R1);
        POP(FP);
        RETURN;

MAKE_VECTOR_INVALID_ARGUMENTS:
        SHOW("Runtime error: MAKE_VECTOR invalid arguments", FPARG(1));
        STOP_MACHINE;
        return 1;
