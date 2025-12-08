#include <cstdlib>
#include <iostream>
#include <map>
#include <string>

// Function to safely execute the rsync command
int execute_rsync(const std::string &source, const std::string &destination) {
  // -a: Archive mode
  // -v: Verbose output
  // -z: Compress
  const std::string rsync_options = "-avz --filter=':- gitignore'";

  // Construct the full command: rsync [options] [source_file]
  // [destination_dir/new_filename]
  const std::string command =
      "rsync " + rsync_options + " " + source + " " + destination;

  std::cout << "Executing: " << command << std::endl;
  int result = std::system(command.c_str());

  if (result == 0) {
    std::cout << "  ✅ Success." << std::endl;
  } else {
    std::cerr << "  ❌ Failed with exit status: " << result << std::endl;
  }
  std::cout << "---" << std::endl;

  return result;
}

int main() {
  // 1. Define the final, single destination directory
  // Replace this with your actual destination path!
  const std::string final_destination_dir = "/home/munmun06/backup/";

  // 2. Define the list of source files and their new names in the destination
  // Key (string): Full path to the source file.
  // Value (string): The desired new filename in the destination directory.
  std::map<std::string, std::string> files_to_copy = {
      {"/home/munmun06/Installed.txt", "Installed.txt"},
      {"/home/munmun06/SysMainRoutine", "SysMainRoutine"},
      {"/home/munmun06/scripts/", "scripts/"},
      {"/home/munmun06/passwords.txt.gpg", "passwords.txt.gpg"},
      {"/home/munmun06/git_convention", "git_convention"},
      {"/home/munmun06/learning_vim", "learning_vim"},
      {"/home/munmun06/SaveBattery.txt", "SaveBattery.txt"},
      {"/home/munmun06/Wifi.txt", "Wifi.txt"},
      {"/home/munmun06/.config/hypr/", "hypr/"},
      {"/home/munmun06/.config/hyprlock/layout.sh", "hyprlock/layout.sh"},
      {"/home/munmun06/.config/kitty/", "kitty/"},
      {"/home/munmun06/.config/nvim/", "nvim/"},
      {"/home/munmun06/.config/waybar/", "waybar/"},
      {"/home/munmun06/.config/fastfetch/", "fastfetch/"},
      {"/etc/nftables.conf", "nftables.conf"}};

  int overall_status = 0; // Tracks if any copy failed

  // 3. Iterate through the map and execute rsync for each file
  for (const auto &pair : files_to_copy) {
    const std::string &source_file = pair.first;
    const std::string &new_filename = pair.second;

    // Combine the final destination directory with the new filename
    std::string full_destination_path = final_destination_dir + new_filename;

    // Execute the copy operation
    int result = execute_rsync(source_file, full_destination_path);

    // If any single copy fails, update the overall status
    if (result != 0) {
      overall_status = 1;
    }
  }

  if (overall_status == 0) {
    std::cout << "🎉 All files copied successfully to: "
              << final_destination_dir << std::endl;
  } else {
    std::cerr
        << "⚠️ One or more rsync operations failed. Check the errors above."
        << std::endl;
  }

  return overall_status;
}
