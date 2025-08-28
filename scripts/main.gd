extends Node2D

@onready var player = $player
@onready var chicken = $chicken
@onready var egg = $egg
@onready var time_label = $CanvasLayer/Label
@onready var eggg = $player/egg

var is_holding_egg := false
var hold_time := 0.0
var game_over := false 
var exit_area = false

func _ready():
	$CanvasLayer/back.focus_mode = Control.FOCUS_NONE
	$"CanvasLayer/go back".focus_mode = Control.FOCUS_NONE
	egg.connect("stolen_signal", Callable(self, "_on_egg_stolen"))
	chicken.connect("player_caught", Callable(self, "_on_player_caught"))  
	chicken.target = player

func _process(delta: float) -> void:
	if is_holding_egg and not game_over: 
		eggg.visible = true
		hold_time += delta
		var s = "%.2f"%hold_time
		time_label.text = "Holding Egg: " + str(s)
	else:
		eggg.visible = false
	if exit_area and game_over:
		$"CanvasLayer/go back".visible = true
	else:
		$"CanvasLayer/go back".visible = false

func _on_egg_stolen() -> void:
	is_holding_egg = true
	hold_time = 0.0
	chicken.chase = true
	game_over = false
	time_label.text = "Holding Egg: 0.0s"

func _on_player_caught() -> void:
	game_over = true


func _on_back_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/start.tscn")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		exit_area = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		exit_area = false

func _on_go_back_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	$player.set_deferred("global_position", $playerHome.global_position)
