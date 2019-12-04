#ifndef _CMDLINE_IMAGE_READER_H_
#define _CMDLINE_IMAGE_READER_H_

#include <stdint.h>

typedef struct _ImageReader
{
	size_t width;
	size_t height;
	size_t size_in_bytes;
	unsigned short* buf;
} ImageReader; 

ImageReader* ImageReaderCreate(const char* raw_path, const char* format_str, const char* width_str, const char* height_str);

void ImageReaderDestroy(ImageReader* im);

typedef struct _YuvReader
{
	size_t y_width;
	size_t y_height;
	size_t size_in_bytes;
	uint8_t* y_buf;
	uint8_t* uv_buf;
} YuvReader;

YuvReader* YuvReaderCreate(const char* yuv_path, const char* width_str, const char* height_str);

void YuvReaderDestroy(YuvReader* yuv);

#endif //_CMDLINE_IMAGE_READER_H_