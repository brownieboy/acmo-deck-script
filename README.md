# acmo-deck-script

A SteamDeck/Linux script to help install TemplarGFX's Overhaul Mod for Aliens Colonial Marines (ACM).

This script replicates the functionality of the .bat (Windows batch) file that comes with the installer zips for that Mod.   Windows batch files don't run on Linux/SteamOS, plus the file paths would be all different even if it did run.  The Windows batch file also assumes case insensitivity (i.e. Windows) when renaming stuff, whereas Linux/SteamOS is case sensitive.

As well as updating for Linux, I've also incorporated some suggestions from [this Reddit thread](https://www.reddit.com/r/SteamDeck/comments/14ypjrh/aliens_colonial_marines_templargfx_overhaul_mod/).

## Installation Instructions

Note: the instructions say the update will only work on a new, pristine copy of the game. So if you have any mods in here already, you'll need to uninstall the game and then reinstall it using the Steam client.

For the SteamDeck, you need to be in Desktop Mode. Ideally, you should also be using a mouse and keyboard via a dock for these steps. You can probably manage to do it without one, but it will be a lot slower, and you'll be more prone to making mistakes.

### Download and extract the mod files

[Download the two TemplarGFX files from ModDB](https://www.moddb.com/mods/templargfxs-acm-overhaul). The files that want you are:

1. **ACMO V6 MODDB SEP2020**: the full 6.0 update
1. **ACM Overhaul V6.2 Patch**: a patch that's applied after you've installed the main V6 update

After downloading, extract each of the two zip files to your Downloads folder. You can do this by right clicking on the zip files in Dolphin (a Linux file manager) and picking **Extract -> Extract here** from the pop-up. That will create new folder for each zip.

### Opening the Game Files Folder

Easy one. Go to the ACM entry in your Steam client, and click on the settings icon. Then it's **Manage -> Browse local files**. That will open Dolphin at your ACM files folder.

You may want to take a backup of that folder at this point, just in case this process all goes wrong! I suggest you copy it to somewhere outside of the /steamapps folder, so that Steam doesn't pick up your backup as a second copy of the game.

### Copy Over 6.0 update files

In another copy of Dolphin, open the extracted folder for the 6.0 patch that you extracted earlier. This will be in your Downloads folder.

Drag the contents of that folder into the ACM game files folder, the one you opened from your Steam client in an earlier step. It's probably easiest to have two copies of Dolphin open for this step.

After dragging, you should pick **Copy**, not **Move**, when prompted by Dolphin. At the **Folder Already Exists** prompt, tick the **Apply to All** checkbox and then the **Write Into** button. At the **File Already Exists** prompt, tick the **Apply to All** checkbox again, then the **Overwrite** button.

### Download the Bash Script file and Run It

Download the overhaul.sh file from this repo and copy it into your ACM game files folder.

In Dolphin, right click on the overhaul.sh file, and pick **Properties**, then the **Permissions** tab. You need to tick the **Allow executing file as program** checkbox then the **OK** button.

Your script is now ready to run. Right click on it again in Dolphin, then pick **Open Terminal Here**. (Note: this may be under the **Actions** menu in later versions of KDE.) That should open the terminal at your ACM game files folder.

To actually run the script, type this into the terminal:

```bash
./overhaul.sh
```

Then hit your Enter key when prompted.

### Copy over the 6.2 patch files

Find the folder for the 6.2 patch in your Downloads folder that you extracted earlier. Drag and drop the contents of the folder into your ACM files folder, like you did with the full 6.0 update folder contents. At the various Dolphin prompts, choose the exact same options that you did for the 6.0 patch copy.

There is no script to run this time.

That's it.  You're done.  Time to run the game.

## Acknowledgements

Special thanks to:

- TemplarGFX for the [marvellous mod](https://www.moddb.com/mods/templargfxs-acm-overhaul), which makes Aliens Colonial Marines so much better.
- ac2334 for starting [this Reddit thread](https://www.reddit.com/r/SteamDeck/comments/14ypjrh/aliens_colonial_marines_templargfx_overhaul_mod/), and also to everybody that commented there.
- ChatGPT for actually writing the script! (I kept a watchful eye on him all the way through the process though.)
