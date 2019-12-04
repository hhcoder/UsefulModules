# ========================================================================
#                       Logging Unit Test
# ========================================================================
LOCAL_PATH:= $(call my-dir)
LOCAL_DIR_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE            := hh-logging-test
LOCAL_CFLAGS            := -D_ANDROID_ -Werror -g -Os -Wall -Wextra -Bsymbolic -fPIE #-DINTRINSICS

LOCAL_PRELINK_MODULE    := true
LOCAL_SHARED_LIBRARIES  := libcutils libutils
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_OWNER 		:= hh
APP_PIE := true
LOCAL_SRC_FILES := ./module_log.cpp
LOCAL_SRC_FILES += ./main.cpp
LOCAL_CFLAGS += -fPIE 
LOCAL_LDFLAGS += -fPIE -pie
include $(BUILD_EXECUTABLE)
