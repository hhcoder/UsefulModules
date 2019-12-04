/*
#pragma once

#include <vector>
#include <utility>
#include <iostream>
#include <algorithm>

#include "../../data/pyramid_frame/pyramid_frame.h"

class PyramidProc
{
public:
	static void BuildPyramid(
		PdFrame* in_pd_frame, 
		ConfidenceFrame* in_conf_frame, 
		PyramidFrame* pyramid_frame, 
		const size_t decompose_level)
	{
		pyramid_frame->SetBaseframe(in_pd_frame, in_conf_frame);

		for (size_t i = 1; i < decompose_level; i++)
		{
			GeneratePyramid(pyramid_frame, i);
		}
	}

	static void ReConstructImage(PyramidFrame* pyramid_frame)
	{
		const size_t base_level = 0;
		for (int32_t j = 0; j < pyramid_frame->Height(base_level); j++)
		{
			for (int32_t i = 0; i < pyramid_frame->Width(base_level); i++)
			{
				PdPair pd_pair = ReBuildPixel(pyramid_frame, base_level, i, j);
				pyramid_frame->Set(base_level, i, j, pd_pair);
			}
		}
	}

private:
	static void GeneratePyramid(
		PyramidFrame* pyramid_frame, 
		const int32_t level)
	{
		for (int32_t j = 0; j < pyramid_frame->Height(level); j++)
		{
			for (int32_t i = 0; i < pyramid_frame->Width(level); i++)
			{
				const PdPair left_top = pyramid_frame->Get(level - 1, i*2, j*2);
				const PdPair right_top = pyramid_frame->Get(level - 1, i*2 + 1, j*2);
				const PdPair left_bottom = pyramid_frame->Get(level - 1, i*2, j*2 + 1);
				const PdPair right_bottom = pyramid_frame->Get(level - 1, i*2 + 1, j*2 + 1);

				PdPair sum = Sum4(left_top, right_top, left_bottom, right_bottom);

				pyramid_frame->Set(level, i, j, sum);
			}
		}
	}

	static float PdDifference(const PdPair& a, const PdPair& b)
	{
		return std::abs(a.first - b.first);
	}
	
	static PdPair ReBuildPixel(
		PyramidFrame* pyramid_frame,
		const size_t level,
		const int32_t x,
		const int32_t y	)
	{
		const size_t max_level = pyramid_frame->MaxLevel();
		PdPair curr_pixel = pyramid_frame->Get(level, x, y);
		if (level == max_level)
			return curr_pixel;

		return curr_pixel;

		PdPair parent_pixel = pyramid_frame->Get(level + 1, x/2, y/2);
		//TODO: get the curve from tuning (if there's a curve)
		const float threshold = (level + 1)*0.3f;
		if (PdDifference(curr_pixel, parent_pixel) < threshold )
		{
			return curr_pixel;
		}
		else
		{
			return ReBuildPixel(pyramid_frame, level + 1, x / 2, y / 2);
		}
	}

	//static PdPair ReBuildPixel(
	//	PyramidFrame* pyramid_frame,
	//	const size_t level,
	//	const int32_t x,
	//	const int32_t y)
	//{
	//	const uint8_t threshold = 128;

	//	size_t max_level = pyramid_frame->MaxLevel();
	//	PdPair curr_pixel = pyramid_frame->Get(level, x, y);
	//	if (level==max_level || curr_pixel.second >= threshold )
	//	{
	//		return curr_pixel;
	//	}
	//	else
	//	{
	//		const int32_t x_offset = (int32_t)(floor(x/2));
	//		const int32_t y_offset = (int32_t)(floor(y/2));
	//		return ReBuildPixel(pyramid_frame, level + 1, x_offset, y_offset);
	//	}
	//}

	static PdPair Sum4(const PdPair& a, const PdPair& b, const PdPair& c, const PdPair& d)
	{
		const uint8_t conf_threshold = 200;

		float sum_pd = 0.0f;
		int32_t sum_conf = 0;
		int32_t count = 0;
		if (a.second > conf_threshold)
		{
			count++;
			sum_pd += a.first;
			sum_conf += a.second;
		}
		if (b.second > conf_threshold)
		{
			count++;
			sum_pd += b.first;
			sum_conf += b.second;
		}

		if (c.second > conf_threshold)
		{
			count++;
			sum_pd += c.first;
			sum_conf += c.second;
		}
		if (d.second > conf_threshold)
		{
			count++;
			sum_pd += d.first;
			sum_conf += d.second;
		}

		if (count == 0)
		{
			return PdPair(0, 0);
		}
		else
		{
			float avg_pd = sum_pd / (float)count;
			int32_t avg_conf = sum_conf / count;

			uint8_t r_conf = std::min(std::max(avg_conf, 0), 255);

			return PdPair(avg_pd, r_conf);
		}

	}
};
*/
