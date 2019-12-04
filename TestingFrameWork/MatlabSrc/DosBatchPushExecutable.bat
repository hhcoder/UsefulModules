adb wait-for-devices
adb root
adb wait-for-devices
adb remount
adb wait-for-devices
REM adb push ../../Development/CmdLineTest/libs/arm64-v8a/libmmcamera_pdaf.so /system/vendor/lib64/
REM adb push ../../Development/CmdLineTest/libs/arm64-v8a/mmcamera-dpd-test /data/
adb push ../../Development/CmdLineTest/libs/armeabi-v7a/libmmcamera_pdaf.so /system/vendor/lib/
adb push ../../Development/CmdLineTest/libs/armeabi-v7a/mmcamera-dpd-test /data/
adb shell chmod 777 /data/mmcamera-dpd-test 