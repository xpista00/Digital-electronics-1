1. A half adder has two inputs A and B and two outputs Carry and Sum. Comlpete the half adder truth table. Draw a logic diagram of both output functions.

   | **B** | **A** | **Carry** | **Sum** |
   | :-: | :-: | :-: | :-: |
   | 0 | 0 | 0 | 0 |
   | 0 | 1 | 0 | 1 |
   | 1 | 0 | 0 | 1 |
   | 1 | 1 | 1 | 0 |

Sum = XOR
Carry = AND


2. A full adder has three inputs and two outputs. The two inputs are A, B, and Carry input. The outputs are Carry output and Sum. Comlpete the full adder truth table and draw a logic diagram of both output functions.

   | **Cin** | **B** | **A** | **Cout** | **Sum** |
   | :-: | :-: | :-: | :-: | :-: |
   | 0 | 0 | 0 | 0 | 0 |
   | 0 | 0 | 1 | 0 | 1 |
   | 0 | 1 | 0 | 0 | 1 |
   | 0 | 1 | 1 | 1 | 0 |
   | 1 | 0 | 0 | 0 | 1 |
   | 1 | 0 | 1 | 1 | 0 |
   | 1 | 1 | 0 | 1 | 0 |
   | 1 | 1 | 1 | 1 | 1 |

Sum = XOR (A xor B xor Cin)
Cout=AB+BCin+ACin
