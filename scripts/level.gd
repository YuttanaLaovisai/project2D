extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/back.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/lvl1.focus_mode = Control.FOCUS_NONE

func _on_lvl_1_pressed() -> void:
		GlobleSound.play_sound("res://asset/btnSound.mp3")
		get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")


func _on_back_pressed() -> void:
		GlobleSound.play_sound("res://asset/btnSound.mp3")
		get_tree().change_scene_to_file("res://scenes/start.tscn")
