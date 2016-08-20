#include "system.h"
#include "altera_avalon_pio_regs.h"

#include "dbg.h"


int dbg(const char dbg_addr) {
  IOWR_ALTERA_AVALON_PIO_DATA(DBG_ADDR_BASE, dbg_addr);
  return IORD_ALTERA_AVALON_PIO_DATA(DBG_DATA_BASE);
}

int dbg_PC() {
  return dbg(0x0);
}

int dbg_A() {
  return dbg(0x1);
}

int dbg_B() {
  return dbg(0x2);
}

int dbg_C() {
  return dbg(0x3);
}
int dbg_T() {
  return dbg(0x4);
}

int dbg_R() {
  return dbg(0x5);
}

int dbg_FLG() {
  return dbg(0x6);
}

int dbg_Xbus() {
  return dbg(0x7);
}

int dbg_MA() {
  return dbg(0x8);
}

int dbg_WD() {
  return dbg(0x9);
}

int dbg_RD() {
  return dbg(0xa);
}

int dbg_I() {
  return dbg(0xb);
}

int dbg_xsrc() {
  return dbg(0xc);
}
int dbg_xdst() {
  return dbg(0xd);
}

int dbg_aluop() {
  return dbg(0xe);
}

int dbg_cycle_count() {
  return dbg(0xf);
}


char dbg_clock() {
  return (char)IORD_ALTERA_AVALON_PIO_DATA(DBG_CLOCK_BASE);
}

char dbg_we() {
  return (char)IORD_ALTERA_AVALON_PIO_DATA(DBG_WE_BASE);
}

char dbg_end_sq() {
  return (char)IORD_ALTERA_AVALON_PIO_DATA(DBG_END_SQ_BASE);
}
