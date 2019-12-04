#ifndef _HELLO_TUNING_LIB_API_H_
#define _HELLO_TUNING_LIB_API_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define HELLO_TUNING_SEARCH_SUCCESS				(0x00000000)
#define HELLO_TUNING_SEARCH_FAIL				(0x00000001)

#define HELLOTuning_IsSuccess(_x_)			((_x_)==HELLO_TUNING_SEARCH_SUCCESS)
#define HELLOTuning_IsFail(_x_)				((_x_)!=HELLO_TUNING_SEARCH_SUCCESS)

int32_t HELLOTuningValueInt(const char* in_key);

#ifdef __cplusplus
} //extern "C"
#endif

#endif //_HELLO_TUNING_LIB_API_H_
