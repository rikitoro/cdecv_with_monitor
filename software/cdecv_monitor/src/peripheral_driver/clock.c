#include "system.h"
#include "altera_avalon_pio_regs.h"

#include "clock.h"

void assert_clock() {
  IOWR_ALTERA_AVALON_PIO_DATA(CLOCK_BASE, 1);
}
void negate_clock() {
  IOWR_ALTERA_AVALON_PIO_DATA(CLOCK_BASE, 0);
}



