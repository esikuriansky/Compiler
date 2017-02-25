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

// Making STRING object
PUSH(IMM(108));
PUSH(IMM(97));
PUSH(IMM(108));
PUSH(IMM(97));
PUSH(IMM(4));
CALL(MAKE_SOB_STRING);
DROP(5);



/*=============================*/
/*         Compiled code       */
/*=============================*/

//--if3-- exp 
MOV(R0, IMM(4));

CMP(R0, IMM(SOB_BOOL_FALSE));
JUMP_EQ(L_IF3_ELSE1);
MOV(R0, IMM(8));

JUMP(L_IF3_DONE1);
L_IF3_ELSE1:
MOV(R0, IMM(6));

L_IF3_DONE1:


/*==============================*/
/*    Finished compiling code   */
/*==============================*/
/* Display result on STDOUT */
PUSH(R0);
CALL(WRITE_SOB);
DROP(1);

STOP_MACHINE;
	return 0;

L_RUNTIME_ERROR:
	printf("Runtime error!\n");

STOP_MACHINE;

return 1;
}
