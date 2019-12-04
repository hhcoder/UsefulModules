#include "./cmdline_image_reader.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

ImageReader* ImageReaderCreate(const char* raw_path, const char* format_str, const char* width_str, const char* height_str)
{
	int w = atoi(width_str);
	int h = atoi(height_str);

	if (!strcmp(format_str, "10BitUnpacked"))
	{
		printf("SourceFileName: %s\n", raw_path);
		printf("Source2pdRawWidth: %d\n", w);
		printf("Source2pdRawHeight: %d\n", h);
		printf("Source2pdRawFormat: 10BitUnpacked\n");
	}
	else
	{
		printf("%s Format is not support!\n", format_str);
		return NULL;
	}

	ImageReader* im = (ImageReader*)malloc(sizeof(ImageReader));
	if (NULL == im)
		return im;

	im->width = w;
	im->height = h;
	im->size_in_bytes = w*h * sizeof(uint16_t);
	im->buf = (uint16_t*)malloc(im->size_in_bytes);
	if (NULL == im->buf)
	{
		free(im);
		return NULL;
	}

	FILE* fp = fopen(raw_path, "rb");
	if (NULL == fp)
	{
		printf("raw input file open failed: %s\n", raw_path);
		free(im->buf);
		free(im);
		return NULL;
	}

	if (im->size_in_bytes != fread(im->buf, 1, im->size_in_bytes, fp))
	{
		printf("raw input file read failed: %s\n", raw_path);
		free(im);
		fclose(fp);
		return NULL;
	}

	fclose(fp);

	return im;
}

void ImageReaderDestroy(ImageReader* im)
{
	if (NULL != im->buf)
		free(im->buf);

	if (NULL != im)
		free(im);
}

YuvReader* YuvReaderCreate(const char* yuv_path, const char* width_str, const char* height_str)
{
	int w = atoi(width_str);
	int h = atoi(height_str);

	printf("YuvFileName: %s\n", yuv_path);
	printf("YuvWidth: %d\n", w);
	printf("YuvHeight: %d\n", h);

	YuvReader* yuv = (YuvReader*)malloc(sizeof(YuvReader));
	if (NULL == yuv)
		return yuv;

	yuv->y_width = w;
	yuv->y_height = h;
	yuv->size_in_bytes = w * h * sizeof(uint8_t) + (w>>1) * h * sizeof(uint8_t);
	yuv->y_buf = (uint8_t*)malloc(yuv->size_in_bytes);
	if (NULL == yuv->y_buf)
	{
		free(yuv);
		return NULL;
	}
	yuv->uv_buf = yuv->y_buf + (w * h);

	FILE* fp = fopen(yuv_path, "rb");
	if (NULL == fp)
	{
		printf("raw input file open failed: %s\n", yuv_path);
		free(yuv->y_buf);
		free(yuv);
		return NULL;
	}

	if (yuv->size_in_bytes != fread(yuv->y_buf, 1, yuv->size_in_bytes, fp))
	{
		printf("raw input file read failed: %s\n", yuv_path);
		free(yuv);
		fclose(fp);
		return NULL;
	}

	fclose(fp);

	return yuv;
}

void YuvReaderDestroy(YuvReader* yuv)
{
	if (NULL != yuv->y_buf)
		free(yuv->y_buf);

	if (NULL != yuv)
		free(yuv);
}
