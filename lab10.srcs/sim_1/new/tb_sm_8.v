`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 03:26:04 PM
// Design Name: 
// Module Name: tb_sm_8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Testbench.
module tb_sm_8();
    reg [7:0]a;
    reg [7:0]b;
    reg start;
    reg clk;
    
    wire [15:0]m;
    wire d;
    wire ready;
    
    sm_8 sm_8_0(a, b, start, clk, m, d, ready);
    
    // Emulate clock.
    initial clk = 1'b0;
    always #5 clk = ~clk;
    
    initial begin
        $monitor("a=%2d, b=%2d, m=%8b %8b %1b (%5d)", a, b, m[15:8], m[7:0], d, m);
        a = 8'd7;
        b = 8'd7;
        start = 1'b0;
        #20;
        
        start = 1'b1;
        #20;
        
        start = 1'b0;
        #400;
    end
endmodule