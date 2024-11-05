extends CanvasLayer
var opciones = false
onready var label_numero := $UI/vida/barra/contad/fondo/numero
onready var barra_vida := $UI/vida/barra/medidor
onready var tween := $UI/Tween
var animar_vida = 0

func _ready():
	get_tree().paused = false
	$perdida.hide()
	$ganast.hide()
	$condicion.show()
	set_process(false)

func mostra_mensaje(mensaje: String):
	$mensaje.text = mensaje
	$mensaje.show()
	$tiempomensaje.start()

func GameOver():
	$"../music".stop()
	$perdida.show()
	get_parent().efectos_sonid("gameove")
	mostra_mensaje("Game Over")
	$"../tiempojuego".stop()
	$menu.show()
	$Reiniciar.show()

func Ganaste():
	$ganast.show()
	get_parent().efectos_sonid("ganador")
	get_tree().paused = true
	mostra_mensaje("Ganaste")
	$"../tiempojuego".stop()
	$menu.show()
	$Reiniciar.show()

func actualizar_dinero(cantidad :int):
	$bolsas.text = str(cantidad)
	if(cantidad==28):
		mostra_mensaje("Logrado")


func actualizar_time(tiempo: int):
	$tiempo.text = str(tiempo)
	
func _on_cambio_vida(vida : int):
	actualizar_cambio_vida(vida)

func actualizar_cambio_vida(nuevo_valor : int):
	tween.interpolate_property(self, "animar_vida", animar_vida, nuevo_valor, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if (!tween.is_active()):
		tween.start()
		set_process(true)

func _process(delta):
	var redondo = round(animar_vida)
	label_numero.text = str(redondo)
	barra_vida.value = redondo

func _on_tiempomensaje_timeout():
	$mensaje.hide()
	$condicion.hide()


func _on_Reiniciar_pressed():
	get_tree().reload_current_scene()


func _on_opciones_pressed():
	opciones = !opciones
	if opciones:
		$Pausa.show()
	else:
		$Pausa.hide()
	get_tree().paused = opciones


func _on_menu_pressed():
	get_tree().quit()
	
	
	#get_tree().change_scene_to(preload("res://Menu principal.tscn"))
