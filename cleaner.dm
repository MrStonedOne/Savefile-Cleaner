#define VERSION_MAX 100
world
	fps = 50

mob
	verb
		loaddir(path as text)
			saves = list()
			total = 0
			src << "started on [path]"
			var/list/firstletter = flist(path)
			if (firstletter.len == 1 && firstletter[1] == path+"/")
				path = path + "/"
				src << "correcting to [path]"
				firstletter = flist(path)

			for(var/letter in firstletter)
				src << "opening [letter]"
				if(copytext(letter, -1, 0) != "/")
					continue //we want the files in the directories
					src << "[letter] is not a directory"
				var/list/ckeys = flist("[path][letter]")
				src << "[letter] has [length(ckeys)] ckeys"
				sleep world.tick_lag
				for (var/ckey in ckeys)
					var/list/files = flist("[path][letter][ckey]preferences")
					for(var/file in files)
						var/version = 1
						if (file == "preferences.sav")
							try
								var/savefile/S = new /savefile("[path][letter][ckey][file]")
								S["version"] >> version
							catch()
								version = 1 //invalid files are version 1 so that they get deleted
						if (!version || !isnum(version) || version < 1 || version > 100)
							version = 1
						if (saves.len < version)
							saves.len = version
						var/saveentry = saves[version]
						if (!saveentry)
							saveentry = list()
							saves[version] = saveentry
						saveentry += "[path][letter][ckey][file]"
			var/i = 1
			for(var/version in saves)
				src << "[i++] = [length(version)]"
				total += length(version)
			src << "Found [total] saves"

		cleanup(to_version as num)
			if (!length(saves))
				src << "Gotta scan first buddy."
				return
			if (!to_version || !isnum(to_version) || to_version < 1 || to_version > length(saves))
				src << "Invalid version number"
				return

			var/count = 0

			for (var/i in 1 to to_version)
				var/l = length(saves[i])
				src << "Version [i] has [l] to be deleted."
				count += l
			src << "Total of [count] save files to be deleted out of [total]."

			if (alert(src, "This will delete [count] savefiles between version 1 and [to_version] (inclusive), out of a total of [total] save files detected. THIS CAN NOT BE UNDONE", "Are you sure?", "No", "Yes", "No ") == "Yes")
				src << "Deleting [count] out of [total] savefiles between version 1 and [to_version] (inclusive)...."
				sleep world.tick_lag
				for (var/i in 1 to to_version)
					var/list/files = saves[i]
					src << "Deleting [length(files)] for version [i]..."
					sleep world.tick_lag
					for(var/file in files)
						fdel(file)
						var/list/dirparts = splittext(file, "/")
						dirparts.len--
						var/ckeydir = dirparts.Join("/")
						var/ckeydir_contents = flist("[ckeydir]/")
						if (!length(ckeydir_contents))
							fdel("[ckeydir]/")

					src << "Deleted [length(files)] for version [i]..."
					sleep world.tick_lag
				src << "Done."
			else
				src << "Okay. I won't"



proc/get_save_file_version(file)



var/list/saves
var/total