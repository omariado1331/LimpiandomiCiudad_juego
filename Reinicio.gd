extends Position2D

export (PackedScene) var jugador

func _ready():
	var player = jugador.instance()
	player.global_position = global_position
	get_tree().get_nodes_in_group("main")[0].add_child(player)
	

