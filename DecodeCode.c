#include "DecodeCode.h"


mipsinstruction decode(int value)
{
	mipsinstruction instr;

	// TODO: fill in the fields
	instr.funct = value & 63;
    int v = value & 65535;
    if (v % 2 == 0) {
        instr.immediate = v;
    } else {
        int x = ~65535;
	    instr.immediate = v | x;
    }
    v = value & 63488;
	instr.rd = v >> 11;
    v = value & 2031616;
	instr.rt = v >> 16;
    v = value & 65011712;
	instr.rs = v >> 21;
    v = value & 4227858432;
	instr.opcode = v >> 26;

	return instr;
}


