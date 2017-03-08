
STACKCPY:
        PUSH(FP);
        MOV(FP, SP);
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        PUSH(R4);

        MOV(R1, FPARG(0)); 
        MOV(R2, FPARG(1)); 
        MOV(R3, FPARG(2));

STACKCPY_LOOP:      
        CMP(R3, 0);
        JUMP_EQ(STACKCPY_DONE);

        MOV(STACK(R1), STACK(R2));
        ADD(R1, 1);
        ADD(R2, 1);
        SUB(R3, 1);;
        JUMP(STACKCPY_LOOP);


STACKCPY_DONE:
        POP(R4);
        POP(R3);
        POP(R2);
        POP(R1);
        POP(FP);
        RETURN;
 