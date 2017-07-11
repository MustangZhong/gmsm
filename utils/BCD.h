/**
 * bcd compress
 */

#ifndef BCD_H
#define BCD_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int BCD2String(char *pcBCDData, int iBCDDataLen, char *strDigitBuf, int iBufLen);
int String2BCD(char *strDigitData, int strDigitDataLen, char *pcBCDBuf, int iBCDBufLen);
int BCD2HexString(char *pcBCDData, int iBCDDataLen, char *strDigitBuf, int iBufLen);
int HexString2BCD(char *strDigitData, int strDigitDataLen, char *pcBCDBuf, int iBCDBufLen);
#endif
