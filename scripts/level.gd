extends Control

func _ready() -> void:
	Global.load_progress()
	#Global.reset()#อย่าลืมเอาออก
	$CanvasLayer/back.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/lvl1.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/lvl2.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/lvl1.disabled = false
	$CanvasLayer/lvl2.disabled = Global.unlocked_levels < 2


func _on_lvl_1_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")


func _on_back_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/start.tscn")


func _on_lvl_2_pressed() -> void:
	if Global.unlocked_levels >= 2:
		GlobleSound.play_sound("res://asset/btnSound.mp3")
		get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")
