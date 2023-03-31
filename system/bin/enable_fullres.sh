#!/system/bin/sh

TMPDIR=

stop media || exit 1
cp "$TMPDIR/fullres_enabled.txt" /vendor/etc/camera/camxoverridesettings.txt
sleep 1
start media
sleep 1
killall -1 android.hardware.camera.provider@2.4-service_64
pm trim-caches 9999999999999
