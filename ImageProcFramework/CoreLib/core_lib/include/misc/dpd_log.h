#pragma once

#if defined(_ANDROID_)

#include <android/log.h>

#ifndef LOG_TAG
#define LOG_TAG    "DPD"
#endif
#define  DPDDM_LOG_ENABLE  (1)

#define PDAF_LOGE(...) \
    do { if (DPD_LOG_ENABLE) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__); } while (0)
#define PDAF_LOGI(...) \
    do { if (DPD_LOG_ENABLE) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__); } while (0)
#define PDAF_LOGH(...) \
    do { if (DPD_LOG_ENABLE) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__); } while (0)

#else

#include <stdio.h>
#include <stdlib.h>

#define DPD_LOGH  printf
#define DPD_LOGI  printf
#define DPD_LOGE  printf

#endif

#define XStr(_v_) (#_v_)
#define GetMember(_p_, _member_)  _p_->_member_
#define LogIntPtrMember(_p_, _member_)		DPD_LOGH("%s: %d\n", XStr(_member_), GetMember(_p_,_member_));
#define LogFloatPtrMember(_p_, _member_)	DPD_LOGH("%s: %f\n", XStr(_member_), GetMember(_p_,_member_));
#define LogAddrPtrMember(_p_, _member_)		DPD_LOGH("%s: %p\n", XStr(_member_), GetMember(_p_,_member_));

#define LOG_FUNCTION_NAME					DPD_LOGH("%s", __FUNCTION__);
