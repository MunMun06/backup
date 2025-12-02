#!/bin/zsh

# File paths
plaintext="passwords.txt"
encrypted="passwords.txt.gpg"

# Colors for messages
green=$'%{\e[32m%}'
red=$'%{\e[31m%}'
reset=$'%{\e[0m%}'

# Check for gpg and vim
if ! command -v gpg >/dev/null || ! command -v nvim >/dev/null; then
  echo "${red}Error:${reset} gpg and/or neovim are not installed."
  exit 1
fi

# Decrypt the file
echo "${green}Decrypting...${reset}"
if ! gpg -d "$encrypted" > "$plaintext" 2>/dev/null; then
  echo "${red}Failed to decrypt.${reset}"
  exit 1
fi

# Open in Vim
echo "${green}Opening in Vim...${reset}"
nvim "$plaintext"

# Re-encrypt
echo "${green}Re-encrypting...${reset}"
if gpg -c "$plaintext"; then
  echo "${green}Securely deleting plaintext...${reset}"
  shred -u "$plaintext"
  echo "${green}Done.${reset}"
else
  echo "${red}Encryption failed. Plaintext not deleted.${reset}"
fi

