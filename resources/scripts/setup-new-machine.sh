#!/usr/bin/env bash

ssh_key_path="/var/lib/sops-nix"
ssh_key_name="nixos-config-key"
ssh_key=$ssh_key_path/$ssh_key_name

# Check if the SSH key file exists
if [[ ! -f "$ssh_key" ]]; then
  echo "SSH key file '$ssh_key' does not exist."
      echo "Exiting script."
      exit 1
fi

# Create a temporary directory
temp=$(mktemp -d)

# Function to cleanup temporary directory on exit
cleanup() {
  rm -rf "$temp"
}
trap cleanup EXIT

# Create the directory where sshd expects to find the host keys
install -d -m755 "$temp$ssh_key_path"

# Copy the SSH key to the temporary directory
cp "$ssh_key" "$temp$ssh_key"

# Set the correct permissions so sshd will accept the key
chmod 600 "$temp$ssh_key"

read -rp "Target IP: " target_ip
read -rp "Nix config hostname (--flake '.#<hostname>'): " hostname

cd ../../
nixos-anywhere --extra-files "$temp" --flake ".#${hostname}" root@"${target_ip}"

