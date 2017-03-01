
VECTOR_REF:
        PUSH(FP);
        MOV(FP, SP);
        CMP(FPARG(1),IMM(2));              //arg count check
        JUMP_NE(VECTOR_REF_BAD_ARG_COUNT);

        /* Validate Argumet Types*/

        CMP(INDD(FPARG(IMM(2)),IMM(0)), T_VECTOR);
        JUMP_NE(VECTOR_REF_BAD_TYPE);
        
        CMP(INDD(FPARG(3),0), T_INTEGER); 
        JUMP_NE(VECTOR_REF_BAD_TYPE);
        
        
        MOV(R0, INDD(FPARG(IMM(3)), IMM(1)));   //r0 = index
        CMP(R0, INDD(FPARG(IMM(2)), IMM(1)));    
        JUMP_GT (VECTOR_REF_INDEX_OUTOFBAND);   //index is out of band

        MOV(R0, INDD(FPARG(IMM(2)), R0+2));   // r0 = VECTOR[index] (+2 to skip type and length)
        
        POP(FP);
        RETURN;

VECTOR_REF_BAD_ARG_COUNT:
        SHOW("VECTOR_REF bad args count", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;

VECTOR_REF_BAD_TYPE:
        SHOW("VECTOR_REF - bad types", R0);
        STOP_MACHINE ;
        return 1;

VECTOR_REF_INDEX_OUTOFBAND:
        SHOW("VECTOR_REF index is out of band", INDD(FPARG(IMM(3)), IMM(1)));
        STOP_MACHINE ;
        return 1;