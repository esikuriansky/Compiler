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
PUSH(IMM(-1));
CALL(MAKE_SOB_INTEGER);
DROP(1);

PUSH(IMM(1));
PUSH(IMM(1));
PUSH(IMM(2));
CALL(MAKE_SOB_FRACTION);
DROP(3);
// Making INT object
PUSH(IMM(2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(1));
CALL(MAKE_SOB_INTEGER);
DROP(1);

PUSH(IMM(1));
PUSH(IMM(1));
PUSH(IMM(4));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(1));
PUSH(IMM(3));
PUSH(IMM(4));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(0));
PUSH(IMM(-1));
PUSH(IMM(2));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(0));
PUSH(IMM(-3));
PUSH(IMM(4));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(1));
PUSH(IMM(5));
PUSH(IMM(4));
CALL(MAKE_SOB_FRACTION);
DROP(3);
// Making INT object
PUSH(IMM(3));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

PUSH(IMM(1));
PUSH(IMM(2));
PUSH(IMM(3));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(0));
PUSH(IMM(-2));
PUSH(IMM(3));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(1));
PUSH(IMM(3));
PUSH(IMM(2));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(1));
PUSH(IMM(1));
PUSH(IMM(3));
CALL(MAKE_SOB_FRACTION);
DROP(3);
// Making INT object
PUSH(IMM(12));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(5));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-3));
CALL(MAKE_SOB_INTEGER);
DROP(1);

PUSH(IMM(0));
PUSH(IMM(-3));
PUSH(IMM(2));
CALL(MAKE_SOB_FRACTION);
DROP(3);
PUSH(IMM(1));
PUSH(IMM(5));
PUSH(IMM(3));
CALL(MAKE_SOB_FRACTION);
DROP(3);
// Making INT object
PUSH(IMM(24));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Making CHAR object
PUSH(IMM(98));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(18));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(40));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(84));
PUSH(IMM(16));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(87));
PUSH(IMM(18));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(16));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(84));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(96));
PUSH(IMM(93));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(99));
PUSH(IMM(81));
CALL(MAKE_SOB_PAIR);
DROP(2);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/


// Space for sym: cadr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: car
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cdr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cdar
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caar
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cddr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caddr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cdadr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cdaadr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caadr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cdddr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caaar
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caaadr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caaddr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cadddr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cddddr
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: caaaar
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: map
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: null?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cons
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: apply
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: append
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: asaf-lior-one-list-map
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);
/**************************************************/
/* Update primitive symbols */
/**************************************************/

PUSH(LABEL(CAR));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(106), R0);

PUSH(LABEL(CDR));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(107), R0);

PUSH(LABEL(IS_NILL));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(123), R0);

PUSH(LABEL(CONS));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(124), R0);

PUSH(LABEL(L_APPLY));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(125), R0);



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
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1505));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1505);
L_CLOSURE1505:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1505:

MOV(IND(105), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT829);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT829:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1504));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1504);
L_CLOSURE1504:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1504:

MOV(IND(108), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT830);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT830:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1503));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1503);
L_CLOSURE1503:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1503:

MOV(IND(109), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT831);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT831:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1502));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1502);
L_CLOSURE1502:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1502:

MOV(IND(110), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT832);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT832:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1501));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1501);
L_CLOSURE1501:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1501:

MOV(IND(111), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT833);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT833:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1500));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1500);
L_CLOSURE1500:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1500:

MOV(IND(112), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT834);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT834:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1499));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1499);
L_CLOSURE1499:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1499:

MOV(IND(113), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT835);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT835:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1498));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1498);
L_CLOSURE1498:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1498:

MOV(IND(114), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT836);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT836:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1497));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1497);
L_CLOSURE1497:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1497:

MOV(IND(115), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT837);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT837:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1496));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1496);
L_CLOSURE1496:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1496:

MOV(IND(116), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT838);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT838:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1495));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1495);
L_CLOSURE1495:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1495:

MOV(IND(117), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT839);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT839:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1494));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1494);
L_CLOSURE1494:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1494:

MOV(IND(118), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT840);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT840:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1493));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1493);
L_CLOSURE1493:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1493:

MOV(IND(119), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT841);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT841:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1492));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1492);
L_CLOSURE1492:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1492:

MOV(IND(120), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT842);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT842:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1491));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1491);
L_CLOSURE1491:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---applic---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1491:

MOV(IND(121), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT843);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT843:

// ---define--- 

//---applic---

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1490));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1490);
L_CLOSURE1490:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

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
PUSH(LABEL(L_CLOSURE1487));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1487);
L_CLOSURE1487:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---lambda-code---
// Init env 
PUSH(IMM(3));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 2; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1486));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1486);
L_CLOSURE1486:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

// ---pvar---
// z
MOV(R0, FPARG(3));

PUSH(R0);

// ---pvar---
// y
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

//---applic---

// ---bvar---
// x
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));

PUSH(R0);
PUSH(IMM(1));

// ---bvar---
// x
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1486:
PUSH(R0);
PUSH(IMM(1));

// ---bvar---
// f
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


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

POP(FP);
RETURN;
L_CLOSURE_DONE1487:
PUSH(R0);
PUSH(IMM(1));

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
PUSH(LABEL(L_CLOSURE1489));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1489);
L_CLOSURE1489:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---lambda-code---
// Init env 
PUSH(IMM(3));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 2; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1488));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1488);
L_CLOSURE1488:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

// ---pvar---
// z
MOV(R0, FPARG(3));

PUSH(R0);

// ---pvar---
// y
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

//---applic---

// ---bvar---
// x
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));

PUSH(R0);
PUSH(IMM(1));

// ---bvar---
// x
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

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

POP(FP);
RETURN;
L_CLOSURE_DONE1488:
PUSH(R0);
PUSH(IMM(1));

// ---bvar---
// f
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


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

POP(FP);
RETURN;
L_CLOSURE_DONE1489:

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

POP(FP);
RETURN;
L_CLOSURE_DONE1490:
PUSH(R0);
PUSH(IMM(1));

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1485));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1485);
L_CLOSURE1485:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

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
PUSH(LABEL(L_CLOSURE1479));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1479);
L_CLOSURE1479:
PUSH(FP);
MOV(FP, SP);

//---lambda-code---
// Init env 
PUSH(IMM(3));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 2; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1478));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1478);
L_CLOSURE1478:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(123));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE234);
MOV(R0, IMM(3));

JUMP(L_IF3_DONE234);
L_IF3_ELSE234:

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

// ---pvar---
// f
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// map1
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---pvar---
// f
MOV(R0, FPARG(2));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(124));

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

L_IF3_DONE234:

POP(FP);
RETURN;
L_CLOSURE_DONE1478:

POP(FP);
RETURN;
L_CLOSURE_DONE1479:
PUSH(R0);
PUSH(IMM(1));

// ---pvar---
// y
MOV(R0, FPARG(2));


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
PUSH(LABEL(L_CLOSURE1484));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1484);
L_CLOSURE1484:
PUSH(FP);
MOV(FP, SP);

// ---applic-tc---

//---applic---

//---lambda-code---
// Init env 
PUSH(IMM(3));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 2; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1481));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1481);
L_CLOSURE1481:
PUSH(FP);
MOV(FP, SP);

//---lambda-code---
// Init env 
PUSH(IMM(4));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 3; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1480));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1480);
L_CLOSURE1480:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(123));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE235);
MOV(R0, IMM(3));

JUMP(L_IF3_DONE235);
L_IF3_ELSE235:

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);

// ---fvar---
MOV(R0, IND(107));
PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// map1
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 1));
MOV(R0, INDD(R0, 0));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

// ---pvar---
// f
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// maplist
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);

// ---fvar---
MOV(R0, IND(106));
PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// map1
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 1));
MOV(R0, INDD(R0, 0));


// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

// ---pvar---
// f
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(125));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(124));

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

L_IF3_DONE235:

POP(FP);
RETURN;
L_CLOSURE_DONE1480:

POP(FP);
RETURN;
L_CLOSURE_DONE1481:
PUSH(R0);
PUSH(IMM(1));

// ---bvar---
// y
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


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
PUSH(IMM(3));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 2; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1483));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1483);
L_CLOSURE1483:
PUSH(FP);
MOV(FP, SP);

//---lambda-code---
// Init env 
PUSH(IMM(4));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
// Copying old env 
MOV(R2, FPARG(0));
for(i=0, j=1 ; i < 3; ++i, ++j)
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
PUSH(LABEL(L_CLOSURE1482));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1482);
L_CLOSURE1482:
PUSH(FP);
MOV(FP, SP);
// ---lambda-opt--- 
// convert optional 
// arguments to list

MOV(R1, FPARG(1));
INCR(R1);
L_OPT_LOOP47:
CMP(2, R1);
JUMP_EQ(L_OPT_LOOP_DONE47);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_OPT_LOOP47);
L_OPT_LOOP_DONE47:
MOV(R1, FPARG(1));
SUB(R1, IMM(1));
PUSH(R1);
CALL(BUILD_LIST);
DROP(1);
DROP(R1);
MOV(R3, SP);
PUSH(R0);
MOV(R1, 2);
L_OPT_NEW_ARGS47:
CMP(1, R1);
JUMP_EQ(L_OPT_NEW_ARGS_DONE47);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_OPT_NEW_ARGS47);
L_OPT_NEW_ARGS_DONE47:
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

// ---applic-tc---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);

// ---pvar---
// f
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// maplist
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));


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

POP(FP);
RETURN;
L_CLOSURE_DONE1482:

POP(FP);
RETURN;
L_CLOSURE_DONE1483:

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

POP(FP);
RETURN;
L_CLOSURE_DONE1484:

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

POP(FP);
RETURN;
L_CLOSURE_DONE1485:

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

MOV(IND(122), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT844);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT844:

// ---define--- 

//---applic---
MOV(R0, IMM(6));
PUSH(R0);
MOV(R0, IMM(6));
PUSH(R0);
PUSH(IMM(2));

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE1477));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1477);
L_CLOSURE1477:
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
PUSH(LABEL(L_CLOSURE1475));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1475);
L_CLOSURE1475:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// s1
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(123));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE232);

// ---pvar---
// s2
MOV(R0, FPARG(3));


JUMP(L_IF3_DONE232);
L_IF3_ELSE232:

// ---applic-tc---

//---applic---

// ---pvar---
// s2
MOV(R0, FPARG(3));

PUSH(R0);

//---applic---

// ---pvar---
// s1
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// app2
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 0));

 MOV(R0,IND(R0));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// s1
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(124));

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

L_IF3_DONE232:

POP(FP);
RETURN;
L_CLOSURE_DONE1475:

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
PUSH(LABEL(L_CLOSURE1476));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1476);
L_CLOSURE1476:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(123));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE233);

// ---pvar---
// s1
MOV(R0, FPARG(2));


JUMP(L_IF3_DONE233);
L_IF3_ELSE233:

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// appl
MOV(R0, FPARG(0));
MOV(R0, INDD(R0, 0));
MOV(R0, INDD(R0, 1));

 MOV(R0,IND(R0));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

// ---pvar---
// s1
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// app2
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

L_IF3_DONE233:

POP(FP);
RETURN;
L_CLOSURE_DONE1476:

MOV(IND(R1), R0);

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
PUSH(LABEL(L_CLOSURE1474));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE1474);
L_CLOSURE1474:
PUSH(FP);
MOV(FP, SP);
// ---lamda-variadic--- 
MOV(R1, FPARG(1));
INCR(R1);
L_VAR_LOOP47:
CMP(1, R1);
JUMP_EQ(L_VAR_LOOP_DONE47);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_VAR_LOOP47);
L_VAR_LOOP_DONE47:
PUSH(FPARG(1));
CALL(BUILD_LIST);
DROP(1);
DROP(FPARG(1));
MOV(R3, SP);
PUSH(R0);
PUSH(IMM(1));
PUSH(FPARG(0));
PUSH(FPARG(-1));
PUSH(FPARG(-2));

PUSH(IMM(5));
PUSH(R3);
MOV(R3, FP);
SUB(R3, 4);
SUB(R3, FPARG(1));
PUSH(R3);
CALL(STACKCPY);
DROP(3);

ADD(R3, 5);
MOV(FP, R3);
MOV(SP, R3);
// ---if3--- exp 

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(123));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE231);
MOV(R0, IMM(3));

JUMP(L_IF3_DONE231);
L_IF3_ELSE231:

// ---applic-tc---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(107));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(106));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---bvar---
// appl
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

L_IF3_DONE231:

POP(FP);
RETURN;
L_CLOSURE_DONE1474:

POP(FP);
RETURN;
L_CLOSURE_DONE1477:

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

MOV(IND(126), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT845);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT845:

//---applic---
MOV(R0, IMM(102));
PUSH(R0);

// ---fvar---
MOV(R0, IND(106));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(127));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT846);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT846:




















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
