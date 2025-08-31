FDEVICE="genevn"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep \"$FDEVICE\")
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
  # Main
  export FOX_VANILLA_BUILD=1
  
  # GUI settings
  export OF_STATUS_INDENT_LEFT=48
  export OF_STATUS_INDENT_RIGHT=48

  if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
    export | grep "FOX" >> $FOX_BUILD_LOG_FILE
    export | grep "OF_" >> $FOX_BUILD_LOG_FILE
    export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  fi

	add_lunch_combo twrp_"$FDEVICE"-eng
	add_lunch_combo twrp_"$FDEVICE"-userdebug
fi
