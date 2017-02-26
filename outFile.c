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
PUSH(IMM(5));
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

// Making INT object
PUSH(IMM(6));
CALL(MAKE_SOB_INTEGER);
DROP(1);

// Makeing PAIR object
PUSH(IMM(3));
PUSH(IMM(18));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(20));
PUSH(IMM(8));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(23));
PUSH(IMM(16));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(26));
PUSH(IMM(14));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(29));
PUSH(IMM(12));
CALL(MAKE_SOB_PAIR);
DROP(2);
// Makeing PAIR object
PUSH(IMM(32));
PUSH(IMM(10));
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
