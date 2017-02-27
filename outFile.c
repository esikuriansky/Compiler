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

// Making vector object
PUSH(IMM(8));

PUSH(IMM(1));
CALL(MAKE_SOB_VECTOR);
DROP(2);

// Making CHAR object
PUSH(IMM(122));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making STRING object
PUSH(IMM(65));
PUSH(IMM(1));
CALL(MAKE_SOB_STRING);
DROP(2);

// Making STRING object
PUSH(IMM(66));
PUSH(IMM(67));
PUSH(IMM(68));
PUSH(IMM(3));
CALL(MAKE_SOB_STRING);
DROP(4);

// Making STRING object
PUSH(IMM(65));
PUSH(IMM(107));
PUSH(IMM(117));
PUSH(IMM(110));
PUSH(IMM(97));
PUSH(IMM(5));
CALL(MAKE_SOB_STRING);
DROP(6);

// Making STRING object
PUSH(IMM(77));
PUSH(IMM(97));
PUSH(IMM(116));
PUSH(IMM(97));
PUSH(IMM(116));
PUSH(IMM(97));
PUSH(IMM(6));
CALL(MAKE_SOB_STRING);
DROP(7);

// Making CHAR object
PUSH(IMM(97));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(98));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(99));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(100));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(101));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(102));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making CHAR object
PUSH(IMM(103));
CALL(MAKE_SOB_CHAR);
DROP(1);

// Making INT object
PUSH(IMM(-24));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(10));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(12));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making INT object
PUSH(IMM(-2/3));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Making STRING object
PUSH(IMM(65));
PUSH(IMM(98));
PUSH(IMM(67));
PUSH(IMM(49));
PUSH(IMM(50));
PUSH(IMM(51));
PUSH(IMM(52));
PUSH(IMM(53));
PUSH(IMM(54));
PUSH(IMM(55));
PUSH(IMM(56));
PUSH(IMM(57));
PUSH(IMM(48));
PUSH(IMM(13));
CALL(MAKE_SOB_STRING);
DROP(14);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(16));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(93));
PUSH(IMM(14));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making STRING object
PUSH(IMM(97));
PUSH(IMM(98));
PUSH(IMM(67));
PUSH(IMM(100));
PUSH(IMM(69));
PUSH(IMM(49));
PUSH(IMM(50));
PUSH(IMM(51));
PUSH(IMM(8));
CALL(MAKE_SOB_STRING);
DROP(9);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(18));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(109));
PUSH(IMM(16));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(112));
PUSH(IMM(14));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(115));
PUSH(IMM(12));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(118));
PUSH(IMM(10));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Makeing PAIR object
PUSH(IMM(121));
PUSH(IMM(8));
CALL(MAKE_SOB_PAIR);
DROP(2);

// Making vector object
PUSH(IMM(8));
PUSH(IMM(10));
PUSH(IMM(12));

PUSH(IMM(3));
CALL(MAKE_SOB_VECTOR);
DROP(4);



/*=============================*/
/*   Symbol table cgen code    */
/*=============================*/

/**************************************************/
/* Update primitive symbols */
/**************************************************/



/*=============================*/
/*         Compiled code       */
/*=============================*/

MOV(R0, IMM(4));


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
