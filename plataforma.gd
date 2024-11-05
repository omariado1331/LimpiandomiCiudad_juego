extends Node2D

var velocidad = Vector2()
var distancia = Vector2()
var target
export (float) var tiempo_esimado = 3

func _ready():
	target = get_node("hasta")
	distancia = target.global_position - get_node("teleferico").global_position
	velocidad = distancia / tiempo_esimado
	get_node("teleferico").linear_velocity = velocidad 
	
	
func _physics_process(delta):
	get_node("teleferico").rotation_degrees = 0
	

func set_objetivo():
	if(target == get_node("desde")):
		target= get_node("hasta")
	else:
		target= get_node("desde")
	distancia = target.global_position - get_node("teleferico").global_position
	velocidad = distancia / tiempo_esimado
	get_node("teleferico").linear_velocity = velocidad


func _on_Area2D_body_entered(body):
	if(body.is_in_group("plataforma")):
		set_objetivo()
