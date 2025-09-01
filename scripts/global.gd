extends Node

var unlocked_levels: int = 1

func unlock_level(level: int) -> void:
	if level > unlocked_levels:
		unlocked_levels = level
		save_progress()

func save_progress():
	var save_data = {
		"unlocked_levels": unlocked_levels
	}
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_var(save_data)

func load_progress():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		var save_data = file.get_var()
		unlocked_levels = save_data.get("unlocked_levels", 1)

func reset():
	unlocked_levels = 1
