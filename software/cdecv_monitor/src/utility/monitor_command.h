#ifndef MONITOR_COMMAND_H_
#define MONITOR_COMMAND_H_

typedef enum {
  MONITOR_COMMAND_ERR = -1, // error
  // reset
  MONITOR_COMMAND_AR  = 1,  // assert reset
  MONITOR_COMMAND_NR  = 2,  // negate reset
  // clock
  MONITOR_COMMAND_AC  = 3,  // assert clock
  MONITOR_COMMAND_NC  = 4,  // negate clock
  // access to memory
  MONITOR_COMMAND_RM  = 5,  // read memory
  MONITOR_COMMAND_WM  = 6,  // write memory
  // debug data
  MONITOR_COMMAND_PC  = 7,  // read PC
  MONITOR_COMMAND_RA  = 8,  // read A
  MONITOR_COMMAND_RB  = 9,  // read B
  MONITOR_COMMAND_RC  = 10, // read C
  MONITOR_COMMAND_RT  = 11, // read T
  MONITOR_COMMAND_RR  = 12, // read R
  MONITOR_COMMAND_FL  = 13, // read FLG
  MONITOR_COMMAND_XB  = 14, // read Xbus
  MONITOR_COMMAND_MA  = 15, // read MA
  MONITOR_COMMAND_WD  = 16, // read WD
  MONITOR_COMMAND_RD  = 17, // read RD
  MONITOR_COMMAND_RI  = 18, // read RI
  MONITOR_COMMAND_XS  = 19, // read xsrc {3bit}
  MONITOR_COMMAND_XD  = 20, // read xdst {10bit}
  MONITOR_COMMAND_OP  = 21, // read aluop (4bit)
  MONITOR_COMMAND_CC  = 22, // read cycle counter
  // debug we, and clock
  MONITOR_COMMAND_WE  = 23, // read we
  MONITOR_COMMAND_CL  = 24, // read clock
  MONIROR_COMMAND_ES  = 25  // read end_sq
} MonitorCommand;

MonitorCommand monitor_command(char* str);

#endif /* MONITOR_COMMAND_H_ */
