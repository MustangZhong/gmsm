#include <ctype.h>
#include "BCD.h"

// 将8421BCD码转换为十进制数字串
int BCD2String(char *pcBCDData, int iBCDDataLen, char *strDigitBuf, int iBufLen)
{
    int  iPosFlag = 0;
    char cBCD     = 0;

    if (pcBCDData==NULL || strDigitBuf==NULL)
    {
        printf("BCD2String: pcBCDData==NULL || strDigitBuf==NULL!\n");
        return -1;
    }

    if (2 * iBCDDataLen > iBufLen)
    {
        printf("BCD2String: 2 * iBCDDataLen(%d) > iBufLen(%d)!\n", iBCDDataLen, iBufLen);
        return -1;
    }

    for (iPosFlag = 0; iPosFlag < iBCDDataLen; iPosFlag += 1)
    {
        strDigitBuf[iPosFlag*2] = (pcBCDData[iPosFlag] >> 4) & 0x0F;
        strDigitBuf[iPosFlag*2 + 1] = (pcBCDData[iPosFlag]) & 0x0F;
    }

    return 0;
}


// 将十进制数字串转换为8421BCD码
int String2BCD(char *strDigitData, int strDigitDataLen, char *pcBCDBuf, int iBCDBufLen)
{
    int  iPosFlag = 0;

    if (strDigitData==NULL || pcBCDBuf==NULL)
    {
        printf("String2BCD: strDigitData==NULL || pcBCDBuf==NULL!\n");
        return -1;
    }

    if (strDigitDataLen > 2 * iBCDBufLen)
    {
        printf("String2BCD: strDigitDataLen(%d) > 2 * iBCDBufLen(%d)!\n", strDigitDataLen, iBCDBufLen);
        return -1;
    }

    for (iPosFlag = 0; iPosFlag < strDigitDataLen; iPosFlag+=2)
    {
        pcBCDBuf[iPosFlag / 2] = strDigitData[iPosFlag] << 4;

        if ((iPosFlag + 1 >= strDigitDataLen))
        {
            break;
        }
        pcBCDBuf[iPosFlag / 2] |= strDigitData[iPosFlag + 1];
    }

    return 0;
}

int BCD2HexString(char *pcBCDData, int iBCDDataLen, char *strDigitBuf, int iBufLen)
{
    char *cHex = malloc(iBufLen);
    int oneDecim;
    int i = 0;
    char hexMap[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    BCD2String(pcBCDData, iBCDDataLen, strDigitBuf, iBufLen);
    for (i = 0; i < iBufLen; ++i) {
        cHex[i] = (char)hexMap[(int)strDigitBuf[i]];
    }
    memcpy(strDigitBuf, cHex, iBufLen);

    free(cHex);
}
// 将十进制数字串转换为8421BCD码
int HexString2BCD(char *strDigitData, int strDigitDataLen, char *pcBCDBuf, int iBCDBufLen)
{
    char *cDecimal = malloc(strDigitDataLen);
    char oneHex;
    int i = 0;
    int deciNum = 0;
    for (i = 0; i < strDigitDataLen; ++i) {
        deciNum = 0;
        oneHex = strDigitData[i];

        if(oneHex >= '0' && oneHex <= '9')
        {
            deciNum = oneHex - '0';
        }
        if(oneHex >= 'A' && oneHex <='F')
        {
            deciNum = oneHex - 'A' + 10;
        }
        if(oneHex >= 'a' && oneHex <= 'f')
        {
            deciNum = oneHex - 'a' + 10;
        }

        cDecimal[i] = deciNum;
    }

    String2BCD(cDecimal, strDigitDataLen, pcBCDBuf, iBCDBufLen);
    free(cDecimal);
}
