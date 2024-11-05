extends Node2D

var tiempo = 0
export (PackedScene) var jugador
signal gameover
signal ganaste
var dinero :int 

var efectos_sonido= {"disparo": preload("res://sonidos/LanzarObjeto.wav"),
					"golpeado": preload("res://sonidos/EnemigoAtaca.wav"),
					"ladrido": preload("res://sonidos/Ladrido.wav"),
					"gameove": preload("res://sonidos/gameover.wav"),
					"bolsa": preload("res://sonidos/bolsa.wav"),
					"dolor": preload("res://sonidos/grito.wav"),
					"ganador": preload("res://sonidos/ganador.wav"),
					"salto_personaje": preload("res://sonidos/SaltoPersonaje.wav")}
# Called when the node enters the scene tree for the first time.
func _ready():
	$Interfaz.actualizar_time(tiempo)
	$tiempojuego.start()
	$Interfaz.mostra_mensaje("Recoge 27 \n bolsas \n para ganar")
	connect("gameover", $Interfaz, "GameOver")
	connect("ganaste", $Interfaz, "Ganaste")
	$Interfaz.actualizar_dinero(dinero)
	var player = jugador.instance()
	$music.play()
	add_child(player)
	get_node("Interfaz").barra_vida.max_value = player.vida_max
	get_node("Interfaz").actualizar_cambio_vida(player.vida_max)
	player.global_position = get_tree().get_nodes_in_group("sp")[0].global_position


func respawnear():
	get_tree().get_nodes_in_group("play")[0].global_position = get_tree().get_nodes_in_group("sp")[0].global_position
	

func incrementar_dinero():
	dinero += 1
	efectos_sonid("bolsa")
	$Interfaz.actualizar_dinero(dinero)

func efectos_sonid(efecto: String):
	$efectos.stream = efectos_sonido[efecto]
	$efectos.play()


func _on_tiempojuego_timeout():
	tiempo += 1
	if(tiempo > 1000):
		emit_signal("gameover")
		get_tree().get_nodes_in_group("play")[0].queue_free()
	else:
		$Interfaz.actualizar_time(tiempo)


func _on_timemusic_timeout():
	$music.play()


func _on_contenedor_body_entered(body):
	if(body.is_in_group("play")):
		if(dinero== 27):
			emit_signal("ganaste")
