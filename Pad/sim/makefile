TB:
	iverilog TB.v -o TB.o -y ../rtl
	vvp TB.o
	rm TB.o	

DISPLAY_set:
	export DISPLAY=:0

VM:
	xemacs --batch $(file) -f verilog-auto-save-compile

