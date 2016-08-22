/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
// drivers
#include "peripheral_driver/uart.h"
#include "peripheral_driver/reset.h"
#include "peripheral_driver/clock.h"
#include "peripheral_driver/memory.h"
// utility
#include "utility/monitor_command.h"
// data
#include "memory_data.h"
#include "debug_data.h"

const char* EOF = ":00000001FF\r\n";

//////////
void do_AR();
void do_NR();
void do_AC();
void do_NC();
//
void do_RM(const char* hf);
void do_WM(const char* hf);
//
void do_PC();
void do_RA();
void do_RB();
void do_RC();
void do_RT();
void do_RR();
void do_FL();
void do_XB();
void do_MA();
void do_WD();
void do_RD();
void do_RI();
void do_XS();
void do_XD();
void do_OP();
void do_CC();
void do_WE();
void do_CL();
void do_ES();
//
void do_default();
//////////


int main()
{ 
  char rx_msg[600];

  //alt_putstr("Hello, This is Tiny MIPS monitor!\r\n");
  tx_str(EOF);

  while (1) {
    rx_str(rx_msg);

    switch (monitor_command(rx_msg)) {
      case MONITOR_COMMAND_AR:  // assert reset
        do_AR();            break;
      case MONITOR_COMMAND_NR:  // negate reset
        do_NR();            break;
      case MONITOR_COMMAND_AC:  // assert clock
        do_AC();            break;
      case MONITOR_COMMAND_NC:  // negate clock
        do_NC() ;           break;
      case MONITOR_COMMAND_RM:  // read memory
        do_RM(&rx_msg[2]);  break;
      case MONITOR_COMMAND_WM:  // write memory
        do_WM(&rx_msg[2]);  break;
        //
      case MONITOR_COMMAND_PC:  // read PC
        do_PC();            break;
      case MONITOR_COMMAND_RA:  // read A
        do_RA();            break;
      case MONITOR_COMMAND_RB:  // read B
        do_RB();            break;
      case MONITOR_COMMAND_RC:  // read C
        do_RC();            break;
      case MONITOR_COMMAND_RT:  // read T
        do_RT();            break;
      case MONITOR_COMMAND_RR:  // read R
        do_RR();            break;
      case MONITOR_COMMAND_FL:  // read FLG
        do_FL();            break;
      case MONITOR_COMMAND_XB:  // read Xbus
        do_XB();            break;
      case MONITOR_COMMAND_MA:  // read MA
        do_MA();            break;
      case MONITOR_COMMAND_WD:  // read WD
        do_WD();            break;
      case MONITOR_COMMAND_RD:  // read RD
        do_RD();            break;
      case MONITOR_COMMAND_RI:  // read RI
        do_RI();            break;
      case MONITOR_COMMAND_XS:  // read xsrc {3bit}
        do_XS();            break;
      case MONITOR_COMMAND_XD:  // read xdst {10bit}
        do_XD();            break;
      case MONITOR_COMMAND_OP:  // read aluop (4bit)
        do_OP();            break;
      case MONITOR_COMMAND_CC:  // read cycle counter
        do_CC();            break;
      // debug we, and clock
      case MONITOR_COMMAND_WE:  // read we
        do_WE();            break;
      case MONITOR_COMMAND_CL:  // read clock
        do_CL();            break;
      case MONIROR_COMMAND_ES:  // read end_sq
        do_ES();            break;
      default:
        do_default();       break;
    }
  }
}


//////

void do_AR() {
  assert_reset();
  tx_str(EOF);
}

void do_NR() {
  negate_reset();
  tx_str(EOF);
}

void do_AC() {
  assert_clock();
  tx_str(EOF);
}

void do_NC(){
  negate_clock();
  tx_str(EOF);
}

void do_RM(const char* hf) {
  MemoryData md;
  char tx_msg[522];

  shorthexformat_to_memorydata(hf, &md);
  read_memory(&md);
  memorydata_to_hexformat(&md, tx_msg);
  tx_str(tx_msg);
}

void do_WM(const char* hf) {
  MemoryData md;

  hexformat_to_memorydata(hf, &md);
  write_memory(&md);
  tx_str(EOF);
}

//
void do_PC() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_PC(), tx_msg);
  tx_str(tx_msg);
}

void do_RA() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_A(), tx_msg);
  tx_str(tx_msg);
}

void do_RB() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_B(), tx_msg);
  tx_str(tx_msg);
}

void do_RC() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_C(), tx_msg);
  tx_str(tx_msg);
}

void do_RT() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_T(), tx_msg);
  tx_str(tx_msg);
}

void do_RR() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_R(), tx_msg);
  tx_str(tx_msg);
}

void do_FL() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_FLG(), tx_msg);
  tx_str(tx_msg);
}

void do_XB() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_Xbus(), tx_msg);
  tx_str(tx_msg);
}
void do_MA() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_MA(), tx_msg);
  tx_str(tx_msg);
}

void do_WD() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_WD(), tx_msg);
  tx_str(tx_msg);
}

void do_RD() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_RD(), tx_msg);
  tx_str(tx_msg);
}


void do_RI() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_I(), tx_msg);
  tx_str(tx_msg);

}
void do_XS() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_xsrc(), tx_msg);
  tx_str(tx_msg);
}
void do_XD() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_xdst(), tx_msg);
  tx_str(tx_msg);
}

void do_OP() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_aluop(), tx_msg);
  tx_str(tx_msg);
}
void do_CC() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_cycle_count(), tx_msg);
  tx_str(tx_msg);
}

void do_WE() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_we(), tx_msg);
  tx_str(tx_msg);
}

void do_CL() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_clock(), tx_msg);
  tx_str(tx_msg);
}

void do_ES() {
  char tx_msg[20];
  debugdata16_to_hexformat(dbg_end_sq(), tx_msg);
  tx_str(tx_msg);
}

void do_default() {
  tx_str(EOF);
}

