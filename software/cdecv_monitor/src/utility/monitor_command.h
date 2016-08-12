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
} MonitorCommand;

MonitorCommand monitor_command(char* str);

#endif /* MONITOR_COMMAND_H_ */
