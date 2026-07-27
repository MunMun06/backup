use std::fs;
use std::io;
use std::path::{Path, PathBuf};
use std::process::Command;

/// Utility function to pipe a string into `sudo tee <path>` to mimic writing with elevated permissions.
fn sudo_write<P: AsRef<Path>>(path: P, content: &str) -> io::Result<()> {
    let mut child = Command::new("sudo")
        .arg("tee")
        .arg(path.as_ref())
        .stdin(std::process::Stdio::piped())
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .spawn()?;

    if let Some(mut stdin) = child.stdin.take() {
        use std::io::Write;
        stdin.write_all(content.as_bytes())?;
    }

    let status = child.wait()?;
    if status.success() {
        Ok(())
    } else {
        Err(io::Error::new(
            io::ErrorKind::Other,
            format!("Failed to write to {:?}", path.as_ref()),
        ))
    }
}

/// Utility function to run `sudo iw ...`
fn sudo_iw(args: &[&str]) -> io::Result<()> {
    let status = Command::new("sudo")
        .arg("iw")
        .args(args)
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .status()?;

    if status.success() {
        Ok(())
    } else {
        Err(io::Error::new(
            io::ErrorKind::Other,
            "iw command failed",
        ))
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("[+] Restoring performance and disabling battery saving...");

    // 1. Restore CPU governor to performance & reset max CPU frequency
    let cpu_dir = Path::new("/sys/devices/system/cpu");
    if cpu_dir.exists() {
        for entry in fs::read_dir(cpu_dir)? {
            let entry = entry?;
            let name = entry.file_name();
            let name_str = name.to_string_lossy();

            if name_str.starts_with("cpu") && name_str[3..].chars().all(|c| c.is_ascii_digit()) {
                let cpufreq = entry.path().join("cpufreq");

                // Read the absolute maximum hardware frequency for this CPU core
                let hardware_max_freq_path = cpufreq.join("cpuinfo_max_freq");
                if hardware_max_freq_path.exists() {
                    let max_freq = fs::read_to_string(&hardware_max_freq_path)?;
                    let max_freq_path = cpufreq.join("scaling_max_freq");

                    // Set scaling max frequency back to 100% hardware capability
                    if max_freq_path.exists() {
                        let _ = sudo_write(&max_freq_path, max_freq.trim());
                    }
                }

                // Restore CPU Governor to performance (or schedutil/ondemand depending on driver)
                let governor_path = cpufreq.join("scaling_governor");
                if governor_path.exists() {
                    let _ = sudo_write(&governor_path, "performance");
                }
            }
        }
    }

    // 2. Disable Wi-Fi power save
    let _ = sudo_iw(&["dev", "wlp1s0", "set", "power_save", "off"]);

    // 3. Restore PCIe ASPM policy to performance or default
    let aspm_path = Path::new("/sys/module/pcie_aspm/parameters/policy");
    if aspm_path.exists() {
        let _ = sudo_write(aspm_path, "default"); // Can be changed to "performance"
    }

    // 4. Disable USB autosuspend
    let usb_dir = Path::new("/sys/bus/usb/devices");
    if usb_dir.exists() {
        for entry in fs::read_dir(usb_dir)? {
            let entry = entry?;
            let control_path = entry.path().join("power/control");
            if control_path.exists() {
                let _ = sudo_write(&control_path, "on"); // "on" means autosuspend is OFF
            }
        }
    }

    // 5. Restore display brightness (100%)
    let backlight_dir = Path::new("/sys/class/backlight");
    if backlight_dir.exists() {
        let mut first_backlight: Option<PathBuf> = None;
        for entry in fs::read_dir(backlight_dir)? {
            let path = entry?.path();
            if path.is_dir() {
                first_backlight = Some(path);
                break;
            }
        }

        if let Some(backlight) = first_backlight {
            let max_brightness_path = backlight.join("max_brightness");
            if max_brightness_path.exists() {
                let max_b = fs::read_to_string(&max_brightness_path)?;
                let brightness_path = backlight.join("brightness");
                let _ = sudo_write(&brightness_path, max_b.trim());
            }
        }
    }

    println!("[+] Battery saving mode disabled.");
    Ok(())
}
