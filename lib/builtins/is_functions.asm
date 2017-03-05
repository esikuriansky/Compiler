IS_STRING:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_STRING); 
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);

IS_A_STRING:
    PUSH(FP);
    MOV(FP, SP);
    MOV(R1, FPARG(2));
    CMP(INDD(R1, 0), T_STRING);
    JUMP_EQ(RETURN_TRUE);
    JUMP(RETURN_FALSE);

IS_INTEGER:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2));
    CALL(IS_SOB_INTEGER);
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);

IS_NUMBER:
    JUMP(IS_RATIONAL);

IS_RATIONAL:
    PUSH(FP);
    MOV(FP, SP);
    MOV(R0, FPARG(2));
    CMP(IND(R0), IMM(T_INTEGER));
    JUMP_EQ(RETURN_TRUE);
    CMP(IND(R0), IMM(T_FRACTION));
    JUMP_EQ(RETURN_TRUE);
    JUMP(RETURN_FALSE);

IS_BOOL:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_BOOL); 
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);

IS_CLOSURE:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_CLOSURE); 
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


IS_CHAR:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_CHAR);
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


IS_NILL:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_NIL); 
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


IS_VOID:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2));
    CALL(IS_SOB_VOID);
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


IS_PAIR:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_PAIR);
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


IS_VECTOR:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_VECTOR); 
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


IS_SYMBOL:
    PUSH(FP);
    MOV(FP, SP);
    PUSH(FPARG(2)); 
    CALL(IS_SOB_SYMBOL); 
    DROP(1);
    CMP(R0, IMM(0));
    JUMP_EQ(RETURN_FALSE);
    JUMP(RETURN_TRUE);


    
RETURN_TRUE:
    MOV(R0, SOB_BOOL_TRUE);
    JUMP(_EXIT);

RETURN_FALSE:
    MOV(R0, SOB_BOOL_FALSE);
    JUMP(_EXIT);


_EXIT:
    POP(FP);
    RETURN;
