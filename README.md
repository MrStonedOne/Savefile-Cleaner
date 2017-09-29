# Savefile-Cleaner
Cleans up old ss13 save files

This assumes all save files start with `preferences` and are in a `letter`/`ckey`/`preferences*` format.
Other files named `preferences*` but aren't `preferences.sav` are assumed to be old versions and are recorded as version 1 save files. This allows you to clean up old character saves from when they were their own file

1. Compile the code.
1. Run the dmb in trusted mode
1. Press scan dir and enter the path to the player_save folder (if you put the dmb in the player_save folder, you can just type ./ here)
1. This will take a moment, it will print reports for each letter then at the end it will print a report showing a save file version break down.
1. Press Cleanup, This will ask you for a version number. This is the last version to be deleted. Save versions between 1 and this version will be deleted.
	* Look at `preferences_savefile.dm` in your repo, the `SAVEFILE_VERSION_MIN` number minus 1 will be what you'll want to use. on /tg/ this is `15`, so I use `14` in this prompt
1. It will print a break down of how many save files are about to deleted and give you a final prompt, press yes and it will start deleting.
