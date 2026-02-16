#!/bin/zsh

# -e: exit on error, -u: error on unset variables, -o pipefail: catch pipeline errors
set -euo pipefail 

plaintext="passwords.txt"
encrypted="passwords.txt.gpg"

# Clean ANSI colors (work in both zsh and bash)
green='\033[0;32m'
red='\033[0;31m'
reset='\033[0m'

# Check for dependencies
for cmd in gpg nvim; do
    if ! command -v "$cmd" >/dev/null; then
        echo "${red}Error:${reset} $cmd is not installed."
        exit 1
    fi
done

# Decrypt
if [[ -f "$encrypted" ]]; then
    echo -e "${green}Decrypting...${reset}"
    # Added --quiet to keep the UI clean
    if ! gpg --quiet --batch --yes -d "$encrypted" > "$plaintext"; then
        echo -e "${red}Failed to decrypt.${reset}"
        exit 1
    fi
else
    echo -e "${red}Error:${reset} $encrypted not found."
    exit 1
fi

# Open in nvim
nvim "$plaintext"

# Re-encrypt
echo -e "${green}Re-encrypting...${reset}"
# --yes overwrites the old encrypted file without asking
if gpg --yes -c "$plaintext"; then
    echo -e "${green}Securely deleting plaintext...${reset}"
    
    # Cross-platform shred/delete
    if command -v shred >/dev/null; then
        shred -u "$plaintext"
    else
        rm -P "$plaintext" || rm "$plaintext"
    fi
    
    echo -e "${green}Done.${reset}"
else
    echo -e "${red}Encryption failed. Plaintext NOT deleted.${reset}"
    exit 1
fi
