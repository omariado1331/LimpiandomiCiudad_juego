extends Control




func _on_sonido_pressed():
	pass # Replace with function body.


func _on_reinici_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().quit()
