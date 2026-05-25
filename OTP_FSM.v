`timescale 1ns / 1ps
module OTP_FSM(
    input  wire clk, rst, req_access,   //request access button
    input  wire enter_otp,    //signal that OTP was entered
    input  wire [31:0] user_entered_otp,
    output reg correct, wrong,unlock, deny, alarm
);

parameter S0 = 3'b000; //idle/wait for request
parameter S1 = 3'b001; //wait for OTP entry
parameter S2 = 3'b010; //compare OTP
parameter S3 = 3'b011; //unlock
parameter S4 = 3'b100; //deny + alarm (wrong attempt)
parameter COMPARE = 32'h13579; //stored OTP

reg [2:0] c_state, n_state;

always @(posedge clk or posedge rst) begin
 if (rst)
   c_state <= S0;
 else
   c_state <= n_state;
end
    always @(*) begin
correct = 0;
wrong   = 0;
unlock  = 0;
deny    = 0;
alarm   = 0;
n_state = c_state;
 case (c_state)
S0: begin
 if(req_access)
     n_state = S1;
 else
     n_state = S0;
 end

S1: begin
    if(enter_otp)
n_state = S2;
    else
n_state = S0; //go to initial if no otp entered
 end

S2: begin
  if(user_entered_otp == COMPARE) begin
correct = 1;
unlock  = 1;
n_state = S3;
   end else begin
   
wrong = 1;
deny  = 1;
alarm = 1;
$error("WRONG OTP !"); //keep this only for testbench and REMOVE for gate level synthesis
n_state = S4;
     end
  end

S3: begin
n_state = S0; //after unlock go back to initial
end

S4: begin
 n_state = S0; //after denial to back to initial
end
 default: n_state = S0;
endcase
end
endmodule
