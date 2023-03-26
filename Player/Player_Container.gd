extends Node2D

onready var Player = load('res://Player/Player.tscn')
export var spawn_location = Vector2(100,500)
export var spawn_location2 = Vector2(100,2000)

func _process(_delta):
	var player = get_node_or_null("Player")
	if player == null :
		if Global.level > 0:
			spawn(spawn_location2)
		else:
			spawn(spawn_location)
		

func spawn(p):
	var player = Player.instance()
	player.position = p
	player.name = "Player"
	add_child(player)

