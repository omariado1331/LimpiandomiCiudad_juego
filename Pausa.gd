extends Control
var presionado=true
func _on_sonido_pressed():
	if(presionado):
		get_parent().get_parent().get_node("music").stop()
		presionado= false
	else:
		get_parent().get_parent().get_node("music").play()
		presionado=true


func _on_reiniciar_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_salir_pressed():
	get_tree().quit()
