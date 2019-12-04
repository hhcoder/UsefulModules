adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
del libmmcamera_pdaf.so
del mmcamera-dpd-test
copy ..\..\Development\CmdLineTest\libs\armeabi-v7a\libmmcamera_pdaf.so .\ 
copy ..\..\Development\CmdLineTest\libs\armeabi-v7a\mmcamera-dpd-test .\ 
adb shell rm /data/mmcamera-dpd-test
adb shell rm /data/dpd_calib.bin
adb shell rm /data/dpd_input.raw
adb push libmmcamera_pdaf.so /system/vendor/lib
adb push mmcamera-dpd-test /data/
adb shell chmod 777 /data/mmcamera-dpd-test
adb push input\dpd_calib.bin /data/
adb push input\dpd_config.txt /data/
adb push input\dpd_input.raw /data/
adb shell /data/mmcamera-dpd-test /data/dpd_config.txt 
pause