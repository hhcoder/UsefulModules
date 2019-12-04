#ifndef _CMDLINE_PROFILER_H_
#define _CMDLINE_PROFILER_H_

#ifdef _ANDROID_

#include <sys/time.h>
typedef struct Profiler
{
	struct timeval start;
	struct timeval end;
	int curr_count;
	int max_count;
	int* profiling_time;
} Profiler;
#else
typedef struct Profiler
{
	int dummy;
} Profiler;
#endif

Profiler* ProfilerCreate(const int loop_count);

void ProfilerDestroy(Profiler* p);

void ProfilerStartSession(Profiler* prof);

void ProfilerEndSession(Profiler* p);

float ProfilerGetAverageTime(Profiler* p);

#endif //_CMDLINE_PROFILER_H_