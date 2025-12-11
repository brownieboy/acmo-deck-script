# acmo-deck-script

A SteamDeck/Linux script to help install TemplarGFX's Overhaul Mod for Aliens Colonial Marines (ACM).  Seriously, you do *not* want to be playing the game without this mod.  Unless, of course, you prefer the aliens to just stand still in front of you, waiting to be shot!

The mod zip file contains a Windows batch (.bat) file, which you need to run in order to rename some files.   But Windows batch files don't run on Linux/SteamOS.  And the file paths would be all different even if it did run.  The Windows batch file also assumes case insensitivity (i.e. Windows) when renaming stuff, whereas Linux/SteamOS is case sensitive.  I've catered for all of this in my shell script, overhaul.sh.

As well as updating for Linux, I've also incorporated some suggestions from [this Reddit thread](https://www.reddit.com/r/SteamDeck/comments/14ypjrh/aliens_colonial_marines_templargfx_overhaul_mod/).

## Installation Instructions

Note: the instructions say that the update will only work on a new, pristine copy of the game.  So if you have any mods in here already, you'll need to uninstall the game and then reinstall it using the Steam client.

I've tested this installation on a Manjaro Linux PC and also a SteamDeck OLED.

For the SteamDeck, you need to be in Desktop Mode. Ideally, you should also be using a mouse and keyboard via a dock for these steps. You can probably manage to do it without one, but it will be a lot harder, and you'll be more likely to make mistakes.

### Download and extract the mod files

[Download two TemplarGFX files from ModDB](https://www.moddb.com/mods/templargfxs-acm-overhaul).  There's lots of files there, but the only two that you need are:

1. **ACMO V6 MODDB SEP2020**: the full 6.0 update
1. **ACM Overhaul V6.2 Patch**: a patch that's applied after you've installed the main V6 update

After downloading, extract each of the two zip files to your Downloads folder. You can do this by right clicking on the zip files in Dolphin (a Linux/KDE file manager) and picking **Extract -> Extract here** from the pop-up. That will create a new folder for each zip.  Take note of those folder names and locations.

### Opening the Game Files Folder

I see a lot of instructions on the web for how to find your various game files on the different platforms, e.g. for Windows they may be in this folder, but on SteamOS they may be one of several other folders.  No need to waste your time with any of this.   The Steam client knows where your game files, so get it to show you.

Open the Steam client and go to your ACM entry.  Click the settings (cog) icon, then it's **Manage -> Browse local files**. That will open the Dolphin file at your ACM files folder.  Easy.

You may want to take a backup of that folder at this point, just in case this process all goes wrong! I suggest you copy it to somewhere outside of the /steamapps folder, so that Steam doesn't pick up your backup as a second copy of the game.

### Copy Over 6.0 update files

In another copy of Dolphin, open the extracted folder for the 6.0 patch that you extracted earlier. This will be in your Downloads folder.

Drag the contents of that folder into the ACM game files folder, the one you opened from your Steam client in an earlier step. It's probably easiest to have two copies of Dolphin open for this step.

After dragging, you should see a series of prompts from Dolphin.  You need to select these options:

- From the first prompt, pick **Copy**, not **Move**
- At the **Folder Already Exists** prompt:
  - tick the **Apply to All** checkbox
  - hit the **Write Into** button.
- At the **File Already Exists** prompt:
  - tick the **Apply to All** checkbox again
  - hit the **Overwrite** button.

If you don't see any of these prompts, you've copied the files to the wrong place!!

### Download the Bash Script file and Run It

Download the overhaul.sh file from this repo and copy it into your ACM game files folder.

#### Set execute permission

Unlike Windows, Linux doesn't let you run a script file unless you've explicitly given that file the permission to do so.  (Yet another reason that Linux isn't a virus heaven.)

In Dolphin, right click on the overhaul.sh file, and pick **Properties**, then the **Permissions** tab. You need to tick the **Allow executing file as program** checkbox then the **OK** button.  If you prefer to use the terminal for this step, the command is:

```bash
chmod +x ./overhaul.sh
```

#### Run the script

Your script is now ready to run. Right click on it again in Dolphin, then pick **Open Terminal Here**. (Note: this may be under the **Actions** menu in later versions of KDE.) That should open the terminal at your ACM game files folder.

To actually run the script, type this into the terminal:

```bash
./overhaul.sh
```

Hit your Enter/Return key when the script prompts you to.

### Copy over the 6.2 patch files

Find the folder for the 6.2 patch in your Downloads folder, which you extracted earlier. Drag and drop the contents of the folder into your ACM files folder, like you did with the full 6.0 update folder contents. At the various Dolphin prompts, choose the exact same options that you did for the 6.0 patch copy.

You don't need to run any script this time.

## Enjoy the game!

That's it.  You're done.  Time to run the game.

You should see the TemplarGFX splash screen when you run the game from Steam now.

## Acknowledgements

Special thanks to:

- TemplarGFX for the [marvellous mod](https://www.moddb.com/mods/templargfxs-acm-overhaul), which makes Aliens Colonial Marines so much better.
- ac2334 for starting [this Reddit thread](https://www.reddit.com/r/SteamDeck/comments/14ypjrh/aliens_colonial_marines_templargfx_overhaul_mod/), and also to everybody that commented there.
- ChatGPT for actually writing the script! (I kept a watchful eye on him all the way through the process though.)
