extends Node2D

@onready var player = $player
@onready var chicken = $chicken
@onready var egg = $egg
@onready var eggg = $player/egg

var is_holding_egg := false
var highest_time := 0.0
var hold_time := 0.0
var game_over := false 
var exit_area = false
var win = false

func _ready():
	$CanvasLayer/back.focus_mode = Control.FOCUS_NONE
	$"CanvasLayer/go back".focus_mode = Control.FOCUS_NONE
	egg.connect("stolen_signal", Callable(self, "_on_egg_stolen"))
	chicken.connect("player_caught", Callable(self, "_on_player_caught"))  
	chicken.target = player
	$"CanvasLayer/go back".visible = false  
	$CanvasLayer/win_interface/CanvasLayer/back.visible = false
	$CanvasLayer/win_interface/CanvasLayer/Label.visible = false
	$CanvasLayer/win_interface/CanvasLayer/next.visible = false
	$CanvasLayer/win_interface/CanvasLayer/win.visible = false
	$CanvasLayer/win_interface/CanvasLayer/Pan.visible = false

func _process(delta: float) -> void:
	if is_holding_egg and not game_over: 
		eggg.visible = true
		hold_time += delta
		var s = "%.2f" % hold_time
	else:
		eggg.visible = false
	
	if game_over and not win:
		$"CanvasLayer/go back".visible = true

func _on_egg_stolen() -> void:
	is_holding_egg = true
	hold_time = 0.0
	chicken.chase = true
	game_over = false

func _on_player_caught() -> void:
	game_over = true
	if highest_time < hold_time:
		highest_time = hold_time
		var s = "%.2f" % hold_time

func _on_back_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_holding_egg and body.is_in_group("player"):
		#get_tree().paused = true
		win = true
		Global.unlock_level(2)
		$CanvasLayer/win_interface.visible = true 
		$CanvasLayer/win_interface/CanvasLayer/back.visible = true
		$CanvasLayer/win_interface/CanvasLayer/Label.visible = true
		$CanvasLayer/win_interface/CanvasLayer/next.visible = true
		$CanvasLayer/win_interface/CanvasLayer/win.visible = true
		$CanvasLayer/win_interface/CanvasLayer/Pan.visible = true

func _on_go_back_pressed() -> void:
	GlobleSound.play_sound("res://asset/btnSound.mp3")
	
	$"CanvasLayer/go back".visible = false  
	
	$player.set_deferred("global_position", $playerHome.global_position)
	
	is_holding_egg = false
	eggg.visible = false
	chicken.chase = false 
	hold_time = 0.0   
	game_over = false    
