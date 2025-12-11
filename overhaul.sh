#!/usr/bin/env bash
set -euo pipefail

# Always work relative to where the script lives (the game root)
game_root="$(cd "$(dirname "$0")" && pwd)"
cd "$game_root"

echo "ACM Overhaul V6 Mod Enabler (Linux/Proton)"
echo "-----------------------------------------"
echo "This script adjusts game files to allow modded file usage."
echo "It also installs the never-ending reboot fix by Kasugano."
echo
echo "Version 6 should NOT be installed over an earlier version of ACM Overhaul."
echo "Use Steam 'Verify integrity of game files' to revert your installation to default."
echo
echo "Press Ctrl+C now to cancel."
read -r -p "Or press Enter to continue... " _

# --------------------------------------------------------------------
# Locate steamapps and the Proton compatdata prefix (appid 49540)
# --------------------------------------------------------------------
steamapps_dir="$game_root"
while [ "$steamapps_dir" != "/" ] && [ "$(basename "$steamapps_dir")" != "steamapps" ]; do
  steamapps_dir="$(dirname "$steamapps_dir")"
done

config_dir=""
if [ "$(basename "$steamapps_dir")" = "steamapps" ]; then
  compatdata_dir="$steamapps_dir/compatdata/49540"
  config_dir="$compatdata_dir/pfx/drive_c/users/steamuser/My Documents/My Games/Aliens Colonial Marines"

  if [ -d "$config_dir" ]; then
    echo
    echo "Found existing ACM config/save folder at:"
    echo "  $config_dir"
    echo
    read -r -p "Do you want to rename this folder now (recommended)? [y/N] " answer
    case "$answer" in
      [yY]*)
        backup_dir="${config_dir}_backup_$(date +%Y%m%d_%H%M%S)"
        mv "$config_dir" "$backup_dir"
        echo "Renamed config folder to:"
        echo "  $backup_dir"
        ;;
      *)
        echo "Leaving existing config folder untouched."
        ;;
    esac
  else
    echo
    echo "No existing ACM config/save folder found at the expected path:"
    echo "  $config_dir"
    echo "If you have a non-standard setup, you may need to handle this manually."
  fi
else
  echo
  echo "Warning: Could not locate a 'steamapps' directory above the game root."
  echo "Skipping automatic config/save folder rename."
fi

# --------------------------------------------------------------------
# Handle .upk.uncompressed_size files (Deck/Linux-specific behaviour)
# --------------------------------------------------------------------
echo
echo "Adjusting .upk.uncompressed_size files as per Deck/Linux guidance..."

# Helper: rename file to *.old if it exists
rename_uncompressed_size() {
  local rel_path="$1"
  if [ -f "$rel_path" ]; then
    local new_path="${rel_path}.old"
    mv "$rel_path" "$new_path"
    echo "  Renamed: $rel_path -> $new_path"
  else
    echo "  Not found (skipping): $rel_path"
  fi
}

# 1) DEFGEN_UnlocksVersus_SF.upk.uncompressed_size – explicitly ignored
echo "  Ignoring DEFGEN_UnlocksVersus_SF.upk.uncompressed_size as per forum notes."

# 2) These four get .old appended if they exist
rename_uncompressed_size "PecanGame/CookedPCConsole/GearboxFramework.upk.uncompressed_size"
rename_uncompressed_size "PecanGame/CookedPCConsole/PecanGame.upk.uncompressed_size"
rename_uncompressed_size "PecanGame/CookedPCConsole/PecanGameHorde.upk.uncompressed_size"
rename_uncompressed_size "PecanGame/CookedPCConsole/Engine.upk.uncompressed_size"

# IMPORTANT: Do NOT delete ACMOverhaulV6Install.bat
# (original batch file remains for reference)

# --------------------------------------------------------------------
# EXE handling – robust to case differences (ACM.exe vs ACM.EXE)
# --------------------------------------------------------------------

# Helper to find a file in Binaries/Win32 with case-insensitive name
find_exe_ci () {
  local pattern="$1"
  find "Binaries/Win32" -maxdepth 1 -type f -iname "$pattern" -print -quit 2>/dev/null || true
}

echo
echo "Configuring ACM executables..."

# Locate any existing backup (_ACM.exe / _ACM.EXE)
backup_exe="$(find_exe_ci '_acm.exe')"

# If no backup yet, create one from the current ACM.exe/ACM.EXE
if [[ -z "$backup_exe" ]]; then
  orig_exe="$(find_exe_ci 'acm.exe')"

  if [[ -n "$orig_exe" ]]; then
    echo "  Backing up original EXE to Binaries/Win32/_ACM.exe"
    mv "$orig_exe" "Binaries/Win32/_ACM.exe"
    backup_exe="Binaries/Win32/_ACM.exe"
  else
    echo "  Warning: Could not find original ACM executable to back up."
  fi
else
  echo "  Existing backup EXE found at: $backup_exe"
fi

# Remove any existing ACM.exe / ACM.EXE (if any remain after backup)
echo "  Removing any existing ACM executable..."
find "Binaries/Win32" -maxdepth 1 -type f -iname "acm.exe" -delete 2>/dev/null || true

# Find the fixed EXE shipped with the mod (ACM_fix.exe with any case)
fix_exe="$(find_exe_ci 'acm_fix.exe')"

if [[ -z "$fix_exe" ]]; then
  echo
  echo "Error: Could not find ACM_fix.exe in Binaries/Win32."
  echo "Make sure you have copied the mod files into the game folder correctly."
  exit 1
fi

echo "  Installing fixed EXE from: $fix_exe"
mv "$fix_exe" "Binaries/Win32/ACM.exe"

clear
echo "ACM Overhaul V6 installation complete (Linux/Proton)."
read -r -p "Press Enter to exit... " _
