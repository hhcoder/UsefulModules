#ifndef _DPDDM_TUNING_LIB_API_H_
#define _DPDDM_TUNING_LIB_API_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define DPDDM_TUNING_SEARCH_SUCCESS				(0x00000000)
#define DPDDM_TUNING_SEARCH_FAIL				(0x00000001)

#define DpddmTuning_IsSuccess(_x_)			((_x_)==DPDDM_TUNING_SEARCH_SUCCESS)
#define DpddmTuning_IsFail(_x_)				((_x_)!=DPDDM_TUNING_SEARCH_SUCCESS)

int32_t DpddmTuningValueInt(const char* in_key);

#ifdef __cplusplus
} //extern "C"
#endif

#endif //_DPDDM_TUNING_LIB_API_H_