extends Control

var arr_color := PoolColorArray([Color.darkgoldenrod, Color.aquamarine, Color.violet, 
Color.beige, Color.black, Color.coral, Color.aliceblue, Color.brown,
Color.azure, Color.pink, Color.turquoise, Color.greenyellow ])


func _ready():
	cambiar_fluido()


func cambiarcolor():
	var i = 0
	while(true):
		$ColorRect.color = arr_color[i]
		i+=1
		if (i == arr_color.size()):
			i=0
		yield(get_tree().create_timer(1), "timeout")

func cambiar_fluido ():
	var i = 0
	while (true) :
		if abs($ColorRect.color.to_argb32()-arr_color[i].to_argb32()) > 0.00001 :
			$ColorRect.color = lerp($ColorRect.color, arr_color[i], 0.1)
		elif i == arr_color.size():
			i=0
		else:
			i += 1
		yield(get_tree().create_timer(0.05), "timeout")
		

func _on_nuevojuego_pressed():
	get_tree().change_scene_to(preload("res://tuto.tscn"))


func _on_salir_pressed():
	get_tree().quit()
