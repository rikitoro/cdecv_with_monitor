/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_processor' in SOPC Builder design 'monitor'
 * SOPC Builder design path: ../../monitor.sopcinfo
 *
 * Generated: Mon Aug 15 19:19:31 JST 2016
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00000820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x10
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00008020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x10
#define ALT_CPU_NAME "nios2_processor"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00008000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00000820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x10
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x10
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00008000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2_GEN2


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x0
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/uart"
#define ALT_STDIN_BASE 0x200
#define ALT_STDIN_DEV uart
#define ALT_STDIN_IS_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_uart"
#define ALT_STDOUT "/dev/uart"
#define ALT_STDOUT_BASE 0x200
#define ALT_STDOUT_DEV uart
#define ALT_STDOUT_IS_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_uart"
#define ALT_SYSTEM_NAME "monitor"


/*
 * clock configuration
 *
 */

#define ALT_MODULE_CLASS_clock altera_avalon_pio
#define CLOCK_BASE 0x70
#define CLOCK_BIT_CLEARING_EDGE_REGISTER 0
#define CLOCK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CLOCK_CAPTURE 0
#define CLOCK_DATA_WIDTH 1
#define CLOCK_DO_TEST_BENCH_WIRING 0
#define CLOCK_DRIVEN_SIM_VALUE 0
#define CLOCK_EDGE_TYPE "NONE"
#define CLOCK_FREQ 50000000
#define CLOCK_HAS_IN 0
#define CLOCK_HAS_OUT 1
#define CLOCK_HAS_TRI 0
#define CLOCK_IRQ -1
#define CLOCK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CLOCK_IRQ_TYPE "NONE"
#define CLOCK_NAME "/dev/clock"
#define CLOCK_RESET_VALUE 0
#define CLOCK_SPAN 16
#define CLOCK_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x0
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * onchip_memory configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory altera_avalon_onchip_memory2
#define ONCHIP_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY_BASE 0x8000
#define ONCHIP_MEMORY_CONTENTS_INFO ""
#define ONCHIP_MEMORY_DUAL_PORT 0
#define ONCHIP_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY_INIT_CONTENTS_FILE "monitor_onchip_memory"
#define ONCHIP_MEMORY_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY_IRQ -1
#define ONCHIP_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY_NAME "/dev/onchip_memory"
#define ONCHIP_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY_SIZE_VALUE 32768
#define ONCHIP_MEMORY_SPAN 32768
#define ONCHIP_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY_WRITABLE 1


/*
 * prg_MA configuration
 *
 */

#define ALT_MODULE_CLASS_prg_MA altera_avalon_pio
#define PRG_MA_BASE 0x10
#define PRG_MA_BIT_CLEARING_EDGE_REGISTER 0
#define PRG_MA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PRG_MA_CAPTURE 0
#define PRG_MA_DATA_WIDTH 8
#define PRG_MA_DO_TEST_BENCH_WIRING 0
#define PRG_MA_DRIVEN_SIM_VALUE 0
#define PRG_MA_EDGE_TYPE "NONE"
#define PRG_MA_FREQ 50000000
#define PRG_MA_HAS_IN 0
#define PRG_MA_HAS_OUT 1
#define PRG_MA_HAS_TRI 0
#define PRG_MA_IRQ -1
#define PRG_MA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PRG_MA_IRQ_TYPE "NONE"
#define PRG_MA_NAME "/dev/prg_MA"
#define PRG_MA_RESET_VALUE 0
#define PRG_MA_SPAN 16
#define PRG_MA_TYPE "altera_avalon_pio"


/*
 * prg_RD configuration
 *
 */

#define ALT_MODULE_CLASS_prg_RD altera_avalon_pio
#define PRG_RD_BASE 0x30
#define PRG_RD_BIT_CLEARING_EDGE_REGISTER 0
#define PRG_RD_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PRG_RD_CAPTURE 0
#define PRG_RD_DATA_WIDTH 8
#define PRG_RD_DO_TEST_BENCH_WIRING 0
#define PRG_RD_DRIVEN_SIM_VALUE 0
#define PRG_RD_EDGE_TYPE "NONE"
#define PRG_RD_FREQ 50000000
#define PRG_RD_HAS_IN 1
#define PRG_RD_HAS_OUT 0
#define PRG_RD_HAS_TRI 0
#define PRG_RD_IRQ -1
#define PRG_RD_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PRG_RD_IRQ_TYPE "NONE"
#define PRG_RD_NAME "/dev/prg_RD"
#define PRG_RD_RESET_VALUE 0
#define PRG_RD_SPAN 16
#define PRG_RD_TYPE "altera_avalon_pio"


/*
 * prg_WD configuration
 *
 */

#define ALT_MODULE_CLASS_prg_WD altera_avalon_pio
#define PRG_WD_BASE 0x20
#define PRG_WD_BIT_CLEARING_EDGE_REGISTER 0
#define PRG_WD_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PRG_WD_CAPTURE 0
#define PRG_WD_DATA_WIDTH 8
#define PRG_WD_DO_TEST_BENCH_WIRING 0
#define PRG_WD_DRIVEN_SIM_VALUE 0
#define PRG_WD_EDGE_TYPE "NONE"
#define PRG_WD_FREQ 50000000
#define PRG_WD_HAS_IN 0
#define PRG_WD_HAS_OUT 1
#define PRG_WD_HAS_TRI 0
#define PRG_WD_IRQ -1
#define PRG_WD_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PRG_WD_IRQ_TYPE "NONE"
#define PRG_WD_NAME "/dev/prg_WD"
#define PRG_WD_RESET_VALUE 0
#define PRG_WD_SPAN 16
#define PRG_WD_TYPE "altera_avalon_pio"


/*
 * prg_clock configuration
 *
 */

#define ALT_MODULE_CLASS_prg_clock altera_avalon_pio
#define PRG_CLOCK_BASE 0x40
#define PRG_CLOCK_BIT_CLEARING_EDGE_REGISTER 0
#define PRG_CLOCK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PRG_CLOCK_CAPTURE 0
#define PRG_CLOCK_DATA_WIDTH 1
#define PRG_CLOCK_DO_TEST_BENCH_WIRING 0
#define PRG_CLOCK_DRIVEN_SIM_VALUE 0
#define PRG_CLOCK_EDGE_TYPE "NONE"
#define PRG_CLOCK_FREQ 50000000
#define PRG_CLOCK_HAS_IN 0
#define PRG_CLOCK_HAS_OUT 1
#define PRG_CLOCK_HAS_TRI 0
#define PRG_CLOCK_IRQ -1
#define PRG_CLOCK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PRG_CLOCK_IRQ_TYPE "NONE"
#define PRG_CLOCK_NAME "/dev/prg_clock"
#define PRG_CLOCK_RESET_VALUE 0
#define PRG_CLOCK_SPAN 16
#define PRG_CLOCK_TYPE "altera_avalon_pio"


/*
 * prg_we configuration
 *
 */

#define ALT_MODULE_CLASS_prg_we altera_avalon_pio
#define PRG_WE_BASE 0x50
#define PRG_WE_BIT_CLEARING_EDGE_REGISTER 0
#define PRG_WE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PRG_WE_CAPTURE 0
#define PRG_WE_DATA_WIDTH 1
#define PRG_WE_DO_TEST_BENCH_WIRING 0
#define PRG_WE_DRIVEN_SIM_VALUE 0
#define PRG_WE_EDGE_TYPE "NONE"
#define PRG_WE_FREQ 50000000
#define PRG_WE_HAS_IN 0
#define PRG_WE_HAS_OUT 1
#define PRG_WE_HAS_TRI 0
#define PRG_WE_IRQ -1
#define PRG_WE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PRG_WE_IRQ_TYPE "NONE"
#define PRG_WE_NAME "/dev/prg_we"
#define PRG_WE_RESET_VALUE 0
#define PRG_WE_SPAN 16
#define PRG_WE_TYPE "altera_avalon_pio"


/*
 * reset configuration
 *
 */

#define ALT_MODULE_CLASS_reset altera_avalon_pio
#define RESET_BASE 0x60
#define RESET_BIT_CLEARING_EDGE_REGISTER 0
#define RESET_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RESET_CAPTURE 0
#define RESET_DATA_WIDTH 1
#define RESET_DO_TEST_BENCH_WIRING 0
#define RESET_DRIVEN_SIM_VALUE 0
#define RESET_EDGE_TYPE "NONE"
#define RESET_FREQ 50000000
#define RESET_HAS_IN 0
#define RESET_HAS_OUT 1
#define RESET_HAS_TRI 0
#define RESET_IRQ -1
#define RESET_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RESET_IRQ_TYPE "NONE"
#define RESET_NAME "/dev/reset"
#define RESET_RESET_VALUE 0
#define RESET_SPAN 16
#define RESET_TYPE "altera_avalon_pio"


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0x8
#define SYSID_QSYS_0_ID 65450
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1471255458
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"


/*
 * uart configuration
 *
 */

#define ALT_MODULE_CLASS_uart altera_avalon_uart
#define UART_BASE 0x200
#define UART_BAUD 9600
#define UART_DATA_BITS 8
#define UART_FIXED_BAUD 1
#define UART_FREQ 50000000
#define UART_IRQ 1
#define UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_NAME "/dev/uart"
#define UART_PARITY 'N'
#define UART_SIM_CHAR_STREAM ""
#define UART_SIM_TRUE_BAUD 0
#define UART_SPAN 32
#define UART_STOP_BITS 1
#define UART_SYNC_REG_DEPTH 2
#define UART_TYPE "altera_avalon_uart"
#define UART_USE_CTS_RTS 0
#define UART_USE_EOP_REGISTER 0

#endif /* __SYSTEM_H_ */
