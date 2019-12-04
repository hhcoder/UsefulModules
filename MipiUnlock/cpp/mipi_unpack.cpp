// Practice: MIPI raw data decode
//   This program will read in a binary raw file with specified width and height, then output 16-bit gnd 8-bit grayscale images

// Commandline usage:
//  a.out ../_source_images/mipi_decode_4032x3024.raw 4032 3024 ../_processed_results/mipi_decode_16bit_4032x3024.y ../_processed_results/mipi_decode_8bit_4032x3024.y

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void ReadBuf(const char* in_fname, void* buf, const size_t in_size)
{
	FILE* src_fp = fopen(in_fname, "rb");
	fread(buf, sizeof(unsigned char), in_size, src_fp);
}

void WriteBuf(const char* out_fname, const void* buf, const size_t out_size)
{
	FILE* fp = fopen(out_fname, "wb");
	fwrite(buf, sizeof(unsigned char), out_size, fp);
	fclose(fp);
}

void DecodeToUint8(const unsigned char* src, unsigned char* dst, const int width, const int height)
{
	const unsigned char* proc_src = src;
	unsigned char* proc_dst = dst;

	for (int i = 0; i < width * height; i += 4)
	{
		proc_dst[0] = proc_src[0];
		proc_dst[1] = proc_src[1];
		proc_dst[2] = proc_src[2];
		proc_dst[3] = proc_src[3];

		proc_src += 5;
		proc_dst += 4;
	}
}

void UnpackToUint16(const unsigned char* src, unsigned short* dst, const int width, const int height)
{
	const unsigned char* proc_src = src;

	unsigned short* proc_dst = dst;

	for (int i = 0; i < width * height; i += 4)
	{
		unsigned short val0 = 0;
		val0 += proc_src[0];
		unsigned short val1 = 0;
		val1 += proc_src[1];
		unsigned short val2 = 0;
		val2 += proc_src[2];
		unsigned short val3 = 0;
		val3 += proc_src[3];
		unsigned short val4 = 0;
		val4 += proc_src[4];

		proc_dst[0] = (val0 << 2) | (val4 & 3);
		proc_dst[1] = (val1 << 2) | ((val4 >> 2) & 3);
		proc_dst[2] = (val2 << 2) | ((val4 >> 4) & 3);
		proc_dst[3] = (val3 << 2) | ((val4 >> 6) & 3);

		proc_src += 5;
		proc_dst += 4;
	}
}

void CompressFrom10bitTo8bit(const unsigned short* src, unsigned char* dst, const int width, const int height)
{
	const unsigned short* proc_src = src;
	unsigned char* proc_dst = dst;

	for (int i = 0; i < width*height; i++)
	{
		int p = (*proc_src) / 4;

		if (p > 255)
			*proc_dst = 255;
		else
			*proc_dst = p;

		proc_src++;
		proc_dst++;
	}
}


int main(int argc, char **argv)
{
	const char* in_fname = argv[1];
	const int in_width = atoi(argv[2]);
	const int in_height = atoi(argv[3]);
    const char* out_uint16_name = argv[4];
    const char* out_uint8_name = argv[5];

	const int in_size = in_width * in_height;

	const size_t file_size = in_width * in_height * 10 / 8;
	unsigned char* buf = (unsigned char*)malloc(file_size);

	ReadBuf(in_fname, buf, file_size);

	unsigned short* short_buf = (unsigned short*)malloc(in_size * sizeof(unsigned short));

	UnpackToUint16(buf, short_buf, in_width, in_height);

	WriteBuf(out_uint16_name, short_buf, in_size * sizeof(unsigned short));

	unsigned char* byte_buf = (unsigned char*)malloc(in_size);

	DecodeToUint8(buf, byte_buf, in_width, in_height);

	WriteBuf(out_uint8_name, byte_buf, in_size);

	free(buf);
	free(short_buf);
	free(byte_buf);
}
