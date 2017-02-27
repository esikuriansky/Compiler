// UTIL FUNCTIONS



STACKCPY:
        PUSH(FP);
        MOV(FP, SP);
        
        PUSH(R1);
        PUSH(R2);
        PUSH(R3);

        MOV(R1, FPARG(0)); // Destination
        MOV(R2, FPARG(1)); // Source

        /* R3: Counter */
        MOV(R3, FPARG(2));
        // SHOW("Stack pointer: ", R3);

STACKCPY_LOOP:      
        CMP(R3, 0);
        JUMP_EQ(STACKCPY_DONE);

        MOV(STACK(R1), STACK(R2));
        INCR(R1);
        INCR(R2);
  
        DECR(R3);
        JUMP(STACKCPY_LOOP);


STACKCPY_DONE:
        POP(R3);
        POP(R2);
        POP(R1);

        POP(FP);
        RETURN;