/*
 * hexformat.h
 *
 *  Created on: 2016/07/18
 *      Author: yoshiaki
 */

#ifndef HEXFORMAT_H_
#define HEXFORMAT_H_

int bytecount_of_hexformat(const char* hf);
int address_of_hexformat(const char* hf);
int recordtype_of_hexformat(const char* hf);
char data_of_hexformat(const char* hf, const int n);
char checksum_of_hexformat(const char* hf);

#endif /* HEXFORMAT_H_ */
