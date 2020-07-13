`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:		Instituto tecnologico de Costa Rica
// Engineer:		Raquel Ramirez Moreno
// 
// Create Date:		14:29:14 07/12/2020 
// Design Name:		RISC-V Microprocessor Core
// Module Name:		sync_ram_memory_tf (testbench/testfixture)
// Project Name:	Proyecto de microcontrolador 
// Target Devices:	Xilinx 
// Tool versions:	ISE-14.7
// Description:		Test fixture for the synchronous Read/Write RAM 
//
// Dependencies:	riscv_core.v
//
// Revision
// Revision 0.01 - File Created
// Additional Comments: testbench o testfixture code, test functional aspects
//
//////////////////////////////////////////////////////////////////////////////////

`include "sync_ram_memory"

module sync_ram_memory_tf ();
	parameter DATA_WIDTH = 32, parameter ADDR_WIDTH	= 8
	reg clock;
	wire write_enable, chip_select, output_enable;
	wire [DATA_WIDTH-1:0] data_bus;
	wire [ADDR_WIDTH-1:0] address_vector;

	// Instancing the design under test (DUT)

	sync_ram_memory DUT(
		clk_clk_i(clock),
		we_i(write_enable),
		cs_i(chip_select),
		oe_i(output_enable),
		address_i(address_vector),
		data_io(data_bus));

	// Definig the default values for the signals

	initial begin
		$display("Defining the default values for all variables")
		clock = 0;
		write_enable = 1;
		output_enable = 0;
		chip_select = 0;
		address_vector = 8'd0;
		$display("Definition of all variables done");
		$display("Loading the memory file");
		$readmemh('test_content_sync_ram_hex.mem',DUT.mem);
	end

	// Defining the periodic signals

	initial begin
		forever #20 clock = ~clock;
	end

	// Definition of the stimulus

	initial begin
		
	end

endmodule
