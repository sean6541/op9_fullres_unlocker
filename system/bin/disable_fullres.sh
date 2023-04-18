#!/system/bin/sh

MODDIR=

stop media || exit 1
cp "$MODDIR/overridden_at_boot_DO_NOT_EDIT/fullres_disabled.txt" "$MODDIR/system/vendor/etc/camera/camxoverridesettings.txt"
sleep 1
start media
sleep 1
killall -1 android.hardware.camera.provider@2.4-service_64
pm trim-caches 9999999999999
