#include "module_log.h"
#include <stdio.h>
#include <stdlib.h>

static FILE* fp = NULL;

int init_log(const char* out_fname)
{
	fp = fopen(out_fname, "wt");
	if(NULL==fp)
	{
		printf("Error in opening %s", out_fname);
		return LOG_FILE_OPEN_ERROR;
	}
	return LOG_SUCCESS;
}

void log_to_file(const char* format, ...)
{
    va_list args;
    va_start(args, format);
    vfprintf(fp, format, args);
    va_end(args);
}

void deinit_log()
{
	if(NULL!=fp)
		fclose(fp);
	fp = NULL;
}
