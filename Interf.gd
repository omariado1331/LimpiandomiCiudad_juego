extends CanvasLayer

var opciones =false
onready var label_numero := $UI/vida/barra/contad/fondo/numero
onready var barra_vida := $UI/vida/barra/medidor
onready var tween := $UI/Tween
var animar_vida = 0

func _ready():
	get_tree().paused = false
	$perdida.hide()
	$ganast.hide()
	set_process(false)
	$timemsj.start()
	$condicion.show()



func mostra_mensaje(mensaje: String):
	$msjperdiste.text = mensaje
	$msjperdiste.show()
	$timemsj.start()


func GameOver():
	$"../musica".stop()
	$perdida.show()
	get_parent().efectos_sonid("gameove")
	mostra_mensaje("Game Over")
	$"../timejuego".stop()
	$reinicio.show()



func Ganaste():
	$ganast.show()
	get_parent().efectos_sonid("ganador")
	get_tree().paused = true
	mostra_mensaje("Ganaste")
	$"../timejuego".stop()
	$continuar.show()
	$reinicio.show()
	
func actualizar_dinero(cantidad :int):
	$numbolsas.text = str(cantidad)
	if(cantidad == 5):
		mostra_mensaje("Logrado")


func actualizar_time(tiempo: int):
	$tiemp.text = str(tiempo)

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

func _on_timemsj_timeout():
	$msjperdiste.hide()
	$condicion.hide()


func _on_reinicio_pressed():
	get_tree().reload_current_scene()

func _on_opcion_pressed():
	opciones = !opciones
	if opciones:
		$pause.show()
	else:
		$pause.hide()
	get_tree().paused = opciones


func _on_continuar_pressed():
	get_tree().change_scene_to(preload("res://Main.tscn"))
