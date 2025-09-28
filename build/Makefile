all: sim.vvp

sim.vvp: my_module.v tb_my_module.v
	iverilog -o sim.vvp my_module.v tb_my_module.v

run: sim.vvp
	vvp sim.vvp

wave: dump.vcd
	gtkwave dump.vcd

clean:
	rm -f sim.vvp dump.vcd
