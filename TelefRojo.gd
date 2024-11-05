extends Node

const IDLE_DURATION = 3

var reproduc = true

var speed = 3
onready var tween = $Tween2
onready var plataforma  = $TelefericoRojo
onready var sonido = $sonide

func _ready():
	$timesonido.start()
	_init_tween() # Replace with function body.

func _init_tween():
	var duration = 12
	tween.interpolate_property(plataforma, "position", $comienzo.global_position, $llegada.global_position, duration, tween.TRANS_LINEAR)
	tween.interpolate_property(plataforma, "position", $llegada.global_position, $comienzo.global_position, duration, tween.TRANS_LINEAR)
	tween.interpolate_property(sonido, "position", $comienzo.global_position, $llegada.global_position, duration, tween.TRANS_LINEAR)
	tween.interpolate_property(sonido, "position", $llegada.global_position, $comienzo.global_position, duration, tween.TRANS_LINEAR)
	tween.start()

func _physics_process(delta):
	plataforma.position = plataforma.position.linear_interpolate($comienzo.global_position, 0.075)
	sonido.position = plataforma.position.linear_interpolate($comienzo.global_position, 0.075)
	if(reproduc):
		sonido.play()
		reproduc = false
		
func _on_timesonido_timeout():
	sonido.stop()
	reproduc = true
