#pragma once

#include "../../data/integrated_frame/integrated_frame.h"
#include "../../data/dpd_raw/dpd_raw.h"

class ColumnIntegrateImpl
{
public:
	static void LineProcFrom10BppUnPackedToVertBinN(
		const uint16_t* src_l,
		const uint16_t* src_r,
		const size_t proc_length,
		const size_t stride,
		const size_t next_offset,
		const int32_t binning_len,
		uint16_t* dst_l,
		uint16_t* dst_r)
	{
		uint16_t* proc_l = dst_l;
		uint16_t* proc_r = dst_r;

		size_t lr_proc_length = proc_length / 2;
		for (size_t i = 0; i < lr_proc_length; i++)
		{
			uint16_t sum_l = 0;
			uint16_t sum_r = 0;

			const uint16_t* l = src_l + i*next_offset;
			const uint16_t* r = src_r + i*next_offset;

			for (int32_t j = 0; j < binning_len; j++)
			{
				sum_l += (*l);
				l += stride;

				sum_r += (*r);
				r += stride;
			}

			*proc_l = sum_l / binning_len;

			*proc_r = sum_r / binning_len;

			proc_l++;
			proc_r++;
		}
	}

	static void LineProcFrom10BppUnPackedToVertBin8(
		const uint16_t* src_l,
		const uint16_t* src_r,
		const size_t proc_length,
		const size_t stride,
		const size_t next_offset,
		uint16_t* dst_l,
		uint16_t* dst_r)
	{
		const uint16_t* l0 = src_l;
		const uint16_t* l1 = l0 + stride;
		const uint16_t* l2 = l1 + stride;
		const uint16_t* l3 = l2 + stride;
		const uint16_t* l4 = l3 + stride;
		const uint16_t* l5 = l4 + stride;
		const uint16_t* l6 = l5 + stride;
		const uint16_t* l7 = l6 + stride;

		const uint16_t* r0 = src_r;
		const uint16_t* r1 = r0 + stride;
		const uint16_t* r2 = r1 + stride;
		const uint16_t* r3 = r2 + stride;
		const uint16_t* r4 = r3 + stride;
		const uint16_t* r5 = r4 + stride;
		const uint16_t* r6 = r5 + stride;
		const uint16_t* r7 = r6 + stride;

		uint16_t* proc_l = dst_l;
		uint16_t* proc_r = dst_r;

		uint16_t sum_l;
		uint16_t sum_r;

		size_t lr_proc_length = proc_length / 2;

		for (size_t i = 0; i < lr_proc_length; i++)
		{
			sum_l = (*l0+*l1+*l2+*l3+*l4+*l5+*l6+*l7);
			*proc_l = sum_l >> 3;

			sum_r = (*r0+*r1+*r2+*r3+*r4+*r5+*r6+*r7);
			*proc_r = sum_r >> 3;

			l0 += next_offset;
			l1 += next_offset;
			l2 += next_offset;
			l3 += next_offset;
			l4 += next_offset;
			l5 += next_offset;
			l6 += next_offset;
			l7 += next_offset;

			r0 += next_offset;
			r1 += next_offset;
			r2 += next_offset;
			r3 += next_offset;
			r4 += next_offset;
			r5 += next_offset;
			r6 += next_offset;
			r7 += next_offset;

			proc_l++;
			proc_r++;
		}

	}
};

class ColumnIntegrate
{
public:
	static uint32_t Proc(const DpdRaw<uint16_t>& in_raw, IntegratedFrame<uint16_t>& in_frame, const int32_t integ_length)
	{
		Proc(
			in_raw.LPtr(), 
			in_raw.RPtr(), 
			in_raw.Width(), 
			in_raw.Height(), 
			in_raw.Stride(), 
			in_raw.NextPixelOffset(),
			integ_length,
			in_frame.left_buf.GetBuf(), 
			in_frame.right_buf.GetBuf(),
			in_frame.left_buf.Width(),
			in_frame.left_buf.Height());
		return DPDDM_RESULT_SUCCESS;
	}

private:
	static void Proc(
		const uint16_t* src_l,
		const uint16_t* src_r,
		const int32_t src_width,
		const int32_t src_height,
		const int32_t src_stride,
		const int32_t src_next_offset,
		const int32_t target_binning_len,
		uint16_t* dst_l,
		uint16_t* dst_r,
		const int32_t dst_width,
		const int32_t dst_height)
	{
		int32_t proc_rows = (int32_t)floor((float)src_height/target_binning_len);

		for (int32_t j = 0; j < proc_rows; j++)
		{
			const size_t src_offset = j*target_binning_len*src_stride;

			const uint16_t* proc_src_l = src_l + src_offset;
			const uint16_t* proc_src_r = src_r + src_offset;

			const size_t dst_offset = j*dst_width;

			uint16_t* proc_dst_l = dst_l + dst_offset;
			uint16_t* proc_dst_r = dst_r + dst_offset;

			if (target_binning_len == 8)
			{
				ColumnIntegrateImpl::LineProcFrom10BppUnPackedToVertBin8(
					proc_src_l, proc_src_r, src_width, src_stride, src_next_offset, 
					proc_dst_l, proc_dst_r);
			}
			else
			{
				ColumnIntegrateImpl::LineProcFrom10BppUnPackedToVertBinN(
					proc_src_l, proc_src_r, src_width, src_stride, src_next_offset, 
					target_binning_len, 
					proc_dst_l, proc_dst_r);
			}
		}

		int32_t remain_rows = src_height%target_binning_len;
		if(0 != remain_rows)
		{
			const size_t src_offset = (src_height - remain_rows)*src_stride;

			const uint16_t* proc_src_l = src_l + src_offset;
			const uint16_t* proc_src_r = src_r + src_offset;

			const size_t dst_offset = (dst_height - 1)*dst_width;

			uint16_t* proc_dst_l = dst_l + dst_offset;
			uint16_t* proc_dst_r = dst_r + dst_offset;

			ColumnIntegrateImpl::LineProcFrom10BppUnPackedToVertBinN(
				proc_src_l, proc_src_r, src_width, src_stride, src_next_offset, 
				remain_rows, 
				proc_dst_l, proc_dst_r);
		}
	}
};