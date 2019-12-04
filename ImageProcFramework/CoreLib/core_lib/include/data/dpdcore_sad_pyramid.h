#pragma once

#include "./common/dpd_pyramid.h"

#include "./common/dpd_sad.h"

#include "../include/common/dpd_rect.h"

#include "../../depth_map_core/src/proc/pd_proc/conf_calc.h"

class DpdCoreSadPyramid : public BasePyramid<SadSignal>
{
public:
	DpdCoreSadPyramid(const size_t in_level, const DimWH& in_dim, const SadSignal& in_init) 
		: BasePyramid<SadSignal>(in_level, in_dim, in_init)
	{
	}

	~DpdCoreSadPyramid() {}

	static SadSignal CalcSadSum(const Layer& lower_layer, const Rect& in_rect, const uint8_t threshold)
	{
		const int32_t x_start = in_rect.XStart(); 
		const int32_t x_end = in_rect.XEnd();

		const int32_t y_start = in_rect.YStart();
		const int32_t y_end = in_rect.YEnd();

		const SadSignal* first_elem = lower_layer.GetElem(x_start, y_start);

		SadSignal sum(first_elem->size());

		for (int32_t j = y_start; j < y_end; j++)
		{
			for (int32_t i = x_start; i < x_end; i++)
			{
				const SadSignal* rhs = lower_layer.GetElem(i, j);

				const uint8_t conf = rhs->Confidence();

				if(conf>=threshold)
					sum += *rhs;
			}
		}

		const int32_t dividor = in_rect.Area();

		const bool do_averaging = false;

		if( do_averaging)
			sum /= dividor;

		return sum;
	}

};

