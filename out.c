#include <stdio.h>
#include <string.h>
#include <string.h>
#include "cisc.h"

#define DO_SHOW 1

int main()
{
START_MACHINE;

JUMP(CONTINUE);
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

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(14));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(16));
PUSH(IMM(12));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(19));
PUSH(IMM(10));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(22));
PUSH(IMM(8));
CALL(MAKE_SOB_PAIR);
DROP(2);


/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/


// Space for sym: apply
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: boolean?
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

// Space for sym: char->integer
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: char?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: cons
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: eq?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: integer?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: integer->char
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: make-string
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: make-vector
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: null?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: pair?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: number?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: procedure?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: remainder
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: set-car!
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: set-cdr!
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: string-length
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: string-ref
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: string-set!
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: string->symbol
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: string?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: symbol?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: symbol->string
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: vector-length
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: vector-ref
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: vector-set!
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: vector?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: zero?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: bin+
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: bin-
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: bin*
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: bin/
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: bin=?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: bin<?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);

// Space for sym: void?
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);


/*=============================*/
/*         Compiled code       */
/*=============================*/

MOV(R0, IMM(25));


/*==============================*/
/*    Finished compiling code   */
/*==============================*/
/* Display result on STDOUT */
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);

OUT(2,10)
STOP_MACHINE;
	return 0;

L_RUNTIME_ERROR:
	printf("Runtime error!\n");

STOP_MACHINE;

return 1;
}
