#pragma once

#include <utility>
#include <stdint.h>

class DimWH : public std::pair<int32_t, int32_t>
{
public:
	DimWH(int32_t in_width, int32_t in_height)
		: std::pair<int32_t, int32_t>(in_width, in_height)
	{}

	DimWH(const DimWH& rhs)
	{
		first = rhs.first;
		second = rhs.second;
	}

	DimWH& operator=(const DimWH& rhs)
	{
		first = rhs.first;
		second = rhs.second;
		return *this;
	}

	DimWH& IncreaseToEven()
	{
		first = first + first % 2;
		second = second + second % 2;

		return *this;
	}

	inline size_t Size() const { return first*second; }
	inline int32_t Width() const { return first; }
	inline int32_t Height() const { return second; }
};

class DimWHD
{
public:
	DimWHD(const int32_t in_w, const int32_t in_h, const int32_t in_d)
		: width(in_w), height(in_h), depth(in_d)
	{}
	inline int32_t Width() const { return width; }
	inline int32_t Height() const { return height; }
	inline int32_t Depth() const { return depth; }
	DimWHD(const DimWHD& rhs)
		: width(rhs.Width()), height(rhs.Height()), depth(rhs.Depth())
	{
	}
	DimWHD& operator=(const DimWHD& rhs)
	{
		this->width = rhs.Width();
		this->height = rhs.Height();
		this->depth = rhs.Depth();
		return *this;
	}
private:
	int32_t width;
	int32_t height;
	int32_t depth;
};