MODDIR="${0%/*}"
TMPDIR="$MODDIR/overridden_at_boot_DO_NOT_EDIT"

reset_camx_setting() {
  if grep -q -E -i "^[[:blank:]]*$1[[:blank:]]*=" "$TMPDIR/fullres_enabled.txt"; then
    sed -i -r "s/^[[:blank:]]*$1[[:blank:]]*=.*/$1=$2/gI" "$TMPDIR/fullres_enabled.txt" || return 1
  else
    echo "\n$1=$2\n" >> "$TMPDIR/fullres_enabled.txt" || return 1
  fi
}

sed -i -r "/^TMPDIR=.*/TMPDIR=\"$TMPDIR\"/g" "$MODDIR/system/bin/disable_fullres.sh" || exit 1
sed -i -r "/^TMPDIR=.*/TMPDIR=\"$TMPDIR\"/g" "$MODDIR/system/bin/enable_fullres.sh" || exit 1
if [[ -d "$TMPDIR" ]]; then rm -r "$TMPDIR"; fi
mkdir "$TMPDIR" || exit 1
if [[ -f "/vendor/etc/camera/camxoverridesettings.txt" ]]; then
  cp /vendor/etc/camera/camxoverridesettings.txt "$TMPDIR/fullres_disabled.txt" || exit 1
  cp "$TMPDIR/fullres_disabled.txt" "$TMPDIR/fullres_enabled.txt" || exit 1
  reset_camx_setting "overrideForceSensorMode" "0" || exit 1
  reset_camx_setting "exposeFullSizeForQCFA" "TRUE" || exit 1
  reset_camx_setting "useFeatureForQCFA" "0" || exit 1
else
  echo "" > "$TMPDIR/fullres_disabled.txt" || exit 1
  echo "overrideForceSensorMode=0\nexposeFullSizeForQCFA=TRUE\nuseFeatureForQCFA=0\n" > "$TMPDIR/fullres_enabled.txt" || exit 1
fi
cp "$TMPDIR/fullres_disabled.txt" "$MODDIR/system/vendor/etc/camera/camxoverridesettings.txt" || exit 1
