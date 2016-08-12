#include "system.h"
#include "altera_avalon_pio_regs.h"

#include "reset.h"

void assert_reset() {
  IOWR_ALTERA_AVALON_PIO_DATA(RESET_BASE, 1);
}
void negate_reset() {
  IOWR_ALTERA_AVALON_PIO_DATA(RESET_BASE, 0);
}

