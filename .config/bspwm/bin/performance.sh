#!/bin/bash
# cpu governor toggle
if grep -q "powersave" "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor";
then
  echo "performance" | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor &&
  notify-send "performance"
else
  echo "powersave" | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor && 
  notify-send "powersave"
fi
