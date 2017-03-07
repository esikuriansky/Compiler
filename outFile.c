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

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(18));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making vector object
PUSH(IMM(10));
PUSH(IMM(12));
PUSH(IMM(14));
PUSH(IMM(16));
PUSH(IMM(21));

PUSH(IMM(5));
CALL(MAKE_SOB_VECTOR);
DROP(6);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/


// Space for sym: x
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: vector-set!
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
MOV(IND(34), R0);



/*=============================*/
/*         Compiled code       */
/*=============================*/


// ---define--- 
MOV(R0, IMM(26));

MOV(IND(33), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT1);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT1:

//---applic---
MOV(R0, IMM(4));
PUSH(R0);
MOV(R0, IMM(10));
PUSH(R0);

// ---fvar---
MOV(R0, IND(33));
PUSH(R0);
PUSH(IMM(3));

// ---fvar---
MOV(R0, IND(34));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT2);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT2:

// ---fvar---
MOV(R0, IND(33));
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT3);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT3:





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
