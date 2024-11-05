extends KinematicBody2D

var velocidad = Vector2()
var direccion = Vector2() setget _set_direccion
var vel_lateral = 400
var vel_max = 500
enum direcciones {izquierda = -1,derecha=1}
var dano = 50



func _ready():
	velocidad.x =0
	velocidad.y=0

func _process(delta):
	velocidad.x += direccion.x*vel_lateral
	velocidad.x = clamp(velocidad.x,-vel_max,vel_max)
	var movimiento = velocidad*delta
	move_and_collide(movimiento)
	

func _set_direccion(value):
	direccion = Vector2(value,0)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_tiempolife_timeout():
	queue_free()


func _on_detecta_body_entered(body):
	if body.is_in_group("enemi"):
		queue_free()
		body.call("recibir_comida", 50)
	if(body.is_in_group("pj")):
		queue_free()
