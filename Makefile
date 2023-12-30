TB_DIR ?= tb
C_ARGS = -g2005
IVLOG = iverilog $(C_ARGS) -o build/$@.vvp -y verilog

TB_DIR = tb
TB_SRCS = $(wildcard $(TB_DIR)/*.v)
TARGETS = $(patsubst $(TB_DIR)/%.v, %, $(TB_SRCS))

print:
	@echo $(TB_SRCS)
	@echo $(OBJS)

$(TARGETS):
	$(IVLOG) $(TB_DIR)/$@.v
	vvp build/$@.vvp
	
clean:
	rm -rf *.vcd *.vvp build/*