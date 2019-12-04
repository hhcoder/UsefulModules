#include "./cmdline_profiler.h"

#include <stdio.h>
#include <stdlib.h>

#ifdef _ANDROID_

Profiler* ProfilerCreate(const int loop_count)
{
	Profiler* p = (Profiler*)malloc(sizeof(Profiler));
	p->curr_count = 0;
	p->max_count = loop_count;
	p->profiling_time = (int*)malloc(sizeof(int)*p->max_count);
	memset(p->profiling_time, 0x00, sizeof(int)*p->max_count);

	return p;
}

void ProfilerDestroy(Profiler* p)
{
	if (NULL != p->profiling_time)
		free(p->profiling_time);
	if (NULL != p)
		free(p);
}

void ProfilerStartSession(Profiler* prof)
{
	gettimeofday(&prof->start, NULL);
}

static int GetMs(struct timeval* start, struct timeval* end)
{
	long seconds = end->tv_sec - start->tv_sec;
	long useconds = end->tv_usec - start->tv_usec;

	long mtime = ((seconds) * 1000 + useconds / 1000.0) + 0.5;

	return (int)mtime;
}

void ProfilerEndSession(Profiler* p)
{
	gettimeofday(&p->end, NULL);

	int ms = GetMs(&p->start, &p->end);

	p->profiling_time[p->curr_count] = ms;
	p->curr_count++;
}

float ProfilerGetAverageTime(Profiler* p)
{
	printf("ProfilerGetAverageTime\n");
	int sum = 0;
	for (int i = 0; i < p->curr_count; i++)
	{
		int t = (int)p->profiling_time[i];
		sum += t;
		printf("%d\n", t);
	}

	return (float)sum / (float)p->curr_count;
}

#else

Profiler* ProfilerCreate(const int loop_count) { return NULL; }
void ProfilerDestroy(Profiler* p) { }
void ProfilerStartSession(Profiler* prof) { }
void ProfilerEndSession(Profiler* p) { }
float ProfilerGetAverageTime(Profiler* p) { return 0.0f; }

#endif