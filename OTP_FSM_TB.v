`timescale 1ns / 1ps
module OTP_FSM_TB();
reg clk, rst, req_access, enter_otp;
reg [31:0] user_entered_otp;
wire correct, wrong, unlock, deny, alarm;

OTP_FSM dut(
        .clk(clk),
        .rst(rst),
        .req_access(req_access),
        .enter_otp(enter_otp),
        .user_entered_otp(user_entered_otp),
        .correct(correct),
        .wrong(wrong),
        .unlock(unlock),
        .deny(deny),
        .alarm(alarm)
    );
    
always #5 clk = ~clk;

initial begin
       
clk = 0;
rst = 1;
req_access = 0;
enter_otp = 0;
user_entered_otp = 32'h0;
#20 rst = 0;

        //correct OTP
#10 req_access = 1;  
#10 enter_otp = 1;
user_entered_otp = 32'h00013579;
#40;
        //wrong OTP
#50 req_access = 1;
#50 enter_otp = 1;
user_entered_otp = 32'h000ABCDE;

#60;
        
#80 req_access=0;
#90 req_access=1;
#100 enter_otp = 0;

#110;

$finish;
end
endmodule
