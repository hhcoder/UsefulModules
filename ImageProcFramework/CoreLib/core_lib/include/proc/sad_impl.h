#pragma once

#include <stdint.h>

#ifdef _ANDROID_
#include <arm_neon.h>
#endif

class SadImpl
{
public:
	//TODO: refactor CalcSAD function, it can be simpler
	static uint32_t Calc(const uint16_t* p_a, const uint16_t* p_b, const int32_t proc_range)
	{
		const uint32_t proc_range_remain = proc_range % 16;

		uint32_t sum = 0;

#ifdef _ANDROID_
		if (android_getCpuFamily() == ANDROID_CPU_FAMILY_ARM &&
			(android_getCpuFeatures() & ANDROID_CPU_ARM_FEATURE_NEON) != 0)
		{
			for (uint32_t i = 0; i < proc_range - proc_range_remain; i += 16)
			{
				sum += SAD8_Neon(p_a, p_b);
				p_a += 8;
				p_b += 8;

				sum += SAD8_Neon(p_a, p_b);
				p_a += 8;
				p_b += 8;
			}
		}
		else
		{
#else
		for (uint32_t i = 0; i < proc_range - proc_range_remain; i += 16)
		{
			sum += SAD8_C(p_a, p_b);
			p_a += 8;
			p_b += 8;

			sum += SAD8_C(p_a, p_b);
			p_a += 8;
			p_b += 8;
		}
#endif

		if (proc_range_remain != 0)
		{
			for (int32_t i = proc_range - proc_range_remain; i < proc_range; i++)
			{
				int32_t tmp = *(p_a + i) - *(p_b + i);
				sum += tmp > 0 ? tmp : -tmp;
			}
		}

		return sum;
	}

private:
	static int32_t SAD8_C(const uint16_t* a, const uint16_t* b)
	{
		int32_t sum = 0;
		int32_t diff = 0;

		diff = a[0] - b[0];   sum += diff > 0 ? diff : -diff;
		diff = a[1] - b[1];   sum += diff > 0 ? diff : -diff;
		diff = a[2] - b[2];   sum += diff > 0 ? diff : -diff;
		diff = a[3] - b[3];   sum += diff > 0 ? diff : -diff;
		diff = a[4] - b[4];   sum += diff > 0 ? diff : -diff;
		diff = a[5] - b[5];   sum += diff > 0 ? diff : -diff;
		diff = a[6] - b[6];   sum += diff > 0 ? diff : -diff;
		diff = a[7] - b[7];   sum += diff > 0 ? diff : -diff;

		return sum;
	}

	static int32_t SAD8_Neon(const uint16_t* a, const uint16_t* b)
	{
#ifdef _ANDROID_
		uint16x8_t a16, b16;
		uint32x4_t a32;
		uint32x2_t b32;

		a16 = vld1q_u16(a);
		b16 = vld1q_u16(b);
		a16 = vabdq_u16(a16, b16);

		a32 = vpaddlq_u16(a16);
		b32 = vpadd_u32(vget_low_u32(a32), vget_high_u32(a32));
		b32 = vpadd_u32(b32, b32);

		return (int32_t)vget_lane_u32(b32, 0);
#else
		return SAD8_C(a, b);
#endif
	}


};