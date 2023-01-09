#ifndef SHARED_H
#define SHARED_H

extern unsigned long crc32 (unsigned int crc, const unsigned char *buf, unsigned int len);
extern int atari_waitoncardtype(unsigned long crcfile);
extern unsigned char vidBuf[512*512];
#endif
