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

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(10));
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
PUSH(IMM(18));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(21));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(26));
PUSH(IMM(13));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(6));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(32));
PUSH(IMM(4));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making STRING object
PUSH(IMM(101));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(38));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making INT object
PUSH(IMM(5));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(46));
CALL(MAKE_SOB_PAIR);
DROP(2);

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

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(57));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(59));
PUSH(IMM(55));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(62));
PUSH(IMM(53));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(65));
PUSH(IMM(51));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making INT object
PUSH(IMM(6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(7));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(73));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(75));
PUSH(IMM(71));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(78));
PUSH(IMM(46));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making INT object
PUSH(IMM(8));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(9));
CALL(MAKE_SOB_INTEGER);
DROP(1);

PUSH(IMM(0));
PUSH(IMM(-1));
PUSH(IMM(2));
CALL(MAKE_SOB_FRACTION);
DROP(3);
// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(88));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(92));
PUSH(IMM(86));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(95));
PUSH(IMM(84));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(53));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(101));
PUSH(IMM(51));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(71));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(107));
PUSH(IMM(46));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making STRING object
PUSH(IMM(99));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(113));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(55));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(121));
PUSH(IMM(53));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(124));
PUSH(IMM(51));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(116));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(130));
PUSH(IMM(21));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(133));
PUSH(IMM(13));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(136));
PUSH(IMM(4));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(51));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(48));
PUSH(IMM(57));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(145));
PUSH(IMM(55));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(13));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making STRING object
PUSH(IMM(100));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(154));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(157));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(162));
PUSH(IMM(116));
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

// Space for sym: cdaar
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

// Space for sym: last-pair
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: append-helper2
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: append-helper1
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: append
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
MOV(IND(169), R0);

PUSH(LABEL(CDR));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(170), R0);

PUSH(LABEL(IS_NILL));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(187), R0);

PUSH(LABEL(CONS));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(188), R0);

PUSH(LABEL(L_APPLY));
PUSH(IMM(SOB_NIL));
CALL(MAKE_SOB_CLOSURE);
DROP(2);
MOV(IND(189), R0);



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
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE641));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE641);
L_CLOSURE641:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE641:

MOV(IND(168), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT388);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT388:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE640));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE640);
L_CLOSURE640:
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
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE640:

MOV(IND(171), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT389);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT389:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE639));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE639);
L_CLOSURE639:
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
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE639:

MOV(IND(172), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT390);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT390:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE638));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE638);
L_CLOSURE638:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE638:

MOV(IND(173), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT391);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT391:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE637));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE637);
L_CLOSURE637:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE637:

MOV(IND(174), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT392);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT392:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE636));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE636);
L_CLOSURE636:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE636:

MOV(IND(175), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT393);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT393:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE635));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE635);
L_CLOSURE635:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE635:

MOV(IND(176), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT394);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT394:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE634));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE634);
L_CLOSURE634:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE634:

MOV(IND(177), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT395);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT395:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE633));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE633);
L_CLOSURE633:
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
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE633:

MOV(IND(178), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT396);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT396:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE632));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE632);
L_CLOSURE632:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE632:

MOV(IND(179), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT397);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT397:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE631));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE631);
L_CLOSURE631:
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
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE631:

MOV(IND(180), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT398);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT398:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE630));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE630);
L_CLOSURE630:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE630:

MOV(IND(181), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT399);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT399:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE629));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE629);
L_CLOSURE629:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE629:

MOV(IND(182), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT400);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT400:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE628));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE628);
L_CLOSURE628:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE628:

MOV(IND(183), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT401);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT401:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE627));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE627);
L_CLOSURE627:
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
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
L_CLOSURE_DONE627:

MOV(IND(184), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT402);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT402:

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE626));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE626);
L_CLOSURE626:
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
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

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
L_CLOSURE_DONE626:

MOV(IND(185), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT403);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT403:

// ---define--- 

//---applic---

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE625));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE625);
L_CLOSURE625:
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
PUSH(LABEL(L_CLOSURE622));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE622);
L_CLOSURE622:
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
PUSH(LABEL(L_CLOSURE621));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE621);
L_CLOSURE621:
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
L_CLOSURE_DONE621:
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
L_CLOSURE_DONE622:
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
PUSH(LABEL(L_CLOSURE624));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE624);
L_CLOSURE624:
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
PUSH(LABEL(L_CLOSURE623));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE623);
L_CLOSURE623:
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
L_CLOSURE_DONE623:
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
L_CLOSURE_DONE624:

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
L_CLOSURE_DONE625:
PUSH(R0);
PUSH(IMM(1));

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE620));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE620);
L_CLOSURE620:
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
PUSH(LABEL(L_CLOSURE614));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE614);
L_CLOSURE614:
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
PUSH(LABEL(L_CLOSURE613));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE613);
L_CLOSURE613:
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
MOV(R0, IND(187));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE99);
MOV(R0, IMM(3));

JUMP(L_IF3_DONE99);
L_IF3_ELSE99:

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

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
MOV(R0, IND(169));

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
MOV(R0, IND(188));

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

L_IF3_DONE99:

POP(FP);
RETURN;
L_CLOSURE_DONE613:

POP(FP);
RETURN;
L_CLOSURE_DONE614:
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
PUSH(LABEL(L_CLOSURE619));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE619);
L_CLOSURE619:
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
PUSH(LABEL(L_CLOSURE616));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE616);
L_CLOSURE616:
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
PUSH(LABEL(L_CLOSURE615));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE615);
L_CLOSURE615:
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
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(187));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE100);
MOV(R0, IMM(3));

JUMP(L_IF3_DONE100);
L_IF3_ELSE100:

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// s
MOV(R0, FPARG(3));

PUSH(R0);

// ---fvar---
MOV(R0, IND(170));
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
MOV(R0, IND(169));
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
MOV(R0, IND(189));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(188));

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

L_IF3_DONE100:

POP(FP);
RETURN;
L_CLOSURE_DONE615:

POP(FP);
RETURN;
L_CLOSURE_DONE616:
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
PUSH(LABEL(L_CLOSURE618));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE618);
L_CLOSURE618:
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
PUSH(LABEL(L_CLOSURE617));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE617);
L_CLOSURE617:
PUSH(FP);
MOV(FP, SP);
// ---lambda-opt--- 
// convert optional 
// arguments to list

MOV(R1, FPARG(1));
INCR(R1);
L_OPT_LOOP20:
CMP(2, R1);
JUMP_EQ(L_OPT_LOOP_DONE20);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_OPT_LOOP20);
L_OPT_LOOP_DONE20:
MOV(R1, FPARG(1));
SUB(R1, IMM(1));
PUSH(R1);
CALL(BUILD_LIST);
DROP(1);
DROP(R1);
MOV(R3, SP);
PUSH(R0);
MOV(R1, 2);
L_OPT_NEW_ARGS20:
CMP(1, R1);
JUMP_EQ(L_OPT_NEW_ARGS_DONE20);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_OPT_NEW_ARGS20);
L_OPT_NEW_ARGS_DONE20:
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
L_CLOSURE_DONE617:

POP(FP);
RETURN;
L_CLOSURE_DONE618:

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
L_CLOSURE_DONE619:

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
L_CLOSURE_DONE620:

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

MOV(IND(186), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT404);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT404:

// ---define--- 

// ---seq--- 

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE611));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE611);
L_CLOSURE611:
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
MOV(R0, IND(187));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE97);

// ---pvar---
// y
MOV(R0, FPARG(3));


JUMP(L_IF3_DONE97);
L_IF3_ELSE97:

// ---applic-tc---

//---applic---

// ---pvar---
// y
MOV(R0, FPARG(3));

PUSH(R0);

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(191));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(188));

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

L_IF3_DONE97:

POP(FP);
RETURN;
L_CLOSURE_DONE611:

MOV(IND(191), R0);
MOV(R0, SOB_VOID);

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE612));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE612);
L_CLOSURE612:
PUSH(FP);
MOV(FP, SP);
// ---if3--- exp 

//---applic---

// ---pvar---
// y
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(187));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE98);

// ---pvar---
// x
MOV(R0, FPARG(2));


JUMP(L_IF3_DONE98);
L_IF3_ELSE98:

// ---applic-tc---

//---applic---

//---applic---

// ---pvar---
// y
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// y
MOV(R0, FPARG(3));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(192));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(191));

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

L_IF3_DONE98:

POP(FP);
RETURN;
L_CLOSURE_DONE612:

MOV(IND(192), R0);
MOV(R0, SOB_VOID);

// ---define--- 

//---lambda-code---
// Init env 
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(R1, R0);
MOV(INDD(R1, 0), SOB_NIL);PUSH(LABEL(L_CLOSURE610));

PUSH(R1);
CALL(MAKE_SOB_CLOSURE);
DROP(2);
JUMP(L_CLOSURE_DONE610);
L_CLOSURE610:
PUSH(FP);
MOV(FP, SP);
// ---lamda-variadic--- 
MOV(R1, FPARG(1));
INCR(R1);
L_VAR_LOOP20:
CMP(1, R1);
JUMP_EQ(L_VAR_LOOP_DONE20);
PUSH(FPARG(R1));
DECR(R1);
JUMP(L_VAR_LOOP20);
L_VAR_LOOP_DONE20:
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
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(187));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE96);
MOV(R0, IMM(3));

JUMP(L_IF3_DONE96);
L_IF3_ELSE96:

// ---applic-tc---

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(170));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);

//---applic---

// ---pvar---
// x
MOV(R0, FPARG(2));

PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(169));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(192));

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

L_IF3_DONE96:

POP(FP);
RETURN;
L_CLOSURE_DONE610:

MOV(IND(193), R0);
MOV(R0, SOB_VOID);

MOV(IND(190), R0);
MOV(R0, SOB_VOID);
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT405);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT405:

//---applic---
MOV(R0, IMM(165));
PUSH(R0);
MOV(R0, IMM(29));
PUSH(R0);
PUSH(IMM(2));

// ---fvar---
MOV(R0, IND(193));

// check valid closuse
CMP(INDD(R0,0), T_CLOSURE);
JUMP_NE(L_RUNTIME_ERROR);
PUSH(INDD(R0,1)); 
CALLA(INDD(R0, 2));
DROP(2 + STARG(0));
/* Display result on STDOUT */
CMP(R0, SOB_VOID);
JUMP_EQ(L_DONT_PRINT406);
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);
OUT(2,10);
L_DONT_PRINT406:





















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
