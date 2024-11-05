extends Area2D


var tomo : bool = false


func _on_Objetivo_body_entered(body):
	if body == null: return
	if body.is_in_group("play"):
		if !tomo:
			body.emit_signal("Objetivo")
			tomo = true
			queue_free()
