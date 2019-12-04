#pragma once

#include "../../../include/common/dpd_rect.h"
#include "../../../../dual_pd_dump_info/public/dpdcore_dump_info.h"

#include <stdio.h>
#include <cmath>
#include <utility>

class SrcDim : public DpdInfoDumpBase
{
public:
	SrcDim(
		const int32_t in_width,
		const int32_t in_height,
		const int32_t in_skip_left,
		const int32_t in_skip_right,
		const int32_t in_skip_top,
		const int32_t in_skip_bottom)
		: width(in_width),
		height(in_height),
		skip_left(in_skip_left),
		skip_right(in_skip_right),
		skip_top(in_skip_top),
		skip_bottom(in_skip_bottom)
	{}

	SrcDim(
		const int32_t in_width,
		const int32_t in_height)
		: width(in_width),
		height(in_height),
		skip_left(0),
		skip_right(0),
		skip_top(0),
		skip_bottom(0)
	{}

	//TODO: Split X, Y and put into the same logic
	inline int32_t Width() const { return XEnd() - XStart() + 1; }
	inline int32_t Height() const { return YEnd() - YStart() + 1; }
	inline int32_t XStart() const { return skip_left; }
	inline int32_t XEnd() const { return width - 1 - skip_right; }
	inline int32_t YStart() const { return skip_top; }
	inline int32_t YEnd() const { return height - 1 - skip_bottom; }

	virtual void DumpInfoImpl(DpdInfoDump& dout) const
	{
		dout << "Width, " << Width() << DpdInfoDump::endl;
		dout << "Height" << Height() << DpdInfoDump::endl;
		dout << "XStart" <<  XStart() << DpdInfoDump::endl;
		dout << "XEnd" <<  XEnd() << DpdInfoDump::endl;
		dout << "YStart" <<  YStart() << DpdInfoDump::endl;
		dout << "YEnd" <<  YEnd() << DpdInfoDump::endl;
	}

private:
	int32_t width;
	int32_t height;
	int32_t skip_left;
	int32_t skip_right;
	int32_t skip_top;
	int32_t skip_bottom;
};

class DstDim : public DpdInfoDumpBase
{
public:
	DstDim(
		const int32_t in_width,
		const int32_t in_height,
		const int32_t in_overlap_hor,
		const int32_t in_overlap_vert)
		: width(in_width),
		height(in_height),
		overlap_hor(in_overlap_hor),
		overlap_vert(in_overlap_vert)
	{}

	DstDim(
		const int32_t in_width,
		const int32_t in_height
	)
		: width(in_width),
		height(in_height),
		overlap_hor(0),
		overlap_vert(0)
	{}

	inline int32_t Width() const { return width; }
	inline int32_t Height() const { return height; }
	inline int32_t OverlapHor() const { return overlap_hor; }
	inline int32_t OverlapVert() const { return overlap_vert; }

	virtual void DumpInfoImpl(DpdInfoDump& dout) const
	{
		dout << "Width" << Width() << DpdInfoDump::endl;
		dout << "Height" << Height() << DpdInfoDump::endl;
		dout << "OverlapHor" << OverlapHor() << DpdInfoDump::endl;
		dout << "OverlapVert" << OverlapVert() << DpdInfoDump::endl;
	}

private:
	int32_t width;
	int32_t height;
	int32_t overlap_hor;
	int32_t overlap_vert;
};

class ProcWindow
{
private:
	void SetupCoord(const int32_t src_width, const int32_t dst_width, std::vector<int32_t>& x_start, std::vector<int32_t>& x_end, const int32_t x_overlap)
	{
		//XEnd
		int32_t sum = 0;
		int32_t dst_idx = 0;
		for (int32_t src_idx = 0; src_idx < src_width; src_idx++)
		{
			if (sum >= src_width)
			{
				sum -= src_width;
				x_end[dst_idx] = src_idx;
				dst_idx++;
			}
			sum += dst_width;
		}
		x_end[x_end.size() - 1] = src_width;

		//XStart
		x_start[0] = 0;
		for (size_t i = 0; i < x_start.size()-1; i++)
		{
			x_start[i+1] = x_end[i];
		}

		const int32_t min_idx = 0;
		for (std::vector<int32_t>::iterator i = x_start.begin(); i != x_start.end(); i++)
		{
			int32_t v = *i - x_overlap;
			if (v >= min_idx)
				*i = v;
			else
				*i = min_idx;
		}

		for (std::vector<int32_t>::iterator i = x_end.begin(); i != x_end.end(); i++)
		{
			int32_t v = *i + x_overlap;
			if (v <= src_width)
				*i = v;
			else
				*i = src_width;
		}
	}

	void ApplyOffset(std::vector<int32_t> x_coord, const int32_t x_offset)
	{
		for (std::vector<int32_t>::iterator i = x_coord.begin(); i != x_coord.end(); i++)
		{
			*i += x_offset;
		}
	}

public:
	ProcWindow(
		const SrcDim& in_src_dim,
		const DstDim& in_dst_dim)
		: src_dim(in_src_dim),
		dst_dim(in_dst_dim),
		x_start(dst_dim.Width()),
		x_end(dst_dim.Width()),
		y_start(dst_dim.Height()),
		y_end(dst_dim.Height())
	{
		SetupCoord(src_dim.Width(), dst_dim.Width(), x_start, x_end, dst_dim.OverlapHor());
		const int32_t x_offset = src_dim.XStart();
		ApplyOffset(x_start, x_offset);
		ApplyOffset(x_end, x_offset);

		SetupCoord(src_dim.Height(), dst_dim.Height(), y_start, y_end, dst_dim.OverlapVert());
		const int32_t y_offset = src_dim.YStart();
		ApplyOffset(y_start, y_offset);
		ApplyOffset(y_end, y_offset);
	}

	~ProcWindow()
	{
	}

	void DumpInfo(const std::string& var_name) const
	{
		src_dim.DumpInfo(var_name);
		dst_dim.DumpInfo(var_name);
	}

public:
	//TODO: rename this to DstToSrcRange
	Rect SrcToDstRange(const size_t x_idx, const size_t y_idx) const
	{
		return Rect(x_start[x_idx], x_end[x_idx], y_start[y_idx], y_end[y_idx]);
	}

private:
	SrcDim src_dim;

	DstDim dst_dim;

	std::vector<int32_t> x_start;
	std::vector<int32_t> x_end;
	std::vector<int32_t> y_start;
	std::vector<int32_t> y_end;
};
