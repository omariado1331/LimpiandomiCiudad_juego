extends KinematicBody2D

var velocidad_mov = 130
var valo_max = 150
var gravedad = 1500
var velocidad = Vector2()
var vida = 100
var damage = 20
var gusto = 0
var puede_comer = true
var puede_ladrar = true

func _process(delta):
	velocidad.y = gravedad * delta
	velocidad.x = clamp(velocidad_mov, -valo_max, valo_max)
	
	
	if(get_node("AnimatedSprite").is_flipped_h()):
		velocidad.x = -velocidad_mov
	else:
		velocidad.x = velocidad_mov
		
	var movimiento = velocidad*delta
	position += movimiento
	move_and_slide(velocidad, Vector2(0,-1))
	
	if(is_on_wall()):
		get_node("AnimatedSprite").flip_h = !get_node("AnimatedSprite").flip_h
	
	if(puede_ladrar):
		puede_ladrar=false
		$ladrido.play()

	#if(get_slide_collision(get_slide_count()-1) != null):
	#	var obj_colision = get_slide_collision(get_slide_count()-1).collider
	#	if(obj_colision.is_in_group("play")):
	#		get_tree().get_nodes_in_group("main")[0].respawnear()

func recibir_comida (cantidad : int):
	if(puede_comer):
		get_parent().efectos_sonid("ladrido")
		$tiempo.start()
		puede_comer = false
		gusto += cantidad
		print(gusto)
	if gusto >= 100:
		queue_free()
	
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("bala"):
		body.queue_free()
		recibir_comida(50)
	if body.is_in_group("play"):
		body.call("recibir_dano", damage)

func _on_tiempo_timeout():
	puede_comer = true

func _on_ladrar_timeout():
	puede_ladrar=  true
