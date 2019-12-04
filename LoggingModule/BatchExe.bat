adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb push libs\armeabi-v7a\hh-logging-test /data/
adb shell chmod 777 /data/hh-logging-test
adb shell /data/hh-logging-test
adb shell cat /data/eis_log.txt