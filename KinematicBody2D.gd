extends KinematicBody2D

signal Objetivo
signal cambio_vida

export (PackedScene) var bala
var velocidad = Vector2()
var gravedad = 600
var velocidad_lateral = 50
var velo_max = 180
var vel_salto = 350
var dirbala = Vector2()
var movimiento
var puede_disparar = true
var vida : int
var puede_danar = true
var vida_max : int
# Called when the node enters the scene tree for the first time.
func _ready():
	vida_max = 100
	vida = vida_max
	dirbala.y =0
	connect("Objetivo", get_parent(), "incrementar_dinero")
	connect("cambio_vida", get_parent().get_node("Interfaz"), "_on_cambio_vida")

func _physics_process(delta):	
	
	velocidad.y += gravedad * delta

	if(Input.is_action_pressed("ui_right")):
		velocidad.x += velocidad_lateral
		
	elif(Input.is_action_pressed("ui_left")):
		velocidad.x -= velocidad_lateral
	else:
		velocidad.x=0
	
	if(is_on_floor()):
		velocidad.y = 0
		if(Input.is_action_just_pressed("ui_up")):
			get_parent().efectos_sonid("salto_personaje")
			velocidad.y -= vel_salto
	
	if(Input.is_action_just_pressed("disparar")):
		_disparo()
		
	if(velocidad.y > 700):
		queue_free()
		get_tree().root.get_node("Node2D").emit_signal("gameover")
	velocidad.x = clamp(velocidad.x, -velo_max, velo_max)
	
	var snap = Vector2.DOWN * 32 if !is_on_floor() else Vector2(0,-1)
	movimiento= velocidad*delta
	position += movimiento
	move_and_slide_with_snap(velocidad, snap, Vector2(0,-1))
	
	
	
	#anima los sprites
	if(movimiento.x != 0):
		$AnimatedSprite.animation = "Derecha"
		$AnimatedSprite.flip_h = movimiento.x < 0
	elif(movimiento.y != 0):
		$AnimatedSprite.animation="Frente"
	else:
		$AnimatedSprite.animation= "Frente"

func _disparo():
	if(puede_disparar):
		if(velocidad.x != 0):
			get_parent().efectos_sonid("disparo")
			$Timer.start()
			puede_disparar = false
			var newbala = bala.instance()
			get_parent().add_child(newbala)
			if($AnimatedSprite.is_flipped_h()):
				newbala.direccion = newbala.direcciones.izquierda
				dirbala.x = -80
			else:
				newbala.direccion = newbala.direcciones.derecha
				dirbala.x = 80
			newbala.global_position = $newPosBala.global_position + dirbala


func recibir_dano(cantidad : int):
	if(puede_danar):
		get_parent().efectos_sonid("dolor")
		$Invulnerable.start()
		puede_danar = false
		vida -= cantidad
	if vida <= 0:
		queue_free()
	emit_signal("cambio_vida", vida)

func _on_Timer_timeout():
	puede_disparar= true # Replace with function body.
func _exit_tree() -> void:
	get_tree().root.get_node("Node2D").emit_signal("gameover")
func _on_Area2D_body_entered(body):
	if(body.is_in_group("enemig")):
		recibir_dano(20)
	if(body.is_in_group("bala")):
		body.queue_free()
func _on_Invulnerable_timeout():
	puede_danar = true
