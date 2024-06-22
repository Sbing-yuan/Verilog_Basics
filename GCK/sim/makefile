TB1\
TB2:
	iverilog $@.v -o $@.o -y ../rtl
	vvp $@.o
	rm $@.o	

DISPLAY_set:
	export DISPLAY=:0

VM:
	xemacs --batch $(file) -f verilog-auto-save-compile

