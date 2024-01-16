# shift_multiplier
8-bit Shift Multiplier with an 8-bit zero 2-1 mux and 8-bit signed adder/subtractor. This project was made for my Computer Organization and Architecture class.

The 8-bit Zero 2-1 Mux forwards an in put signal to out if a 1-bit selector signal (sel) is 1’b1, else forward 8’h00.

The 8-bit Signed Adder/Subtractor (sas_8), is activated where if a selector signal (sel) is 1’b0. The output should be a + b, and a – b otherwise.
