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
PUSH(IMM(5/6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(6/7));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(7/8));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(9));
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
PUSH(IMM(-1/2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-3/4));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-5/6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-7/8));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(12/5));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(11));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-12));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-12/11));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(12));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(1/2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(3/2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-3/2));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making STRING object
PUSH(IMM(65));
PUSH(IMM(66));
PUSH(IMM(67));
PUSH(IMM(3));
CALL(MAKE_SOB_STRING);
DROP(4);

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Makeing SYMBOL object
PUSH(IMM(57));
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
PUSH(IMM(60));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making vector object
PUSH(IMM(52));
PUSH(IMM(22));
PUSH(IMM(4));
PUSH(IMM(24));
PUSH(IMM(6));
PUSH(IMM(26));
PUSH(IMM(65));

PUSH(IMM(7));
CALL(MAKE_SOB_VECTOR);
DROP(8);

// Making INT object
PUSH(IMM(4));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making STRING object
PUSH(IMM(65));
PUSH(IMM(66));
PUSH(IMM(99));
PUSH(IMM(68));
PUSH(IMM(49));
PUSH(IMM(50));
PUSH(IMM(51));
PUSH(IMM(52));
PUSH(IMM(8));
CALL(MAKE_SOB_STRING);
DROP(9);

// Making INT object
PUSH(IMM(0));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making CHAR object
PUSH(IMM(98));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(97));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(65));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(32));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making INT object
PUSH(IMM(2/13));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(3/4));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making CHAR object
PUSH(IMM(67));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making STRING object
PUSH(IMM(83));
PUSH(IMM(116));
PUSH(IMM(82));
PUSH(IMM(3));
CALL(MAKE_SOB_STRING);
DROP(4);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(105));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(110));
PUSH(IMM(103));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(113));
PUSH(IMM(91));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(116));
PUSH(IMM(93));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making vector object
PUSH(IMM(22));
PUSH(IMM(24));
PUSH(IMM(26));
PUSH(IMM(4));
PUSH(IMM(6));
PUSH(IMM(101));
PUSH(IMM(119));

PUSH(IMM(7));
CALL(MAKE_SOB_VECTOR);
DROP(8);

// Making vector object
PUSH(IMM(22));
PUSH(IMM(24));
PUSH(IMM(26));

PUSH(IMM(3));
CALL(MAKE_SOB_VECTOR);
DROP(4);

// Making vector object
PUSH(IMM(22));
PUSH(IMM(24));
PUSH(IMM(26));
PUSH(IMM(4));
PUSH(IMM(6));
PUSH(IMM(101));

PUSH(IMM(6));
CALL(MAKE_SOB_VECTOR);
DROP(7);

// Making INT object
PUSH(IMM(100));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making vector object
PUSH(IMM(22));

PUSH(IMM(1));
CALL(MAKE_SOB_VECTOR);
DROP(2);

// Making STRING object
PUSH(IMM(115));
PUSH(IMM(121));
PUSH(IMM(109));
PUSH(IMM(98));
PUSH(IMM(111));
PUSH(IMM(108));
PUSH(IMM(49));
PUSH(IMM(7));
CALL(MAKE_SOB_STRING);
DROP(8);

// Makeing SYMBOL object
PUSH(IMM(149));
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
PUSH(IMM(22));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making CHAR object
PUSH(IMM(99));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making vector object

PUSH(IMM(0));
CALL(MAKE_SOB_VECTOR);
DROP(1);

// Making STRING object
PUSH(IMM(83));
PUSH(IMM(116));
PUSH(IMM(114));
PUSH(IMM(3));
CALL(MAKE_SOB_STRING);
DROP(4);

// Making STRING object
PUSH(IMM(116));
PUSH(IMM(104));
PUSH(IMM(105));
PUSH(IMM(115));
PUSH(IMM(45));
PUSH(IMM(105));
PUSH(IMM(115));
PUSH(IMM(45));
PUSH(IMM(97));
PUSH(IMM(45));
PUSH(IMM(115));
PUSH(IMM(121));
PUSH(IMM(109));
PUSH(IMM(98));
PUSH(IMM(111));
PUSH(IMM(108));
PUSH(IMM(16));
CALL(MAKE_SOB_STRING);
DROP(17);

// Makeing SYMBOL object
PUSH(IMM(175));
CALL(MAKE_SOB_SYMBOL);
DROP(1);
// Build symbol link
PUSH(IND(SOB_SYM_LIST));
PUSH(R0);
CALL(MAKE_SOB_PAIR);
DROP(2);
MOV(IND(SOB_SYM_LIST), R0);

// Making INT object
PUSH(IMM(20));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making CHAR object
PUSH(IMM(89));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making STRING object
PUSH(IMM(116));
PUSH(IMM(104));
PUSH(IMM(105));
PUSH(IMM(115));
PUSH(IMM(32));
PUSH(IMM(105));
PUSH(IMM(115));
PUSH(IMM(32));
PUSH(IMM(65));
PUSH(IMM(32));
PUSH(IMM(83));
PUSH(IMM(84));
PUSH(IMM(82));
PUSH(IMM(73));
PUSH(IMM(78));
PUSH(IMM(71));
PUSH(IMM(33));
PUSH(IMM(17));
CALL(MAKE_SOB_STRING);
DROP(18);

// Making STRING object
PUSH(IMM(0));
CALL(MAKE_SOB_STRING);
DROP(1);

// Making CHAR object
PUSH(IMM(90));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making INT object
PUSH(IMM(-1/45));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-54));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(98));
PUSH(IMM(99));
PUSH(IMM(100));
PUSH(IMM(101));
PUSH(IMM(49));
PUSH(IMM(50));
PUSH(IMM(51));
PUSH(IMM(8));
CALL(MAKE_SOB_STRING);
DROP(9);

// Making STRING object
PUSH(IMM(116));
PUSH(IMM(104));
PUSH(IMM(105));
PUSH(IMM(115));
PUSH(IMM(45));
PUSH(IMM(105));
PUSH(IMM(115));
PUSH(IMM(32));
PUSH(IMM(97));
PUSH(IMM(32));
PUSH(IMM(83));
PUSH(IMM(84));
PUSH(IMM(82));
PUSH(IMM(73));
PUSH(IMM(78));
PUSH(IMM(71));
PUSH(IMM(32));
PUSH(IMM(33));
PUSH(IMM(18));
CALL(MAKE_SOB_STRING);
DROP(19);

// Making INT object
PUSH(IMM(65));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(32));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(97));
CALL(MAKE_SOB_INTEGER);
DROP(1);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/


// Space for sym: char->integer
PUSH(IMM(1));
CALL(MALLOC);
DROP(1);
MOV(IND(R0), T_VOID);
/**************************************************/
/* Update primitive symbols */
/**************************************************/



/*=============================*/
/*         Compiled code       */
/*=============================*/


//---applic---
MOV(R0, IMM(95));
PUSH(R0);
PUSH(IMM(1));

// ---fvar---
MOV(R0, IND(267));

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
