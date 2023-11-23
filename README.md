# **IMPORTANT: DEPRECIATION NOTICE**

**I have written a new module [https://github.com/sean6541/op9_series_camera_unlocker](https://github.com/sean6541/op9_series_camera_unlocker) that is a huge update to this one. It is fully scripted and *should* (no guarantees) work on all versions of OOS and custom ROMS using OOS FW and continue to work with future updates. It also unlocks face detection and enables all third-party apps access to the AUX cameras. Please see the README for the new module before installing it as it contains important instructions and information.**


# OnePlus 9 Series Full Resolution Unlocker

Magisk module that unlocks full resolution (48MP main and 50MP ultrawide) RAW on the OnePlus 9 series. Only OxygenOS 13 based ROMs are supported at the moment. Will break most third party camera apps save for GCAM.


## How To Install:

1. Download latest op9_fullres_unlocker.zip from releases page: [https://github.com/sean6541/op9_fullres_unlocker/releases](https://github.com/sean6541/op9_fullres_unlocker/releases)
2. Go to Magisk Manager -> Modules and click on "Install from storage". Choose Downloads/op9_fullres_unlocker.zip
3. Reboot


## **IMPORTANT: How To Use It**

1. Install the module and reboot (see above [How To Install](#how-to-install)). Note that by default, full resolution is disabled.
2. To enable full resolution, open a terminal and run `su -c enable_fullres.sh`. Wait approximately 10 seconds before opening any camera apps.
3. To disable full resolution, open a terminal and run `su -c disable_fullres.sh`. Wait approximately 10 seconds before opening any camera apps.

Why do we have to enable and disable full resolution? Because the only way to get it working is to force the camera sensors to output the full resolution stream. This means that third party camera (and camcorder) apps are also getting the full resolution stream, which is filled with noise and artifacts that only a properly tuned GCAM can eliminate. The front camera also doesn't work and video is limited to 30fps when full resolution is enabled.


## Compatible GCAMs And XMLs

- Hasli's LMC 8.4: [https://www.celsoazevedo.com/files/android/google-camera/dev-hasli/f/dl11](https://www.celsoazevedo.com/files/android/google-camera/dev-hasli/f/dl11) with my test XML based on Arcide's LMC 8.4 v7.1: [LMC_48MP.xml](https://github.com/sean6541/op9_fullres_unlocker/releases/download/v0.1-beta/LMC_48MP.xml)


## How It Works

The Mi11U GCAM users figured out how to get full resolution RAW on their devices by adding the following props to the `/vendor/etc/camera/camxoverridesettings.txt` file:
```
overrideForceSensorMode=0
exposeFullSizeForQCFA=TRUE
useFeatureForQCFA=0
```
This hack (along with setting the SELinux context of the `camxoverridesettings.txt` file correctly) should work on most SM8350 (Snapdragon 888) based devices (and perhaps other Qualcomm chipsets).

For this hack to work, OnePlus devices also require a simple (one byte) patch to `/vendor/lib64/hw/com.qti.chi.override.so` that allows third party apps to use some system APIs and thus this module is specific to the OnePlus 9 series. ~~The module is full scripted so it *should* (no guarantees) work on all versions of OxygenOS and continue to work with future updates.~~ (Not quite finished yet.)
