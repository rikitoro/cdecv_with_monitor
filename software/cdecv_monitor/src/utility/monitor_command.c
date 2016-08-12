/*
 * monitor_command.c
 *
 *  Created on: 2016/07/20
 *      Author: yoshiaki
 */

#include "monitor_command.h"

//
int unique(const char c0, const char c1); //


MonitorCommand monitor_command(char* str) {
  //
  const int AR = unique('A','R');
  const int NR = unique('N','R');
  const int AC = unique('A','C');
  const int NC = unique('N','C');
  const int RM = unique('R','M');
  const int WM = unique('W','M');
  //
  const int command = unique(str[0], str[1]);

  if (command == AR) {
    return MONITOR_COMMAND_AR;
  } else if (command == NR) {
    return MONITOR_COMMAND_NR;
  } else if (command == AC) {
    return MONITOR_COMMAND_AC;
  } else if (command == NC) {
    return MONITOR_COMMAND_NC;
  } else if (command == RM) {
    return MONITOR_COMMAND_RM;
  } else if (command == WM) {
    return MONITOR_COMMAND_WM;
  } else {
    return MONITOR_COMMAND_ERR;
  }
}

int unique(const char c0, const char c1) {
  return (c0 << 8) + c1;
}
