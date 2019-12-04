#pragma once

#include <algorithm>
#include <numeric>

#include "../common/dpd_signal_array.h"

#include <fstream>
#include <string>

#include "../../../dual_pd_dump_info/public/dpdcore_dump_info.h"

class SadSignal : public SignalArray<uint32_t>
{
public:
	SadSignal(const size_t in_len)
		: SignalArray<uint32_t>(in_len)
	{
		Clear();
	}

	SadSignal(const char* in_fname)
		: SignalArray<uint32_t>((size_t)0)
	{
		std::string str;
		std::ifstream file(in_fname);

		while (std::getline(file, str))
		{
			push_back(std::stoi(str));
		}
	}

	SadSignal(const SadSignal& rhs)
		: SignalArray<uint32_t>(rhs.size())
	{
		const_iterator r = rhs.begin();
		iterator i = begin();
		for (; i != end(); i++, r++)
			*i = *r;
	}

public:
	friend SadSignal operator+(const SadSignal& lhs, const SadSignal& rhs)
	{
		SadSignal dst(rhs.size());

		SadSignal::const_iterator i = lhs.begin();
		SadSignal::const_iterator j = rhs.begin();
		SadSignal::iterator d = dst.begin();
		for (;
			i != lhs.end();
			i++, j++, d++)
		{
			*d = *i + *j;
		}

		return dst;
	}

	SadSignal& operator=(const SadSignal& rhs)
	{
		const_iterator r = rhs.begin();
		iterator i = begin();
		for (; i != end(); i++, r++)
			*i = *r;

		return *this;
	}

	SadSignal& operator+=(const SadSignal& rhs)
	{
		const_iterator r = rhs.begin();
		iterator i = begin();
		for (; i != end(); i++, r++)
		{
			*i += *r;
		}

		return *this;
	}

	SadSignal& operator/=(const int32_t rhs)
	{
		for (iterator i = begin(); i != end(); i++)
		{
			*i = *i / rhs;
		}

		return *this;
	}

	friend SadSignal operator/(const SadSignal& lhs, const int32_t& rhs)
	{
		SadSignal dst(lhs.size());

		SadSignal::const_iterator i = lhs.begin();
		SadSignal::iterator d = dst.begin();

		for (; i != lhs.end(); i++, d++)
			*d = *i / rhs;

		return dst;
	}

	friend SadSignal operator*(const SadSignal& lhs, const int32_t& rhs)
	{
		SadSignal dst(lhs.size());

		SadSignal::const_iterator i = lhs.begin();
		SadSignal::iterator d = dst.begin();

		for (; i != lhs.end(); i++, d++)
			*d = *i * rhs;

		return dst;
	}

	friend SadSignal operator*(const SadSignal& lhs, const float& rhs)
	{
		SadSignal dst(lhs.size());

		SadSignal::const_iterator i = lhs.begin();
		SadSignal::iterator d = dst.begin();

		for (; i != lhs.end(); i++, d++)
		{
			float v = static_cast<float>(*i);
			float t = v * rhs;
			uint32_t r = static_cast<uint32_t>(std::roundf(t));

			*d = r;
		}

		return dst;
	}

	friend SadSignal operator>>(const SadSignal& lhs, const uint32_t& rhs)
	{
		SadSignal dst(lhs.size());

		SadSignal::const_iterator i = lhs.begin();
		SadSignal::iterator d = dst.begin();

		for (; i != lhs.end(); i++, d++)
			*d = *i >> rhs;

		return dst;
	}

	int32_t MinIdx() const
	{
		const_iterator begin_i = begin();
		const_iterator end_i = end();
		const_iterator last_i = end_i - 1;

		//TODO: develop a Newton based search algorithm when size is big 
		const_iterator min_i = std::min_element(begin_i, end_i);

		const int32_t min_idx = (int32_t)std::distance(begin_i, min_i);

		return min_idx;
	}

	uint32_t MinVal() const
	{
		return at(MinIdx());
	}

	int32_t Integral() const
	{
		return std::accumulate(begin(), end(), 0);
	}

	uint8_t Confidence() const
	{
		const float integral = static_cast<float>(Integral());

		if (integral == 0)
			return 0;

		//TODO: optimize this
		const float min_val = static_cast<float>(MinVal());
		const float min_area = static_cast<float>(size() * min_val);

		const float ratio = 255.0f * min_area / integral;

		const int32_t v = 255 - static_cast<int32_t>(std::floor(ratio));

		const uint8_t r = std::min(255, std::max(0, v));

		return r;
	}

	void DumpInfo(const std::string& var_name) const
	{
		DpdInfoDump info_dump(var_name);

		for (const_iterator i = begin(); i != end(); i++)
		{
			info_dump << *i << ",";
		}
	}
};