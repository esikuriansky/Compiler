

VECTOR_SET:
        PUSH(FP);
        MOV(FP, SP);
        CMP(FPARG(1),IMM(3));            
        JUMP_NE(VECTOR_SET_BAD_ARG_COUNT);

        CMP(INDD(FPARG(IMM(2)),IMM(0)),T_VECTOR);
        JUMP_NE(VECTOR_SET_BAD_TYPE);
        
        CMP(INDD(FPARG(3),0), T_INTEGER); 
        JUMP_NE(VECTOR_SET_BAD_TYPE);
        
        MOV(R0, INDD(FPARG(IMM(3)), IMM(1)));  
        CMP(R0, INDD(FPARG(IMM(2)), IMM(1)));    
        JUMP_GT (VECTOR_SET_INDEX_OUTOFBAND);   

        MOV(INDD(FPARG(IMM(2)), R0+2), FPARG(4)); 
        
        MOV(R0, SOB_VOID);
        POP(FP);
        RETURN;

VECTOR_SET_BAD_ARG_COUNT:
        SHOW("VECTOR_SET bad args count", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

VECTOR_SET_BAD_TYPE:
        SHOW("VECTOR_SET - bad types", R0);
        STOP_MACHINE ;
        return 1;

VECTOR_SET_INDEX_OUTOFBAND:
        SHOW("VECTOR_SET index is out of band", INDD(FPARG(IMM(3)), IMM(1)));
        STOP_MACHINE ;
        return 1;