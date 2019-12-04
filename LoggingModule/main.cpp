#include "module_log.h"

int main()
{
	init_log("/data/eis_log.txt");
	
	EIS_LOG("Hello world\n");
	EIS_LOG("%s %d\n", "3 + 6 = ", 3+6);
	
	deinit_log();
	
	return 0;
}
