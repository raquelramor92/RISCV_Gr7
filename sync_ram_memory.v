`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:		Instituto tecnologico de Costa Rica
// Engineer:		Raquel Ramirez Moreno
// 
// Create Date:		07:16:04 07/11/2020 
// Design Name:		RISC-V Microprocessor Core
// Module Name:		sync_ram_memory
// Project Name:	Proyecto de microprocesador 
// Target Devices:	Xilinx 
// Tool versions:	ISE-14.7
// Description:		This module implements a synchronous Read/Write RAM with a de- 
//			fault size of 512 addresses of 32 bits, or a 512x128 bytes RAM
//
// Dependencies:	riscv_core.v
//
// Revision
// Revision 0.01 - File Created
// Additional Comments: This code is intended to be used for the memory blocks of
//			the core.
// 			This code is based in the example code provided by Deepak 
//			Kumar Tala on his website, showed below:
// http://www.asic-world.com/examples/verilog/ram_sp_sr_sw.html#Single_Port_RAM_\
// Synchronous_Read/Write
//
//////////////////////////////////////////////////////////////////////////////////

module sync_ram_memory #(
	parameter DATA_WIDTH = 32, parameter ADDR_WIDTH	= 8, parameter RAM_DEPTH = 1 << ADDR_WIDTH) // Global parameters to parametrize the size of the memory
(
	input clk_clk_i,					// Clock Signal
	input we_i,							// Write enable
	input cs_i,							// Chip Select 
	input oe_i,							// Output enable
	input [ADDR_WIDTH-1:0] address_i,	// Address Data
	inout [DATA_WIDTH-1:0] data_io		// Data bidirectional Signal
);

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_r ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg oe_r;

//--------------Code Starts Here------------------ 
// Tri-State Buffer control 
// output : When oe = 1, cs = 1

assign data_io = (cs_i && oe_i && !we_i) ? data_r : 32'bz;

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (posedge clk_clk_i)
begin : MEM_WRITE
   if ( cs_i && we_i ) begin
       mem[address_i] = data_r;
   end
end

// Memory Read Block 
// Read Operation : When we = 0, oe = 1, cs = 1
always @ (posedge clk_clk_i)
begin : MEM_READ
  if (cs_i &&  ! we_i && oe_i) begin
    data_r = mem[address_i];
    oe_r = 1;
  end else begin
    oe_r = 0;
  end
end

endmodule // End of Module sync_ram_memory
