#pragma once

#include <vector>

#include "./dpd_dim.h"

#include "../../../dual_pd_dump_info/public/dpdcore_dump_info.h"

template <typename T>
class BaseFrame : public DpdInfoDumpBase
{
public:
	BaseFrame(const DimWH& in_dim, const T& in_init)
		: dim(in_dim),
		frame(Length(), in_init)
	{
	}

	inline void SetElem(const DimWH& dim, const T& in_val)
	{
		frame[dim.second*width + dim.first] = in_val;
	}

	inline void SetElem(const int32_t x, const int32_t y, const T& in_val)
	{
		frame[y*Width() + x] = in_val;
	}

	inline void SetElem(const int32_t idx, const T& in_val)
	{
		frame[idx] = in_val;
	}

	inline void SetValue(const int32_t x, const int32_t y, const T& in_val)
	{
		frame[y*Width() + x] = in_val;
	}

	inline const T* GetElem(const int32_t x, const int32_t y) const
	{
		return &(frame[y*Width() + x]);
	}

	//TODO: think about returning reference?
	inline T GetValue(const int32_t x, const int32_t y) const
	{
		return (frame[y*Width() + x]);
	}

	inline T* GetElem(const int32_t x, const int32_t y) 
	{
		return &(frame[y*Width() + x]);
	}

	inline const T* GetElem(const size_t idx) const
	{
		return &(frame[idx]);
	}

	inline T* GetElem(const size_t idx)
	{
		return &(frame[idx]);
	}

	inline int32_t Width() const { return dim.first; }
	inline int32_t Height() const { return dim.second; }
	inline size_t Length() const { return dim.Size(); }

	void WriteTxt(const char* fname) const
	{
		std::fstream file(fname, std::fstream::out);

		file << std::string("y_width") << std::endl << Width() << std::endl;
		file << std::string("y_height") << std::endl << Height() << std::endl;
	
		file << std::string("value") << std::endl;

		for (std::vector<T>::const_iterator i = frame.begin(); i != frame.end(); i++)
		{
			file << *i << std::endl;
		}
	}

	virtual void DumpInfoImpl(DpdInfoDump& dout) const
	{
		for (int32_t j = 0; j < Height(); j++)
		{
			for (int32_t i = 0; i < Width(); i++)
			{
				const T* p = GetElem(i, j);
				dout << *p << ",";
			}
			dout << ";..." << DpdInfoDump::endl;
		}
	}

private:
	DimWH dim;

protected:
	std::vector<T> frame;
};