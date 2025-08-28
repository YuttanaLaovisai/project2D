extends Area2D

signal stolen_signal 

var player_enter := false
var player_ref: Node = null
var stealing := false
var steal_time := 0.0
var steal_duration := 3.0

func _process(delta: float) -> void:
	if player_enter and player_ref:
		stealing = true
	else:
		stealing = false
		steal_time = 0.0

	if stealing:
		steal_time += delta
		$ProgressBar.value = steal_time
		if steal_time >= steal_duration:
			emit_signal("stolen_signal")
			stealing = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$ProgressBar.visible = true
		player_enter = true
		player_ref = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$ProgressBar.visible = false
		$ProgressBar.value = 0
		player_enter = false
		player_ref = null
