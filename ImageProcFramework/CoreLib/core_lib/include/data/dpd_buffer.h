#pragma once

#include "./dpd_error.h"
#include <stdio.h>
#include <stdlib.h>

#include "../../../dual_pd_dump_info/public/dpdcore_dump_info.h"

template <typename T>
class Base2DBuffer : public DpdInfoDumpBase
{
public:
	Base2DBuffer(const int32_t in_width, const int32_t in_height, const int32_t in_stride)
		: width(in_width), height(in_height), stride(in_stride), buf(NULL)
	{}

	~Base2DBuffer() {}

	virtual void DumpInfoImpl(DpdInfoDump& dout) const
	{
		for (int32_t j = 0; j < Height(); j++)
		{
			for (int32_t i = 0; i < Width(); i++)
			{
				dout << Get(i, j) << ",";
			}
			dout << ";..." << DpdInfoDump::endl;
		}
	}

	static void Copy(Base2DBuffer<T>* dst, const Base2DBuffer<T>* src)
	{
		size_t sz = sizeof(T)*src->Height()*src->Stride();
		memcpy(dst->buf, src->buf, sz);
	}

	static bool SizeIsTheSame(const Base2DBuffer<T>* src, Base2DBuffer<T>* dst)
	{
		return (src->Width() == dst->Width() &&
			src->Height() == dst->Height() &&
			src->Stride() == dst->Stride());
	}

public:
	inline const T* GetBuf() const { return buf; }
	inline T* GetBuf() { return buf; }
	inline const T* GetBuf(const int32_t x_offset, const int32_t y_offset) const
	{
		return buf + y_offset*Stride() + x_offset;
	}

	inline int32_t Width() const { return width; }
	inline int32_t Height() const { return height; }
	inline int32_t Stride() const { return stride; }
	inline size_t PixelCount() const { return stride*height; }
	inline void Set(const int32_t x_offset, const int32_t y_offset, const T& in_val)
	{
		*(buf + y_offset*Stride() + x_offset) = in_val;
	}
	inline T& Get(const int32_t x, const int32_t y) const { return *(buf + y*Stride() + x); }

protected:
	int32_t width;
	int32_t height;
	int32_t stride;
	T* buf;
};

template <typename T>
class Internal2DBuffer : public Base2DBuffer<T>
{
public:
	Internal2DBuffer(const int32_t in_width, const int32_t in_height)
		: Base2DBuffer<T>(in_width, in_height, in_width)
	{
		buf = (T*)malloc(sizeof(T)*PixelCount());
		if (NULL == buf)
			throw "Error in allocating Internal2DBuffer";
	}

	~Internal2DBuffer()
	{
		if (NULL != buf)
			free(buf);
	}
};

template <typename T>
class External2DBuffer : public Base2DBuffer<T>
{
public:
	External2DBuffer(const int32_t in_width, const int32_t in_height, const int32_t in_stride)
		: Base2DBuffer(in_width, in_height, in_stride)
	{}

	~External2DBuffer() {}

	void SetExternalBuffer(const void* in_buf)
	{
		buf = (T*)in_buf;
	}
};
