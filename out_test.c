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

// Making STRING object
PUSH(IMM(111));
PUSH(IMM(100));
PUSH(IMM(100));
PUSH(IMM(45));
PUSH(IMM(50));
PUSH(IMM(5));
CALL(MAKE_SOB_STRING);
DROP(6);

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
PUSH(IMM(111));
PUSH(IMM(100));
PUSH(IMM(100));
PUSH(IMM(45));
PUSH(IMM(53));
PUSH(IMM(5));
CALL(MAKE_SOB_STRING);
DROP(6);

// Makeing SYMBOL object
PUSH(IMM(24));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making STRING object
PUSH(IMM(111));
PUSH(IMM(100));
PUSH(IMM(100));
PUSH(IMM(101));
PUSH(IMM(114));
PUSH(IMM(45));
PUSH(IMM(53));
PUSH(IMM(7));
CALL(MAKE_SOB_STRING);
DROP(8);

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

// Making INT object
PUSH(IMM(100));
CALL(MAKE_SOB_INTEGER);
DROP(1);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/


// Space for sym: positive?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: number?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: >
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: even?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: zero?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: -
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: +
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: *
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);
/**************************************************/
/* Update primitive symbols */
/**************************************************/

PUSH(LABEL(IS_NUMBER));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(53), R0);

PUSH(LABEL(GREATER));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(54), R0);

PUSH(LABEL(ZERO));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(56), R0);

PUSH(LABEL(MINUS));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(57), R0);

PUSH(LABEL(PLUS));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(58), R0);

PUSH(LABEL(MULTIPLY));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(59), R0);



/*=============================*/
/*         Compiled code       */
/*=============================*/


// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE6));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE6);
L_CLOSURE6:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(53));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE3);

// ---applic-tc---
MOV(R0, IMM(8));
PUSH(R0);

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(54));

// validate closure
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
MOV(R1, FPARG(-2));
PUSH(FPARG(-1));

// overwrite old-fp
PUSH(IMM(5));
PUSH(FP);
MOV(R2, FP);
SUB(R2, 4);
SUB(R2, FPARG(1));
PUSH(R2);     
CALL(STACKCPY);
MOV(FP, R1); 
ADD(R2, 5);
MOV(SP, R2);
JUMPA((void *) INDD(R0, 2));

JUMP(L_IF3_DONE3);
L_IF3_ELSE3:
MOV(R0, IMM(6));

L_IF3_DONE3:

POP(FP);
RETURN;
L_CLOSURE_DONE6:

MOV(IND(52), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT1);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT1:

// ---define--- 

//---applic---
MOV(R0, IMM(6));
PUSH(R0);
MOV(R0, IMM(6));
PUSH(R0);
MOV(R0, IMM(6));
PUSH(R0);
MOV(R0, IMM(6));
PUSH(R0);
PUSH(IMM(4));

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE5));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE5);
L_CLOSURE5:
PUSH(FP);
MOV(FP, SP);

// ---seq--- 
 MOV(R11, FPARG(2));
 PUSH(IMM(1));
 CALL(MALLOC);
 DROP(1);
 MOV(IND(R0), R11);
MOV(FPARG(2), R0);
MOV(R0, IMM(1))

 MOV(R11, FPARG(3));
 PUSH(IMM(1));
 CALL(MALLOC);
 DROP(1);
 MOV(IND(R0), R11);
MOV(FPARG(3), R0);
MOV(R0, IMM(1))

 MOV(R11, FPARG(4));
 PUSH(IMM(1));
 CALL(MALLOC);
 DROP(1);
 MOV(IND(R0), R11);
MOV(FPARG(4), R0);
MOV(R0, IMM(1))

 MOV(R11, FPARG(5));
 PUSH(IMM(1));
 CALL(MALLOC);
 DROP(1);
 MOV(IND(R0), R11);
MOV(FPARG(5), R0);
MOV(R0, IMM(1))

MOV(R1, FPARG(2));

//---lambda-code---
// Init env 
PUSH(IMM(2));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 1; ++i, ++j)
{
		MOV(INDD(R1,IMM(j)), INDD(R2, IMM(i)));
}

// Allocate memory for env
PUSH(FPARG(IMM(1)));
CALL(MALLOC);
DROP(1);

// Expand env with params
for (i=0;i<FPARG(IMM(1));++i)
{
  	MOV(INDD(R0,i),FPARG((IMM(2+i))));
}

// Update env 
MOV(INDD(R1, 0), R0);
PUSH(LABEL(L_CLOSURE3));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE3);
L_CLOSURE3:
PUSH(FP);
MOV(FP, SP);


// ---or--- exp 

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(56));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
CMP(R0, SOB_BOOL_FALSE);
JUMP_NE(L_OR_DONE2);

// ---applic-tc---
MOV(R0, IMM(19));
PUSH(R0);

//---applic---
MOV(R0, IMM(10));
PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(57));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// odd-2?
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 1));

 MOV(R0,IND(R0));

// validate closure
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
MOV(R1, FPARG(-2));
PUSH(FPARG(-1));

// overwrite old-fp
PUSH(IMM(5));
PUSH(FP);
MOV(R2, FP);
SUB(R2, 4);
SUB(R2, FPARG(1));
PUSH(R2);     
CALL(STACKCPY);
MOV(FP, R1); 
ADD(R2, 5);
MOV(SP, R2);
JUMPA((void *) INDD(R0, 2));
CMP(R0, SOB_BOOL_FALSE);
JUMP_NE(L_OR_DONE2);

L_OR_DONE2:

POP(FP);
RETURN;
L_CLOSURE_DONE3:

MOV(IND(R1), R0);
MOV(R1, FPARG(3));

//---lambda-code---
// Init env 
PUSH(IMM(2));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 1; ++i, ++j)
{
		MOV(INDD(R1,IMM(j)), INDD(R2, IMM(i)));
}

// Allocate memory for env
PUSH(FPARG(IMM(1)));
CALL(MALLOC);
DROP(1);

// Expand env with params
for (i=0;i<FPARG(IMM(1));++i)
{
  	MOV(INDD(R0,i),FPARG((IMM(2+i))));
}

// Update env 
MOV(INDD(R1, 0), R0);
PUSH(LABEL(L_CLOSURE4));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE4);
L_CLOSURE4:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(52));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE2);

// ---applic-tc---

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(3));

// ---fvar---
MOV(R0, IND(58));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(58));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---
MOV(R0, IMM(10));
PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(57));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(3));

// ---bvar---
// even-3?
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 2));

 MOV(R0,IND(R0));

// validate closure
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
MOV(R1, FPARG(-2));
PUSH(FPARG(-1));

// overwrite old-fp
PUSH(IMM(6));
PUSH(FP);
MOV(R2, FP);
SUB(R2, 4);
SUB(R2, FPARG(1));
PUSH(R2);     
CALL(STACKCPY);
MOV(FP, R1); 
ADD(R2, 6);
MOV(SP, R2);
JUMPA((void *) INDD(R0, 2));

JUMP(L_IF3_DONE2);
L_IF3_ELSE2:
MOV(R0, IMM(6));

L_IF3_DONE2:

POP(FP);
RETURN;
L_CLOSURE_DONE4:

MOV(IND(R1), R0);
MOV(R1, FPARG(4));

//---lambda-code---
// Init env 
PUSH(IMM(2));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 1; ++i, ++j)
{
		MOV(INDD(R1,IMM(j)), INDD(R2, IMM(i)));
}

// Allocate memory for env
PUSH(FPARG(IMM(1)));
CALL(MALLOC);
DROP(1);

// Expand env with params
for (i=0;i<FPARG(IMM(1));++i)
{
  	MOV(INDD(R0,i),FPARG((IMM(2+i))));
}

// Update env 
MOV(INDD(R1, 0), R0);
PUSH(LABEL(L_CLOSURE1));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1);
L_CLOSURE1:
PUSH(FP);
MOV(FP, SP);


// ---or--- exp 

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(56));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
CMP(R0, SOB_BOOL_FALSE);
JUMP_NE(L_OR_DONE1);

// ---applic-tc---
MOV(R0, IMM(45));
PUSH(R0);
MOV(R0, IMM(31));
PUSH(R0);

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(59));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(58));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---
MOV(R0, IMM(10));
PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(57));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(5));

// ---bvar---
// odd-5?
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 3));

 MOV(R0,IND(R0));

// validate closure
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
MOV(R1, FPARG(-2));
PUSH(FPARG(-1));

// overwrite old-fp
PUSH(IMM(8));
PUSH(FP);
MOV(R2, FP);
SUB(R2, 4);
SUB(R2, FPARG(1));
PUSH(R2);     
CALL(STACKCPY);
MOV(FP, R1); 
ADD(R2, 8);
MOV(SP, R2);
JUMPA((void *) INDD(R0, 2));
CMP(R0, SOB_BOOL_FALSE);
JUMP_NE(L_OR_DONE1);

L_OR_DONE1:

POP(FP);
RETURN;
L_CLOSURE_DONE1:

MOV(IND(R1), R0);
MOV(R1, FPARG(5));

//---lambda-code---
// Init env 
PUSH(IMM(2));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 1; ++i, ++j)
{
		MOV(INDD(R1,IMM(j)), INDD(R2, IMM(i)));
}

// Allocate memory for env
PUSH(FPARG(IMM(1)));
CALL(MALLOC);
DROP(1);

// Expand env with params
for (i=0;i<FPARG(IMM(1));++i)
{
  	MOV(INDD(R0,i),FPARG((IMM(2+i))));
}

// Update env 
MOV(INDD(R1, 0), R0);
PUSH(LABEL(L_CLOSURE2));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE2);
L_CLOSURE2:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(52));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE1);

// ---applic-tc---

//---applic---
MOV(R0, IMM(10));
PUSH(R0);

// ---pvar---
// n
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(57));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---bvar---
// even-1?
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));

 MOV(R0,IND(R0));

// validate closure
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
MOV(R1, FPARG(-2));
PUSH(FPARG(-1));

// overwrite old-fp
PUSH(IMM(4));
PUSH(FP);
MOV(R2, FP);
SUB(R2, 4);
SUB(R2, FPARG(1));
PUSH(R2);     
CALL(STACKCPY);
MOV(FP, R1); 
ADD(R2, 4);
MOV(SP, R2);
JUMPA((void *) INDD(R0, 2));

JUMP(L_IF3_DONE1);
L_IF3_ELSE1:
MOV(R0, IMM(6));

L_IF3_DONE1:

POP(FP);
RETURN;
L_CLOSURE_DONE2:

MOV(IND(R1), R0);

// ---pvar---
// even-1?
MOV(R0, FPARG(2));

 MOV(R0,IND(R0));

POP(FP);
RETURN;
L_CLOSURE_DONE5:

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

MOV(IND(55), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT2);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT2:

//---applic---
MOV(R0, IMM(50));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(55));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
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
