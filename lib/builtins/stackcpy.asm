
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


/*
PRINT_HEAP:
  PUSH(FP);
  MOV(FP, SP);
  PUSH(R1);
  PUSH(R2);
  
  MOV(R1, IND(0));              /* SIZE OF MEM */
  MOV(R2, IMM(0));              /* init counter */
  
  printf("=====================\n");
  printf("HEAP:\n");
  printf("=====================\n");
L_HEAP_LOOP:
  CMP(R1, R2);
  JUMP_EQ(L_HEAP_EXIT);
  printf("[CELL: ");
  printf("%ld ", R2);
  printf(" ] ");
  printf("%ld ", IND(R2));
  printf("\n");
  INCR(R2);
  JUMP(L_HEAP_LOOP);

L_HEAP_EXIT:
  POP(R2);
  POP(R1);
  POP(FP);
  printf("\n");
  RETURN;
 


PRINT_STACK:
  PUSH(FP);
  MOV(FP, SP);
  PUSH(R1);
  PUSH(R2);
  
  MOV(R1, IMM(20));             /* SIZE of stack to print */
  MOV(R2, IMM(-1));             /* counter */
  
  printf("=====================\n");
  printf("STACK:\n");
  printf("=====================\n");
L_STACK_LOOP:
  CMP(R1, R2);
  JUMP_EQ(L_STACK_EXIT);
  
  printf("[CELL: ");
  printf("%ld ", R1);
  printf(" ] ");
  printf("%ld ", STACK(R1));
  printf("\n");
  DECR(R1);
  JUMP(L_STACK_LOOP);

L_STACK_EXIT:
  POP(R2);
  POP(R1);
  POP(FP);
  printf(" SP = ");
  printf("%ld ", SP - 1);
  printf("FP=%ld ", FP);
  printf("\n");
  RETURN;
  */
 