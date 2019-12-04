#pragma once

#include "../../../include/common/dpd_buffer.h"

#include <algorithm>

template <typename T>
class IntegratedFrame
{
public:
	IntegratedFrame(const int32_t raw_width, const int32_t raw_height, const int32_t in_integrate_length)
		: integrate_length(in_integrate_length),
		left_buf(raw_width/2, (int32_t)ceil((float)raw_height/integrate_length)),
		right_buf(raw_width/2, (int32_t)ceil((float)raw_height/integrate_length))
	{
	}

	void SubtractBlackLevel(const T& black_level)
	{
		SubtractBlackLevel(left_buf, black_level);
		SubtractBlackLevel(right_buf, black_level);
	}

	void DumpInfo(const std::string& left_name, const std::string& right_name) const
	{
		left_buf.DumpInfo(left_name);
		right_buf.DumpInfo(right_name);
	}

	inline int32_t GetIntegLength() const { return integrate_length; }

private:
	static void SubtractBlackLevel(Internal2DBuffer<T>& buf, const T& black_level)
	{
		T* ptr = buf.GetBuf();
		T* p = ptr;
		for (size_t i = 0; i < buf.PixelCount(); i++)
		{
			if (*p > black_level)
				*p = *p - black_level;
			else
				*p = 0;
			p++;
		}
	}

public:
	int32_t integrate_length;
	Internal2DBuffer<T> left_buf;
	Internal2DBuffer<T> right_buf;
};
