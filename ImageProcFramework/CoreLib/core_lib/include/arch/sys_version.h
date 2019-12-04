#pragma once

#include <stdint.h>

class SystemVersionInfo
{
public:
	static void Get(int32_t* main, int32_t* major, int32_t* minor)
	{
		if (NULL == main || NULL == major || NULL == minor)
		{
			return;
		}

		*main = 1;
		*major = 0;
		*minor = 1;
	}
};
