`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 01:46:30 PM
// Design Name: 
// Module Name: lab10
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


// 8-bit Zero 2-1 Mux
module zm_8(in, sel,out);
    input wire [7:0]in;
    input wire sel;
    
    output reg [7:0]out;
    always @ (*)
    begin
        if (sel == 1'b1)
        begin
            out = in;
        end
        else
        begin
            out = 8'h00;
        end
    end
endmodule

// 8-bit Signed Adder/Subtractor
module sas_8(a, b, sel, out);
    input wire [7:0]a;
    input wire [7:0]b;
    input wire sel;
    
    output reg [7:0]out;
    
    always @ (*)
    begin
        if(sel == 1'b0)
        begin
            out = a + b;
        end
        else
        begin
            out = a - b;
        end
    end
endmodule

// 8-bit Shift Multiplier.
module sm_8(a, b, start, clk, m, d, ready);
    input wire [7:0]a;
    input wire [7:0]b;
    input wire start;
    input wire clk;
    
    output wire [15:0]m;
    output wire d;
    output reg ready;
    
    // Registers.
    reg [7:0]ar;
    reg [7:0]br;
    reg [7:0]cr;
    reg bd;
    
    reg [3:0]counter;
    
    assign d = bd;
    
    // From mux to Adder/Subtractor.
    wire [7:0]at;
    
    // Output from Adder/Subtractor.
    wire [7:0]ct;
    
    // Operation and mux selectors.
    wire o_sel;
    wire m_sel;
    assign o_sel = br[0];
    assign m_sel = br[0] ^ bd;
    
    // Output m.
    assign m = {cr, br};
    
    // 8-bit 2-1 Mux.
    zm_8 zm_8_0(ar, m_sel, at);
    
    // 8-bit Signed Adder/Subtractor.
    sas_8 sas_8_0(cr, at, o_sel, ct);
    
    initial begin
        counter = 0;
        
        ar = 8'h00;
        br = 8'h00;
        cr = 8'h00;
        bd = 1'b0;
        
        ready = 1'b1;
    end
    
    always@(posedge clk) begin
        // Ready and start.
        if (ready == 1'b1 && start == 1'b1) begin
            // Capture inputs.
            ar = a;
            br = b;
            cr = 8'h00;
            bd = 1'b0;
            
            ready = 1'b0;
        end
        
        if (ready == 1'b0) begin
            cr = ct;
            
            // Shift registers to the right.
            if (counter > 0)
                {cr, br, bd} = {cr[7], cr, br};
             
            if (counter == 8) begin
                counter = 0;
                ready = 1'b1;
            end else begin
                counter = counter + 1;
            end
        end
    end
endmodule
