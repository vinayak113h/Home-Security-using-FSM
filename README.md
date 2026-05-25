# OTP-based-Home-Security
This project implements a smart home door lock system using Finite State Machine (FSM) in Verilog. The door unlocks only when the correct OTP (One Time Password) is entered. If a wrong OTP is entered, the system denies access and triggers an alarm.

The FSM is written in Mealy machine style — meaning outputs depend on both current state and inputs.
Simulation is performed to verify all cases:
--> Correct OTP entry
--> Wrong OTP entry
--> No OTP entry (timeout → return to idle)

# Control Flow / Operation

1. Idle (S0)
System waits for a user to press the request access button.
If no request, remain idle.

2. Enter OTP (S1)
Once access is requested, system waits for OTP input.
If OTP is not entered → returns back to Idle.

3. Compare (S2)
The entered OTP is compared with the stored OTP (0x13579).
If match → move to S3.
If mismatch → move to S4.

4. Unlock (S3)
Output signals: correct=1, unlock=1.
Door unlocks.
After one cycle, FSM resets to Idle (S0).
Deny + Alarm (S4)

Output signals: wrong=1, deny=1, alarm=1.
Access denied & alarm triggered.
After one cycle, FSM resets to Idle (S0).
