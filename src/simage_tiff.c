/*
 * based on example code found in libtiff
 * 
 */

#include "simage_tiff.h"
#include <stdio.h>

#include <tiffio.h>

#include <string.h>
#include <stdarg.h>
#include <assert.h>
#include <stdlib.h>

#define ERR_NO_ERROR    0
#define ERR_OPEN        1
#define ERR_READ        2
#define ERR_MEM         3
#define ERR_UNSUPPORTED 4
#define ERR_TIFFLIB     5

static int tifferror = ERR_NO_ERROR;

int
simage_tiff_error(char * buffer, int buflen)
{
  switch (tifferror) {
  case ERR_OPEN:
    strncpy(buffer, "TIFF loader: Error opening file", buflen);
    break;
  case ERR_MEM:
    strncpy(buffer, "TIFF loader: Out of memory error", buflen);
    break;
  case ERR_UNSUPPORTED:
    strncpy(buffer, "TIFF loader: Unsupported image type", buflen);
    break;    
  case ERR_TIFFLIB:
    strncpy(buffer, "TIFF loader: Illegal tiff file", buflen);
    break;
  }
  return tifferror;
}


static void 
tiff_error(const char* module, const char* fmt, va_list list)
{
  /* FIXME: store error message ? */
}

static void 
tiff_warn(const char * module, const char * fmt, va_list list)
{
  /* FIXME: notify? */
}

static int
checkcmap(int n, uint16* r, uint16* g, uint16* b)
{
  while (n-- > 0)
    if (*r++ >= 256 || *g++ >= 256 || *b++ >= 256)
      return (16);
  /* Assuming 8-bit colormap */
  return (8);
}

static void 
invert_row(unsigned char *ptr, unsigned char *data, int n, int invert)
{
  while (n--) {
    if (invert) *ptr++ = 255 - *data++;
    else *ptr++ = *data++;
  }
}


static void 
remap_row(unsigned char *ptr, unsigned char *data, int n,
	  unsigned short *rmap, unsigned short *gmap, unsigned short *bmap)
{
  unsigned int ix;
  while (n--) {
    ix = *data++;
    *ptr++ = rmap[ix];
    *ptr++ = gmap[ix];
    *ptr++ = bmap[ix];
  }
}

static void 
copy_row(unsigned char *ptr, unsigned char *data, int n)
{
  while (n--) {
    *ptr++ = *data++;
    *ptr++ = *data++;
    *ptr++ = *data++;
  }
}

static void 
interleave_row(unsigned char *ptr,
	       unsigned char *red, unsigned char *blue, unsigned char *green,
	       int n)
{
  while (n--) {
    *ptr++ = *red++;
    *ptr++ = *green++;
    *ptr++ = *blue++;
  }
}

int 
simage_tiff_identify(const char *ptr,
		     const unsigned char *header,
		     int headerlen)
{
  static unsigned char tifcmp[] = {0x4d, 0x4d, 0x0, 0x2a, 0, 0};
  static unsigned char tifcmp2[] = {0x49, 0x49, 0x2a, 0}; 

  if (headerlen < 6) return 0;
  if (memcmp((const void*)header, (const void*)tifcmp, 6) == 0) return 1;
  if (memcmp((const void*)header, (const void*)tifcmp2, 4) == 0) return 1;
  return 0;
}

/* useful defines (undef'ed below) */
#define	CVT(x)		(((x) * 255L) / ((1L<<16)-1))
#define	pack(a,b)	((a)<<8 | (b))

unsigned char *
simage_tiff_load(const char *filename,
		  int *width_ret,
		  int *height_ret,
		  int *numComponents_ret)
{
  TIFF *in;
  uint16 samplesperpixel;
  uint16 bitspersample;
  uint16 photometric;
  uint32 w, h;
  uint16 config;
  uint16* red;
  uint16* green;
  uint16* blue;
  unsigned char *inbuf = NULL;
  tsize_t rowsize;
  uint32 row;
  int format;
  unsigned char *buffer;
  int width;
  int height;
  unsigned char *currPtr;


  TIFFSetErrorHandler(tiff_error);
  TIFFSetWarningHandler(tiff_warn);
  
  in = TIFFOpen(filename, "r");
  if (in == NULL) {
    tifferror = ERR_OPEN;
    return NULL;
  }  
  if (TIFFGetField(in, TIFFTAG_PHOTOMETRIC, &photometric) == 1) {
    if (photometric != PHOTOMETRIC_RGB && photometric != PHOTOMETRIC_PALETTE &&
	photometric != PHOTOMETRIC_MINISWHITE && 
	photometric != PHOTOMETRIC_MINISBLACK) {
      /*Bad photometric; can only handle Grayscale, RGB and Palette images :-( */
      TIFFClose(in);
      tifferror = ERR_UNSUPPORTED;
      return NULL;
    }
  }
  else {
    tifferror = ERR_READ;
    TIFFClose(in);
    return NULL;
  }
  
  if (TIFFGetField(in, TIFFTAG_SAMPLESPERPIXEL, &samplesperpixel) == 1) {
    if (samplesperpixel != 1 && samplesperpixel != 3) {
      /* Bad samples/pixel */
      tifferror = ERR_UNSUPPORTED;
      TIFFClose(in);
      return NULL;
    }
  }
  else {
    tifferror = ERR_READ;
    TIFFClose(in);
    return NULL;
  }
	
  if (TIFFGetField(in, TIFFTAG_BITSPERSAMPLE, &bitspersample) == 1) {
    if (bitspersample != 8) {
      /* can only handle 8-bit samples. */
      TIFFClose(in);
      tifferror = ERR_UNSUPPORTED;
      return NULL;
    }
  }
  else {
    tifferror = ERR_READ;
    TIFFClose(in);
    return NULL;
  }

  if (TIFFGetField(in, TIFFTAG_IMAGEWIDTH, &w) != 1 ||
      TIFFGetField(in, TIFFTAG_IMAGELENGTH, &h) != 1 ||
      TIFFGetField(in, TIFFTAG_PLANARCONFIG, &config) != 1) {
    TIFFClose(in);
    tifferror = ERR_READ;
    return NULL;
  }
  
  if (photometric == PHOTOMETRIC_MINISWHITE || 
      photometric == PHOTOMETRIC_MINISBLACK)
    format = 1;
  else
    format = 3;

  buffer = (unsigned char*)malloc(w*h*format);
  
  if (!buffer) {
    tifferror = ERR_MEM;
    TIFFClose(in);
    return NULL;
  }

  width = w;
  height = h;
  
  currPtr = buffer + (h-1)*w*format;
  
  tifferror = ERR_NO_ERROR;

  switch (pack(photometric, config)) {
  case pack(PHOTOMETRIC_MINISWHITE, PLANARCONFIG_CONTIG):
  case pack(PHOTOMETRIC_MINISBLACK, PLANARCONFIG_CONTIG):
  case pack(PHOTOMETRIC_MINISWHITE, PLANARCONFIG_SEPARATE):
  case pack(PHOTOMETRIC_MINISBLACK, PLANARCONFIG_SEPARATE):

    inbuf = (unsigned char *)malloc(TIFFScanlineSize(in));
    for (row = 0; row < h; row++) {
      if (TIFFReadScanline(in, inbuf, row, 0) < 0) {
	tifferror = ERR_READ;
	break;
      }
      invert_row(currPtr, inbuf, w, photometric == PHOTOMETRIC_MINISWHITE);  
      currPtr -= format*w;
    }
    break;
    
  case pack(PHOTOMETRIC_PALETTE, PLANARCONFIG_CONTIG):
  case pack(PHOTOMETRIC_PALETTE, PLANARCONFIG_SEPARATE):
    if (TIFFGetField(in, TIFFTAG_COLORMAP, &red, &green, &blue) != 1)
      tifferror = ERR_READ;
    /* */
    /* Convert 16-bit colormap to 8-bit (unless it looks */
    /* like an old-style 8-bit colormap). */
    /* */
    if (!tifferror && checkcmap(1<<bitspersample, red, green, blue) == 16) {
      int i;
      for (i = (1<<bitspersample)-1; i >= 0; i--) {
	red[i] = CVT(red[i]);
	green[i] = CVT(green[i]);
	blue[i] = CVT(blue[i]);
      }
    }

    inbuf = (unsigned char *)malloc(TIFFScanlineSize(in));
    for (row = 0; row < h; row++) {
      if (TIFFReadScanline(in, inbuf, row, 0) < 0) {
	tifferror = ERR_READ;
	break;
      }
      remap_row(currPtr, inbuf, w, red, green, blue);
      currPtr -= format*w;
    }
    break;

  case pack(PHOTOMETRIC_RGB, PLANARCONFIG_CONTIG):
    inbuf = (unsigned char *)malloc(TIFFScanlineSize(in));
    for (row = 0; row < h; row++) {
      if (TIFFReadScanline(in, inbuf, row, 0) < 0) {
	tifferror = ERR_READ;
	break;
      }
      copy_row(currPtr, inbuf, w);  
      currPtr -= format*w;
    }
    break;

  case pack(PHOTOMETRIC_RGB, PLANARCONFIG_SEPARATE):
    rowsize = TIFFScanlineSize(in);
    inbuf = (unsigned char *)malloc(3*rowsize);
    for (row = 0; !tifferror && row < h; row++) {
      int s;
      for (s = 0; s < 3; s++) {
	if (TIFFReadScanline(in, inbuf+s*rowsize, row, s) < 0) {
	  tifferror = ERR_READ; break;
	}
      }
      if (!tifferror) {
	interleave_row(currPtr, inbuf, inbuf+rowsize, inbuf+2*rowsize, w);
	currPtr -= format*w;
      }
    }
    break;
  default:
    tifferror = ERR_UNSUPPORTED;
    break;
  }
  
  if (inbuf) free(inbuf);
  TIFFClose(in);
  
  if (tifferror) {
    if (buffer) free(buffer);
    return NULL;
  }
  *width_ret = width;
  *height_ret = height;
  *numComponents_ret = format;
  return buffer;
}

#undef CVT
#undef pack