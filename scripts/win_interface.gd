extends Control




func _on_back_pressed() -> void:
	#get_tree().paused = false
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/level.tscn")
