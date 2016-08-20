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
  const int PC = unique('P','C');
  const int RA = unique('R','A');
  const int RB = unique('R','B');
  const int RC = unique('R','C');
  const int RT = unique('R','T');
  const int RR = unique('R','R');
  const int FL = unique('F','L');
  const int XB = unique('X','B');
  const int MA = unique('M','A');
  const int WD = unique('W','D');
  const int RD = unique('R','D');
  const int RI = unique('R','I');
  const int XS = unique('X','S');
  const int XD = unique('X','D');
  const int OP = unique('O','P');
  const int CC = unique('C','C');
  const int WE = unique('W','E');
  const int CL = unique('C','L');
  const int ES = unique('E','S');

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
    //
  } else if (command == PC) {
    return MONITOR_COMMAND_PC;
  } else if (command == RA) {
    return MONITOR_COMMAND_RA;
  } else if (command == RB) {
    return MONITOR_COMMAND_RB;
  } else if (command == RC) {
    return MONITOR_COMMAND_RC;
  } else if (command == RT) {
    return MONITOR_COMMAND_RT;
  } else if (command == RR) {
    return MONITOR_COMMAND_RR;
  } else if (command == FL) {
    return MONITOR_COMMAND_FL;
  } else if (command == XB) {
    return MONITOR_COMMAND_XB;
  } else if (command == MA) {
    return MONITOR_COMMAND_MA;
  } else if (command == WD) {
    return MONITOR_COMMAND_WD;
  } else if (command == RD) {
    return MONITOR_COMMAND_RD;
  } else if (command == RI) {
    return MONITOR_COMMAND_RI;
  } else if (command == XS) {
    return MONITOR_COMMAND_XS;
  } else if (command == XD) {
    return MONITOR_COMMAND_XD;
  } else if (command == OP) {
    return MONITOR_COMMAND_OP;
  } else if (command == CC) {
    return MONITOR_COMMAND_CC;
  } else if (command == WE) {
    return MONITOR_COMMAND_WE;
  } else if (command == CL) {
    return MONITOR_COMMAND_CL;
  } else if (command == ES) {
    return MONIROR_COMMAND_ES;
  } else {
    return MONITOR_COMMAND_ERR;
  }
}

int unique(const char c0, const char c1) {
  return (c0 << 8) + c1;
}
