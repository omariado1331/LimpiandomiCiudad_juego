extends Node2D

var tiempo = 0
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

func _ready():
	$Interf.actualizar_time(tiempo)
	$timejuego.start()
	$Interf.mostra_mensaje("Tutorial")
	connect("gameover", $Interf, "GameOver")
	connect("ganaste", $Interf, "Ganaste")
	$Interf.actualizar_dinero(dinero)
	$musica.play()
	get_node("Interf").barra_vida.max_value = 100
	get_node("Interf").actualizar_cambio_vida(100)

func efectos_sonid(efecto: String):
	$efectos.stream = efectos_sonido[efecto]
	$efectos.play()

func incrementar_dinero():
	dinero += 1
	efectos_sonid("bolsa")
	$Interf.actualizar_dinero(dinero)
	

func _on_timejuego_timeout():
	tiempo += 1
	if(tiempo > 300):
		emit_signal("gameover")
		get_tree().get_nodes_in_group("pj")[0].queue_free()
	else:
		$Interf.actualizar_time(tiempo)


func _on_timemusi_timeout():
	$musica.play()


func _on_conteiner_body_entered(body):
	if(body.is_in_group("pj")):
		print("entro pj")
		if(dinero== 5):
			emit_signal("ganaste")
