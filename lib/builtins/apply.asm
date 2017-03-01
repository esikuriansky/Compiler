
PAPPLY:
	PUSH(FP);
	MOV(FP, SP);
	// CALL(PRINT_STACK);

	/* Assert params amount */
	CMP(FPARG(1), IMM(2));
	JUMP_NE(PAPPLY_BAD_ARGS);

	/* Assert function */
	MOV(R1, FPARG(2));		/* function */
	CMP(INDD(R1, 0), T_CLOSURE);
	JUMP_NE(PAPPLY_BAD_ARGS);

	MOV(R4, IMM(0));			/* parameters amount counter */
	MOV(R1, FPARG(3));			/* param list */

	MOV(R2, SP);				/* save current SP for later use */
	/* Push all parameters in list */
PAPPLY_PUSH_LOOP:
    CMP(R1, SOB_NIL);
    JUMP_EQ(PAPPLY_PUSH_LOOP_DONE);
   	PUSH(INDD(R1,1));
   	INCR(R4);
    MOV(R1, INDD(R1, 2));
    JUMP(PAPPLY_PUSH_LOOP);
PAPPLY_PUSH_LOOP_DONE:

	/* Reverse order in stack (from R2 <--> R1) */
	MOV(R1, SP);
	DECR(R1);
PAPPLY_REVERSE_LOOP:
	// printf("Swapping indexed: %ld <> %ld\n", R2, R1);
	CMP(R2, R1);
	JUMP_GE(PAPPLY_REVERSE_LOOP_DONE);

	// printf("Swapping values: %ld <> %ld\n", STACK(R2), STACK(R1));
	MOV(R3, STACK(R2));
	MOV(STACK(R2), STACK(R1));
	MOV(STACK(R1), R3);

	INCR(R2);
	DECR(R1);
	JUMP(PAPPLY_REVERSE_LOOP);
PAPPLY_REVERSE_LOOP_DONE:

	/* Create new stack */
	// printf("Total arguments: %ld\n", R4);

	PUSH(R4);				/* amount of parameters */
	
	MOV(R1, FPARG(2));		/* function */
	PUSH(INDD(R1, 1));		 /* env */

	PUSH(FPARG(-1));		/* previous return address */

	/* backup original FP */
	MOV(R2, FPARG(-2));

	/* Copy stack */
	ADD(R4, 3);		/* amount is number of args + param count + env + ret */
	PUSH(R4);	/* amount */

	PUSH(FP);	/* source (our new stack) */

	/* destination */
	MOV(R3, FP);
	SUB(R3, 4);				/* arg-count, env, ret, oldfp */
	SUB(R3, FPARG(1));		/* orignial amount of argument that was sent to function */
	PUSH(R3);

	CALL(STACKCPY);
	DROP(3);

	/* Fix FP/SP */
	MOV(FP, R2);	/* original FP (e.g. end of new stack) */

	ADD(R3, R4);
	MOV(SP, R3);

	
	// CALL(PRINT_STACK);
	JUMPA((void *) INDD(R1, 2));

	/* SHOULD NEVER COME HERE */
    POP(FP);
    RETURN;

// 	CMP(IND(R1), T_NIL);
// 	JUMP_EQ(L_PRIM_APPLY_LIST_LOOP1_END);
	 
// 	PUSH(1);
// 	CALL(MALLOC);
// 	DROP(1);
// 	MOV(IND(R0), INDD(R1, 1));
// 	MOV(R1, INDD(R1, 2));
// 	INCR(R2);
// 	JUMP(L_PRIM_APPLY_LIST_LOOP1_END);

// L_PRIM_APPLY_LIST_LOOP1_END:
// 	MOV(R1, R0);				 the place of the last element of the list in the mem 
// 	SUB(R1, R2); 				/* the first element of the list in the mem */				

// L_PRIM_APPLY_LIST_LOOP2:
// 	CMP(R0, R1);
// 	JUMP_EQ(L_PRIM_APPLY_LIST_LOOP2_END);

// 	PUSH(IND(R0));
// 	DECR(R0);
// 	JUMP(L_PRIM_APPLY_LIST_LOOP2);

// L_PRIM_APPLY_LIST_LOOP2_END:

	// PUSH(R2);					/* push amount of arguments */
	// PUSH(INDD(R3, 1));		/* push the env of the function!!!! */
	// PUSH(SOB_RETURNPOINT);			/* push the old Return point */

	// MOV(R1, R2);
	// ADD(R1, 3);
	// MOV(R2, SOB_OLDFP);		/* save the old FP */
	// MOV(R4, FP);
	// SUB(R4, 4);
	// SUB(R4, SCMNARGS);
	// PUSH(R4);					 the start of the old array in the stack 
	// PUSH(FP);					/* the start of the new array in the stack */
	// PUSH(R1);					/* amount of elements to copy */
	// CALL(STACKCPY);
	// DROP(3);
	// MOV(FP, R2);				/* copy the old FP to the new FP (we push and save the FP in the start of each function) */
	// ADD(R4, R1);
	// MOV(SP, R4);

	// JUMPA(INDD(R3, 2));

	/* will never get here */
	RETURN;
	/* will never get here */


PAPPLY_BAD_ARGS:
        SHOW("APPLY: bad arguments:", FPARG(1)) ;
        STOP_MACHINE ;
        return 1;
