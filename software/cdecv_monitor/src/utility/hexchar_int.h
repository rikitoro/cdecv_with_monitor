/*
 * hexchar_int.h
 *
 *  Created on: 2016/07/18
 *      Author: yoshiaki
 */

#ifndef HEXCHAR_INT_H_
#define HEXCHAR_INT_H_

enum {
  HEX_CONVERTING_ERR = -1
};

int hexchar_to_int(const char c);
int hex2chars_to_int(const char c0, const char c1);
int hex4chars_to_int(const char c0, const char c1, const char c2, const char c3);

char hex_nth_digit(const int number, const int nth);

#endif /* HEXCHAR_INT_H_ */
