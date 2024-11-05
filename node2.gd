extends Node

const IDLE_DURATION = 1.0


var reproduce = true

var speed = 3
onready var tween = $Tween
onready var plataforma  = $teleferico
onready var sonid = $sonido


func _ready():
	$timesonid.start()
	_init_tween() # Replace with function body.

func _init_tween():
	var duration = 10
	tween.interpolate_property(plataforma, "position", $desde.global_position, $hasta.global_position, duration, tween.TRANS_LINEAR)
	tween.interpolate_property(plataforma, "position", $hasta.global_position, $desde.global_position, duration, tween.TRANS_LINEAR)
	tween.interpolate_property(sonid, "position", $hasta.global_position, $desde.global_position, duration, tween.TRANS_LINEAR)
	tween.start()
	

func _physics_process(delta):
	plataforma.position = plataforma.position.linear_interpolate($desde.global_position, 0.075)
	sonid.position = sonid.position.linear_interpolate($desde.global_position, 0.075)
	if(reproduce):
		sonid.play()
		reproduce = false
	
func _on_timesonid_timeout():
	sonid.stop()
	reproduce = true

