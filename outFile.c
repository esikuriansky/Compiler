#include <stdio.h>
#include <string.h>
#include <string.h>
#include "cisc.h"

#define DO_SHOW 1

int main()
{
START_MACHINE;

JUMP(CONTINUE);
int i,j;

#define SOB_SYM_LIST 1
#define SOB_VOID  2
#define SOB_NIL   3
#define SOB_BOOL_TRUE 4
#define SOB_BOOL_FALSE 6

#include "char.lib"
#include "io.lib"
#include "math.lib"
#include "string.lib"
#include "system.lib"
#include "scheme.lib"

#include "builtins.lib"

CONTINUE:

/*==================*/
/* Init symbol list */
/*==================*/
PUSH(1);
CALL(MALLOC);
DROP(1);
MOV(IND(R0), SOB_NIL);


/*=============================*/
/*   Const table cgen code     */
/*=============================*/

// Making VOID object
CALL(MAKE_SOB_VOID); 

// Making NIL object
CALL(MAKE_SOB_NIL);

// Making BOOL object
PUSH(IMM(1));
CALL(MAKE_SOB_BOOL);
DROP(1);

// Making BOOL object
PUSH(IMM(0));
CALL(MAKE_SOB_BOOL);
DROP(1);

// Making INT object
PUSH(IMM(1));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(3));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(4));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(5));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(7));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(8));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(9));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(0));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-3/4));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(5/6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(12));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(13));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(14));
CALL(MAKE_SOB_INTEGER);
DROP(1);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/

/**************************************************/
/* Update primitive symbols */
/**************************************************/



/*=============================*/
/*         Compiled code       */
/*=============================*/


//---applic---
MOV(R0, IMM(18));
PUSH(R0);
MOV(R0, IMM(16));
PUSH(R0);
MOV(R0, IMM(14));
PUSH(R0);
MOV(R0, IMM(12));
PUSH(R0);
MOV(R0, IMM(10));
PUSH(R0);
MOV(R0, IMM(8));
PUSH(R0);
PUSH(IMM(6));

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE20));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE20);
L_CLOSURE20:
PUSH(FP);
MOV(FP, SP);
// ---lambda-opt--- 
// convert optional 
// arguments to list

MOV(R1, FPARG(1));
INCR(R1);
L_OPT_LOOP19:
CMP(2, R1);
JUMP_EQ(L_OPT_LOOP_DONE19);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_OPT_LOOP19);
L_OPT_LOOP_DONE19:
MOV(R1, FPARG(1));
SUB(R1, IMM(1));
PUSH(R1);
CALL(BUILD_LIST);
DROP(1);
DROP(R1);
MOV(R3, SP);
PUSH(R0);
MOV(R1, 2);
L_OPT_NEW_ARGS19:
CMP(1, R1);
JUMP_EQ(L_OPT_NEW_ARGS_DONE19);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_OPT_NEW_ARGS19);
L_OPT_NEW_ARGS_DONE19:
PUSH(IMM(2));
PUSH(FPARG(0));
PUSH(FPARG(-1));
PUSH(FPARG(-2));

PUSH(IMM(6));
PUSH(R3);  /* source */
MOV(R3, FP);
SUB(R3, 4);
SUB(R3, FPARG(1));
PUSH(R3); /* destination */
CALL(STACKCPY);
DROP(3);

ADD(R3, 6);
MOV(FP, R3);
MOV(SP, R3);

// ---pvar---
// y
MOV(R0, FPARG(3));


POP(FP);
RETURN;
L_CLOSURE_DONE20:

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));


/*==============================*/
/*    Finished compiling code   */
/*==============================*/
/* Display result on STDOUT */
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);

OUT(2,10);
STOP_MACHINE;
	return 0;

L_RUNTIME_ERROR:
	printf("Runtime error!\n");

STOP_MACHINE;

return 1;
}
