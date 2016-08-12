/*
 * uart.h
 *
 *  Created on: 2016/07/17
 *      Author: yoshiaki
 */

#ifndef UART_IO_H_
#define UART_IO_H_

int getchar();

void getstr(char* str);
void putstr(const char* str);

void rx_str(char* str);
void tx_str(const char* str);

#endif /* UART_IO_H_ */
