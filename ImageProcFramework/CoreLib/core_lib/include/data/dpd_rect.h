#pragma once

#include <stdint.h>
#include <stdio.h>

class Rect
{
public:
	Rect(
		const int32_t in_x_s,
		const int32_t in_x_e,
		const int32_t in_y_s,
		const int32_t in_y_e)
		: x_start(in_x_s), x_end(in_x_e), y_start(in_y_s), y_end(in_y_e)
	{}

	Rect()
		: x_start(0), x_end(0), y_start(0), y_end(0)
	{}

	void WriteTxt(FILE* fp, const char* prefix) const
	{
		fprintf(fp, "%s%s %d\n", prefix, "_start_x", x_start);
		fprintf(fp, "%s%s %d\n", prefix, "_end_x", x_end);
		fprintf(fp, "%s%s %d\n", prefix, "_start_y", y_start);
		fprintf(fp, "%s%s %d\n", prefix, "_end_y", y_end);
	}

	int32_t Width() const { return x_end - x_start; }
	int32_t Height() const { return y_end - y_start; }
	int32_t XStart() const { return x_start; }
	int32_t YStart() const { return y_start; }
	int32_t XEnd() const { return x_end; }
	int32_t YEnd() const { return y_end; }
	int32_t Area() const { return Width() * Height(); }

private:
	int32_t x_start;
	int32_t x_end;
	int32_t y_start;
	int32_t y_end;
};
