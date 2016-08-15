`default_nettype none

module datapath(
  input wire        clock,
  input wire        reset,
  // datapath <-> memory
  input wire  [7:0] RD,
  output wire [7:0] MA,
  output wire [7:0] WD,
  // datapath <-> control unit
  input wire  [2:0] xsrc,     // read {7:FF, 6:FLG, 5:R, 4:RD, 3:C, 2:B, 1:A, 0:PC}
  input wire  [9:0] xdst,     // write enable {9:FLG, 8:R, 7:T, 6:I, 5:WD, 4:MA, 3:C, 2:B, 1:A, 0:PC} 
  input wire  [3:0] aluop,    // select alu operation
  output wire [7:0] I,
  output wire [2:0] SZCy,     // from FLG {S, Z, Cy}
  
  // debug monitor
  input wire  [2:0] dbg_addr, // {7:Xbus, 6:FLG, 5:R, 4:T, 3:C, 2:B, 1:A, 0:PC}
  output wire [7:0] dbg_data
  );
  
  // Xbus
  wire [7:0]  Xbus;
  
  // program counter
  wire [7:0]  PC;

  register_r PCreg(
    .clock  (clock),
    .reset  (reset),
    .we     (xdst[0]),
    .d      (Xbus),
    .q      (PC));
    

  // general purpose registers A, B, C
  wire [7:0]  A, B, C;
  
  register Areg(
    .clock  (clock),
    .we     (xdst[1]),
    .d      (Xbus),
    .q      (A));
    
  register Breg(
    .clock  (clock),
    .we     (xdst[2]),
    .d      (Xbus),
    .q      (B));
  
  register Creg(
    .clock  (clock),
    .we     (xdst[3]),
    .d      (Xbus),
    .q      (C));
    
    
  // memory access registers MA, WD
  register MAreg(
    .clock  (clock),
    .we     (xdst[4]),
    .d      (Xbus),
    .q      (MA));
    
  register WDreg(
    .clock  (clock),
    .we     (xdst[5]),
    .d      (Xbus),
    .q      (WD));
  
  // Instruction register I
  register Ireg(
    .clock  (clock),
    .we     (xdst[6]),
    .d      (Xbus),
    .q      (I));
    
  // temporary register T
  wire [7:0]  T;
  
  register Treg(
    .clock  (clock),
    .we     (xdst[7]),
    .d      (Xbus),
    .q      (T));
  
  // ALU, R, FLG
  wire [7:0] R, FLG;
  wire [7:0] alu_result;
  wire [2:0] alu_SZCy;
  
  alu alu(
    .aluop  (aluop),
    .a      (Xbus),
    .b      (T),
    .Cy_in  (FLG[1]),
    .result (alu_result),
    .SZCy   (alu_SZCy));
    
  register Rreg(
    .clock  (clock),
    .we     (xdst[8]),
    .d      (alu_result),
    .q      (R));
    
  register FLGreg(
    .clock  (clock),
    .we     (xdst[9]),
    .d      ({4'b0000,alu_SZCy,1'b0}),
    .q      (FLG));
    
  assign SZCy = FLG[3:1];
  
  // regs => Xbus
  mux8 xsrc_mux8(
    .sel  (xsrc),
    .d0   (PC),
    .d1   (A),
    .d2   (B),
    .d3   (C),
    .d4   (RD),
    .d5   (R),
    .d6   (FLG),
    .d7   (8'hff),
    .y    (Xbus));
    
    
  ///// for debug interface

  mux8 dbg_mux8(
    .sel  (dbg_addr), // {7:Xbus, 6:FLG, 5:R, 4:T, 3:C, 2:B, 1:A, 0:PC}
    .d0   (PC),
    .d1   (A),
    .d2   (B),
    .d3   (C),
    .d4   (T),
    .d5   (R),
    .d6   (FLG),
    .d7   (Xbus),
    .y    (dbg_data));
    
endmodule