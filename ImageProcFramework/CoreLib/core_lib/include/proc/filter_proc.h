#pragma once

#include <stdint.h>

class FilterProc
{
public:
	static void SliceProc(
		const uint16_t* src,
		uint16_t* depth_map_dst,
		const int32_t proc_width,
		const int32_t proc_height,
		const int32_t proc_stride
	)
	{
		for (int32_t j = 0; j < proc_height; j++)
		{
			const uint16_t* proc_src = src + j*proc_stride;
			uint16_t* proc_dst = depth_map_dst + j*proc_stride;

			//IIRLineProc(proc_src, proc_dst, proc_width);

			//TODO: from tuning/param
			int32_t box_filter_len = 2;
			FIRLineProc(proc_src, proc_dst, proc_width, box_filter_len);
		}
	}

private:
	#define NORM_GAIN_MAP_QFACTOR           (16)
	#define ROUND_IIR(a)((a >= 0) ? (int32_t)(a + 0.5) : (int32_t)(a - 0.5))
	#define MIN2(x, y) (((x)<(y))?(x):(y))
	#define MAX2(x, y) (((x)>(y))?(x):(y))
	#define CLIP(x,a,b) (MIN2(MAX2(x,a),b))

	static void IIRLineProc(
		const uint16_t* src,
		uint16_t* depth_map_dst,
		const int32_t proc_width)
	{
		static const float coeffa[3] = { 1.0f, -1.8732f, 0.8837f }; 
		static const float coeffb[3] = { 0.0582f, 0.0f, -0.0582f };

		float v0, v1, v2;

		v0 = v1 = v2 = 0.0;
		v1 = coeffb[2] * src[0];
		v2 = v1;

		const int16_t lower_bound = ((1 << (NORM_GAIN_MAP_QFACTOR - 1)) * (-1));
		const int16_t upper_bound = ((1 << (NORM_GAIN_MAP_QFACTOR - 1)) - 1);

		for (int32_t col = 0; col < proc_width; col++)
		{		
			float X = (float)src[col];

			v0 = X * coeffb[0] + v1;
			v1 = X * coeffb[1] - v0 * coeffa[1] + v2;
			v2 = X * coeffb[2] - v0 * coeffa[2];

			int32_t int32_IIR_output = (int32_t)ROUND_IIR(v0);

			int16_t int16_IIR_output = (int16_t)(int32_IIR_output >> 1);

			int16_IIR_output = CLIP(int16_IIR_output, lower_bound, upper_bound);

			uint16_t uint16_IIR_output = (uint16_t)(int16_IIR_output + upper_bound + 1);

			depth_map_dst[col] = uint16_IIR_output;
		}
	}

	static void FIRLineProc(
		const uint16_t *src,
		uint16_t *dst,
		const int32_t proc_width,
		const int32_t box_filter_range)
	{
		float v0, v2;

		int32_t int32_IIR_output;
		int16_t int16_IIR_output;
		int16_t lower_bound;
		int16_t upper_bound;
		uint16_t uint16_IIR_output;

		//TODO: rewrite this part
		float* lp = (float*)malloc(sizeof(float)*proc_width);

		//FIR LP
		float pre;
		float filter_len = (float)box_filter_range;
		float block_sum = src[0] * filter_len;

		for (int col = 0; col < proc_width; col++)
		{
			if (col - box_filter_range < 0) pre = src[0];
			else pre = src[col - box_filter_range];
			v2 = block_sum + src[col] - pre;
			lp[col] = v2 / filter_len;
			block_sum = v2;
		}

		const float fir_coeff[5] = { -0.5f, -0.5f, 0.0f, 0.5f, 0.5f };
		const int FIR_SIZE = sizeof(fir_coeff) / sizeof(float);

		//padding to left
		for (int col = 0; col < proc_width; col++)
		{
			v2 = 0;
			for (int j = 0; j < FIR_SIZE; j++)
			{
				int idx;
				idx = col - j;
				if (idx < 0) idx = 0;

				v0 = (float)lp[idx] * fir_coeff[j];
				v2 += v0;
			}

			int32_IIR_output = (int32_t)round(v2) >> 1;

			int16_IIR_output = (int16_t)round(v2);

			lower_bound = ((1 << (NORM_GAIN_MAP_QFACTOR - 1)) * (-1));
			upper_bound = ((1 << (NORM_GAIN_MAP_QFACTOR - 1)) - 1);

			int16_IIR_output = CLIP(int16_IIR_output, lower_bound, upper_bound);

			uint16_IIR_output = (uint16_t)(int16_IIR_output + upper_bound + 1);

			dst[col] = uint16_IIR_output;
		}

		free(lp);
	}

};
