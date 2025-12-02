#!/bin/zsh
# battery-normal.sh — restore normal performance

echo "[+] Restoring normal performance..."

## CPU governor → schedutil (default on Arch)
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo schedutil | sudo tee $cpu >/dev/null
done

## Restore max CPU frequency
max_freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq; do
  echo $max_freq | sudo tee $cpu >/dev/null
done

## Disable Wi‑Fi power save
sudo iw dev wlp1s0 set power_save off 2>/dev/null

## PCIe ASPM → default
echo default | sudo tee /sys/module/pcie_aspm/parameters/policy >/dev/null

## USB full power
echo on | sudo tee /sys/bus/usb/devices/*/power/control >/dev/null

## Restore full brightness
brightness_path=$(find /sys/class/backlight -type d | head -n 1)
max_brightness=$(cat "$brightness_path/max_brightness")
echo $max_brightness | sudo tee "$brightness_path/brightness" >/dev/null

echo "[+] Normal mode restored."
