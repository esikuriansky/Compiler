VECTOR:
 PUSH(FP);
 MOV(FP,SP);
 PUSH(R1);
 PUSH(R2);
 PUSH(R3);
 MOV(R0, FPARG(1)); 
 CMP(R0,IMM(0));
 JUMP_EQ(VECTOR_NO_ARGS);
 MOV(R1,0);
VECTOR_LOOP:
 PUSH(FPARG(R1 + 2));
 ADD(R1, 1);
 CMP(R1, R0);
 JUMP_NE(VECTOR_LOOP);
 PUSH(R1);
 CALL(MAKE_SOB_VECTOR);
 DROP(1);
 DROP(R1);
 JUMP(VECTOR_DONE);
VECTOR_NO_ARGS:
 PUSH(T_NIL);
 PUSH(IMM(0));
 CALL(MAKE_SOB_VECTOR);
 DROP(2);
 JUMP(VECTOR_DONE);
VECTOR_DONE:
 POP(R3);  
 POP(R2);  
 POP(R1);   
 POP(FP);     
 RETURN; 