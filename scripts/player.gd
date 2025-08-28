extends RigidBody2D

@export var speed := 1000
var dir := Vector2.ZERO
var pick_pressed := false
@onready var joystick = $"CanvasLayer/Virtual Joystick"

func _ready() -> void:
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "idle"

func _physics_process(delta):
	dir = joystick.get_direction()
	
	if Input.is_action_pressed("w") || Input.is_action_pressed("up"):
		dir.y -= 1
	if Input.is_action_pressed("s") || Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("a") || Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("d") || Input.is_action_pressed("right"):
		dir.x += 1
	
	if dir != Vector2.ZERO:
		if not $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
		dir = dir.normalized()
		if dir.y < 0:
			$AnimatedSprite2D.animation = "up"
		else:
			$AnimatedSprite2D.animation = "down"
		$AnimatedSprite2D.flip_h = dir.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"
		if $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.stop()
	
	linear_velocity = dir * speed
