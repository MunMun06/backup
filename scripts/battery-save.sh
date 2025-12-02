#!/bin/zsh
# battery-save.sh — enable extreme battery saving

echo "[+] Enabling extreme battery saving..."

## CPU governor → powersave
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo powersave | sudo tee $cpu >/dev/null
done

## Limit max CPU frequency (adjust as needed)
max_freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
low_freq=$((max_freq / 2)) # 50% of max
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq; do
  echo $low_freq | sudo tee $cpu >/dev/null
done

## Wi‑Fi power save
sudo iw dev wlp1s0 set power_save on 2>/dev/null

## PCIe ASPM
echo powersave | sudo tee /sys/module/pcie_aspm/parameters/policy >/dev/null

## USB autosuspend
 echo on | sudo tee /sys/bus/usb/devices/*/power/control >/dev/null

## Reduce display brightness (set to ~50%)
brightness_path=$(find /sys/class/backlight -type d | head -n 1)
max_brightness=$(cat "$brightness_path/max_brightness")
target_brightness=$((max_brightness / 2))
echo $target_brightness | sudo tee "$brightness_path/brightness" >/dev/null

echo "[+] Battery saving mode enabled."
