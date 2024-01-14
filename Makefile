TB_DIR ?= tb
C_ARGS = -g2005
IVLOG = iverilog $(C_ARGS) -I verilog -y verilog -o build/$@.vvp 

TB_DIR = tb
TB_SRCS = $(wildcard $(TB_DIR)/*.v)
TARGETS = $(patsubst $(TB_DIR)/%.v, %, $(TB_SRCS))

print:
	@echo $(TB_SRCS)
	@echo $(OBJS)
	@echo $(TARGETS)

$(TARGETS):
	$(IVLOG) $(TB_DIR)/$@.v
	vvp build/$@.vvp
	gtkwave build/$@.vcd&
	
gen_inst:
	python3 scripts/inst_generator.py
	mv instructions.mem ./memory_files

clean:
	rm -rf *.vcd *.vvp build/*