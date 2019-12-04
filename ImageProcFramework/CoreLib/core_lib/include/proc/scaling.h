#pragma once

#include <stdint.h>
#include <cmath>

namespace Scaling
{
	template<typename T>
	T Clamp(const T min, const T v, const T max)
	{
		if (v > max)
			return max;
		if (v < min)
			return min;
		return v;
	}

	void Bilinear(
		const uint8_t* src_buf,
		const int32_t src_width,
		const int32_t src_height,
		const int32_t src_stride,
		uint8_t* dst_buf,
		const int32_t dst_width,
		const int32_t dst_height,
		const int32_t dst_stride)
	{
		const float hor_ratio = static_cast<float>(src_width) / static_cast<float>(dst_width);
		const float ver_ratio = static_cast<float>(src_height) / static_cast<float>(dst_height);

		for (int32_t j = 0; j < dst_height; j++)
		{
			const float y = static_cast<float>(j) * ver_ratio;

			const int32_t y0 = Clamp<int32_t>(0, static_cast<int32_t>(std::floor(y)), dst_height - 1);
			const float y0_ratio = y - y0;

			const int32_t y1 = Clamp<int32_t>(0, y0 + 1, dst_height - 1);
			const float y1_ratio = 1.0f - y0_ratio; 

			for (int32_t i = 0; i < dst_width; i++)
			{
				const float x = static_cast<float>(i) * hor_ratio;

				const int32_t x0 = Clamp<int32_t>(0, static_cast<int32_t>(std::floor(x)), dst_width - 1);
				const float x0_ratio = x - x0;

				const int32_t x1 = Clamp<int32_t>(0, x0 + 1, dst_width - 1);
				const float x1_ratio = 1.0f - x0_ratio;

				const float pixel_00 = *(src_buf + y0 * src_stride + x0);
				const float pixel_10 = *(src_buf + y0 * src_stride + x1);
				const float pixel_01 = *(src_buf + y1 * src_stride + x0);
				const float pixel_11 = *(src_buf + y1 * src_stride + x1);

				const float pixel_vert_0 = (pixel_00 * x1_ratio + pixel_10 * x0_ratio);
				const float pixel_vert_1 = (pixel_01 * x1_ratio + pixel_11 * x0_ratio);

				const float pixel = pixel_vert_0 * y1_ratio + pixel_vert_1 * y0_ratio;

				*(dst_buf + j*dst_stride + i) = static_cast<uint8_t>(Clamp<int32_t>(0, static_cast<int32_t>(std::round(pixel)), 255));
			}
		}
	}
};