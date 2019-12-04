#pragma once

#include <vector>
#include <stdio.h>
#include <algorithm>

template <typename T>
class SignalArray : public std::vector<T>
{
public:
	SignalArray(const size_t in_size)
		: std::vector<T>(in_size)
	{
	}

	SignalArray(T* st, T* ed)
		: std::vector<T>(st, ed)
	{
	}

	SignalArray(const char* in_fname)
	{
		std::string str;
		std::ifstream file(in_fname);

		while (std::getline(file, str))
		{
			push_back(std::stoi(str));
		}
	}

public:
	void WriteTxt(FILE* fp)
	{
		for (iterator i = begin(); i != end(); i++)
			fprintf(fp, "%d\n", *i);
	}

	void WriteTxt(const char* ofname)
	{
		FILE* fp = fopen(ofname);
		if (NULL == fp)
			return;
		for (iterator i = begin(); i != end(); i++)
			fprintf(fp, "%d\n", *i);
		fclose(fp);
	}

	void Clear()
	{
		memset(Data(), 0x00, size() * sizeof(T));
	}

	T Max() const { return std::max_element(begin(), end()); }

	// TODO: Check if Android supports native data(), which is new in C++11
	const T* Data() const { return &(operator[](0)); }
	T* Data() { return &(operator[](0)); }
};
