#pragma once

#include "../../../../dual_pd_api/public/dualpd_system.h"

#include "../../../include/common/dpd_buffer.h"


template <typename T>
class DpdRaw : public External2DBuffer<T>
{
public:
	struct Info
	{
		uint32_t width;
		uint32_t height;
		uint32_t stride;
		uint32_t bits_per_pixel;
		uint32_t unpacked;
		uint32_t lr_pattern;
	};
public:
	DpdRaw(const Info& in_info)
		  : External2DBuffer<T>(in_info.width, in_info.height, in_info.stride)
	{}

	const T* LPtr() const
	{
		return GetBuf();
	}
	
	const T* RPtr() const
	{
		return LPtr() + 1;
	}

	static inline size_t NextPixelOffset() { return 2; }
};
