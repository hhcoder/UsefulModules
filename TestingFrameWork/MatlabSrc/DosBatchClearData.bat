adb wait-for-devices
adb root
adb wait-for-devices
adb remount
adb wait-for-devices
adb shell rm -rf /data/dpd/
adb shell mkdir /data/dpd/