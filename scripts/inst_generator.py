import enum
import random
import struct
from pyuvm import *


@enum.unique
class MIPSInstructionType(enum.IntEnum):
    RType = 1
    IType = 2
    JType = 3

@enum.unique
class RTypeFunct(enum.Enum):
    MOVE = 0b100000
    ADD = 0b000010
    SUB = 0b000011
    AND = 0b000100
    OR = 0b000101
    SET_LESS_THAN = 0b000111
    JUMP_REG = 0b001000

@enum.unique
class ITypeOpcodes(enum.Enum):
    ADD_IMM = 0b000010
    SUB_IMM = 0b000011
    AND_IMM = 0b000100
    OR_IMM = 0b000101
    LOAD_WORD = 0b001000
    STORE_WORD = 0b010000
    LOAD_BYTE = 0b001001
    STORE_BYTE = 0b010001
    SET_LESS_THAN_IMM = 0b000111
    BRANCH_EQUAL = 0b100011
    BRANCH_NOT_EQUAL = 0b100111

@enum.unique
class JTypeOpcodes(enum.Enum):
    JUMP = 0b111000
    JUMP_AND_LINK = 0b111001

class MIPSInstruction(uvm_sequence_item):
    def __init__(self, name, instruction_type, opcode):
        super().__init__(name)
        self.instruction_type = instruction_type
        self.opcode = opcode
        self.machine_code = 0

    def __str__(self):
        self.update_machine_code()
        return f"{self.get_name()} : Type: {self.instruction_type.name}" + \
                    f"Opcode: {self.opcode}, Machine code: {self.machine_code}"

    def update_machine_code(self):
        self.machine_code = self.serialize()

    def serialize(self):
        return f"{0:032b}"

    def randomize(self):
        return self

    def rand_reg(self):
        return random.randint(0, 31)


class RTypeInstruction(MIPSInstruction):

    def __init__(self, name, rs=0, rt=0, rd=0, func_code=RTypeFunct.ADD):
        super().__init__(name, MIPSInstructionType.RType, 0)
        self.rs = rs
        self.rt = rt
        self.rd = rd
        self.shamt = 0
        self.func_code = func_code

    def __str__(self):
        return super().__str__() + \
                f"\nRs: {self.rs}, Rt: {self.rt}, Rd: {self.rd}, Funct: {self.func_code}"

    def randomize(self):
        self.rs = self.rand_reg()
        self.rt = self.rand_reg()
        self.rd = self.rand_reg()
        self.func_code = random.choice(list(RTypeFunct))
        return self

    def serialize(self):
        return f"{self.opcode:06b}{self.rs:05b}{self.rt:05b}{self.rd:05b}" + \
                f"{self.shamt:05b}{self.func_code.value:06b}"
                
class MoveInstruction(RTypeInstruction):
    
    def __init__(self, name, rs=0, rt=0, rd=0, func_code=RTypeFunct.ADD):
        super().__init__(name, rs, rt, 0, 0)
        self.opcode = RTypeFunct.MOVE.value
        
    def randomize(self):
        self.rs = self.rand_reg()
        self.rt = self.rand_reg()
        return self
    
    def serialize(self):
        return f"{self.opcode:06b}{self.rs:05b}{self.rt:05b}{self.rd:05b}" + \
                f"{self.shamt:05b}{self.func_code:06b}"
    
class ITypeInstruction(MIPSInstruction):

    def __init__(self, name, opcode=ITypeOpcodes.ADD_IMM):
        super().__init__(name, MIPSInstructionType.IType, opcode)
        self.opcode = opcode
        self.rs = 0
        self.rt = 0
        self.immed = 0

    def __str__(self):
        return super().__str__() + \
                f"\nRs: {self.rs}, Rt: {self.rt}, Immed: {self.immed}"

    def serialize(self):
        return f"{self.opcode.value:06b}{self.rs:05b}{self.rt:05b}{self.immed:016b}"

    def randomize(self):
        self.opcode = random.choice(list(ITypeOpcodes))
        self.rs = self.rand_reg()
        self.rt = self.rand_reg()
        self.immed = random.randrange(0, pow(2, 16)-1)
        return self

class JTypeInstruction(MIPSInstruction):
    
    def __init__(self, name, opcode=JTypeOpcodes.JUMP, address=0):
        super().__init__(name, MIPSInstructionType.JType, opcode)
        self.address = address
        
    def __str__(self):
        return super().__str__() + \
                f"\nAddress: {hex(self.address)}"

    def serialize(self):
        return f"{self.opcode.value:06b}{self.address:026b}"

    def randomize(self):
        self.opcode = random.choice(list(JTypeOpcodes))
        #self.address = random.randrange(0, pow(2, 26)-1)
        self.address = random.randrange(0, pow(2, 10)-1) # limit max 1024
        return self

class InstructionGenerator():

    def __init__(self, n_inst) -> None:
        self.n_inst = n_inst
        self.instructions = []

    def add(self, inst: MIPSInstruction) -> None:
        self.instructions.append(inst)
        
    def clear(self) -> None:
        self.instructions = []

    def randomize(self, limit: int=100):
        self.n_inst = random.randrange(1, limit)
        self.generate()

    def generate(self, r_en=1, i_en=1, j_en=1):
        self.clear()
        # TODO Generate randomly
        for i in range(self.n_inst):
            if i % 3 == 0 and r_en:
                self.add(RTypeInstruction("RType").randomize())
            elif i % 3 == 1 and i_en:
                self.add(ITypeInstruction("IType").randomize())
            elif i % 3 == 2 and j_en:
                self.add(JTypeInstruction("JType").randomize())
    
    # TODO Refactor into decorator
    def generate_rtype(self):
        self.clear()
        for i in range(self.n_inst):
            self.add(RTypeInstruction("RType").randomize())
            
    def generate_itype(self):
        self.clear()
        for i in range(self.n_inst):
            self.add(ITypeInstruction("JType").randomize())
            
    def generate_jtype(self):
        self.clear()
        for i in range(self.n_inst):
            self.add(JTypeInstruction("JType").randomize())


if __name__ == "__main__":

    r_inst = RTypeInstruction("RType").randomize()
    i_inst = ITypeInstruction("IType").randomize()
    j_inst = JTypeInstruction("JType").randomize()

    instructions = [r_inst, i_inst, j_inst]

    generator = InstructionGenerator(1024)
    #generator.generate(j_en=0)
    #generator.generate_rtype()
    #generator.generate_itype()
    #generator.generate_jtype()
    
    for i in range(10):
        generator.add(MoveInstruction("Move").randomize())

    with open("instructions.mem", 'w') as file:
        for inst in generator.instructions:
            #print(inst)
            file.write(inst.serialize() + '\n')
            
    with open("instructions.str", 'w') as file:
        for inst in generator.instructions:
            file.write(str(inst) + '\n')
            print(inst)