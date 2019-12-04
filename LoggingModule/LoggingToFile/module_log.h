#ifndef _MODULE_LOG_H_
#define _MODULE_LOG_H_

#ifdef __cplusplus
extern "C" {
#endif

int init_log(const char* out_fname);

void log_to_file(const char* format, ...);

void deinit_log();

#define EIS_LOG   log_to_file

#define LOG_SUCCESS				(0x0000)
#define LOG_FILE_OPEN_ERROR		(0x0001)

#ifdef __cplusplus
}
#endif

#endif //_MODULE_LOG_H_