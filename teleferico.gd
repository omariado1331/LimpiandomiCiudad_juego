extends KinematicBody2D

const IDLE_DURATION = 1.0

var move_to = Vector2()

var speed = 3
onready var tween = $Tween

func _ready():
	move_to = $desde.global_position
	_init_tween() # Replace with function body.

func _init_tween():
	var duration = 5
	tween.interpolate_property(KinematicBody, "position", move_to, $hasta.global_position, duration, tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(KinematicBody, "position", $hasta.global_position, move_to, duration, tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.start()
