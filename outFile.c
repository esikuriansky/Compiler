#include <stdio.h>
#include <string.h>
#include <string.h>
#include "cisc.h"

int main()
{
START_MACHINE;

JUMP(CONTINUE);
#define DO_SHOW 1

int i,j;

#define SOB_SYM_LIST 1
#define SOB_VOID  2
#define SOB_NIL   3
#define SOB_BOOL_TRUE 4
#define SOB_BOOL_FALSE 6
#define SOB_ZERO 8

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
PUSH(IMM(0));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making STRING object
PUSH(IMM(120));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(12));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(20));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making STRING object
PUSH(IMM(98));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(28));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making STRING object
PUSH(IMM(99));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(36));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making STRING object
PUSH(IMM(100));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(44));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making STRING object
PUSH(IMM(101));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(52));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/


// Space for sym: vector-set!
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: vector
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);
/**************************************************/
/* Update primitive symbols */
/**************************************************/

PUSH(LABEL(VECTOR_SET));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(60), R0);



/*=============================*/
/*         Compiled code       */
/*=============================*/


//---applic---

//---applic---
MOV(R0, IMM(55));
PUSH(R0);
MOV(R0, IMM(47));
PUSH(R0);
MOV(R0, IMM(39));
PUSH(R0);
MOV(R0, IMM(31));
PUSH(R0);
MOV(R0, IMM(23));
PUSH(R0);
PUSH(IMM(5));

// ---fvar---
MOV(R0, IND(61));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1);
L_CLOSURE1:
PUSH(FP);
MOV(FP, SP);

// ---seq--- 

//---applic---
MOV(R0, IMM(15));
PUSH(R0);
MOV(R0, IMM(10));
PUSH(R0);

// ---pvar---
// v
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(3));

// ---fvar---
MOV(R0, IND(60));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

// ---pvar---
// v
MOV(R0, FPARG(2));


POP(FP);
RETURN;
L_CLOSURE_DONE1:

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT1);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT1:



/*==============================*/
/*    Finished compiling code   */
/*==============================*/
STOP_MACHINE;
	return 0;

L_RUNTIME_ERROR:
	printf("Error :( !\n");

STOP_MACHINE;

return 1;
}
