
STRING_TO_SYMBOL:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);

	/* verify arguments */
	CMP(FPARG(1), 1);
	JUMP_NE(STRING_TO_SYMBOL_INVALID_ARGUMENTS);

	/* Take pointer to head of list */
	MOV(R2, IND(SOB_SYM_LIST));

	/* Load user argument string */
	MOV(R4, FPARG(2));		/* string */
	
STRING_TO_SYMBOL_LOOP:
	CMP(R2, SOB_NIL);
	JUMP_EQ(STRING_TO_SYMBOL_NOT_FOUND);

	/* Load current symbol string*/
	MOV(R3, INDD(R2, 1));	/* (car pair) => symbol */
  	MOV(R3, INDD(R3, 1)); 	/*  symbol[1] => string */

	/* Compare string length */
	CMP(INDD(R4, 1), INDD(R3, 1));
	JUMP_NE(STRING_CMP_NEXT);
  	
	/* Compare strings */
	MOV(R5, INDD(R4, 1)); // ptr to first char
	ADD(R5, 1);
STRING_CMP_LOOP:
	// SHOW("", R5);
	CMP(R5, 1); /* if end*/
	JUMP_EQ(STRING_FOUND);

	/* if chars does not match - jump next*/
	CMP(INDD(R4, R5), INDD(R3, R5));
	JUMP_NE(STRING_CMP_NEXT);
	// printf("Char: %c - %c\n", INDD(R4, R5), INDD(R3, R5));

	DECR(R5);
	JUMP(STRING_CMP_LOOP);

STRING_CMP_DONE_AND_NOT_MATCH:


	// /* Check if symbol is allocated (sometimes the*/
	// CMP(R1, T_SYMBOL);
	// JUMP_NE(STRING_TO_SYMBOL_INVALID_ARGUMENTS);  /* should look for next symbol? */
	// printf("X");
	// PUSH(R3);
	// CALL(WRITE_SOB);
	// DROP(1);
	// printf("Z\n");
	// SHOW("R2 Value:", R2);

	/* Find string */
	// MOV(R2,INDD(R1,1));	/* R2 = Addr of String */
	// SHOW("AAA", R2);

	/* goto next symbol */
	// SHOW("Next: ", INDD(R1,0));
STRING_CMP_NEXT:
	MOV(R2, INDD(R2,2));
	JUMP(STRING_TO_SYMBOL_LOOP);

// 	MOV(R2,INDD(R1,0));
// 	PUSH(R2);
// 	PUSH(FPARG(IMM(2)));
// 	CALL(STRING_COMPARE);
// 	DROP(2);
// 	CMP(R0,SOB_BOOLEAN_TRUE);
// 	JUMP_NE(STRING_TO_SYMBOL_SEARCH_STRING_LOOP);
// 	JUMP(STRING_TO_SYMBOL_END);

STRING_FOUND:
	MOV(R0, INDD(R2, 1));
	JUMP(STRING_TO_SYM_EXIT);


STRING_TO_SYMBOL_NOT_FOUND:
	// SHOW("dine", R0);

	/* make symbol*/
	PUSH(R4); /* the original string */
	CALL(MAKE_SOB_SYMBOL);
	DROP(1);
	MOV(R1, R0); /* save ptr*/

	/* Allocate Link-Chain (3 items) */
	PUSH(IND(SOB_SYM_LIST));
	PUSH(R1);
	CALL(MAKE_SOB_PAIR);
	DROP(2);
	MOV(IND(SOB_SYM_LIST), R0);
	MOV(R0, R1);


STRING_TO_SYM_EXIT:
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;

STRING_TO_SYMBOL_INVALID_ARGUMENTS:
    SHOW("Runtime error: STRING_TO_SYMBOL Invalid arguments: ",FPARG(1));
    STOP_MACHINE;
    return 1;
