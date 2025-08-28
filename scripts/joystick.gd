extends Control

@export var radius := 100
@export var deadzone := 0.9 
var direction := Vector2.ZERO
var dragging := false
@onready var knob = $Knob
var defaultPos

func _ready() -> void:
	defaultPos = knob.position

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and _is_inside_joystick(event.position):
			dragging = true
			_update_knob(event.position)
		elif not event.pressed:
			dragging = false
			knob.position = defaultPos
			direction = Vector2.ZERO

	elif event is InputEventScreenDrag and dragging:
		_update_knob(event.position)

func _is_inside_joystick(pos: Vector2) -> bool:
	return pos.distance_to(global_position) <= radius

func _update_knob(pos: Vector2):
	var offset = pos - global_position
	if offset.length() > radius:
		offset = offset.normalized() * radius
	knob.position = offset

	if offset.length() >= radius * deadzone:
		direction = offset.normalized()
	else:
		direction = Vector2.ZERO
