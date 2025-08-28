extends Control

@onready var btn = $btnSound
var is_first_click = true

func _ready() -> void:
	$"CanvasLayer/Endless mode".focus_mode = Control.FOCUS_NONE
	$CanvasLayer/exit.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/Easy.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/medium.focus_mode = Control.FOCUS_NONE
	$CanvasLayer/Easy.visible = false
	$CanvasLayer/medium.visible = false
	$CanvasLayer/hard.visible = false

func _on_endless_mode_pressed() -> void:
	if is_first_click:
		is_first_click = false
		GlobleSound.play_sound("res://asset/btnSound.mp3")
		$CanvasLayer/Easy.visible = true
		$CanvasLayer/medium.visible = true
		$CanvasLayer/hard.visible = true
	else:
		is_first_click = true
		GlobleSound.play_sound("res://asset/btnSound.mp3")
		$CanvasLayer/Easy.visible = false
		$CanvasLayer/medium.visible = false
		$CanvasLayer/hard.visible = false


func _on_normal_mode_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().quit()


func _on_easy_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/mainEasy.tscn")


func _on_medium_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/mainMedium.tscn")


func _on_hard_pressed() -> void:
		GlobleSound.play_sound("res://asset/btnSound.mp3")
		get_tree().change_scene_to_file("res://scenes/main.tscn")
