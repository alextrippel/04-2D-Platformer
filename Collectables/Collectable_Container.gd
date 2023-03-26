extends Node2D

onready var Key = load('res://Collectables/Key.tscn')
onready var Food = load('res://Collectables/Food.tscn')
onready var Chest = load('res://Collectables/Chest.tscn')
var spawn_point = [Vector2(1300,100)]
#enemy dict is like this: {type, position, max constraint, min constraint}

func spawn(c_type, attr, p):
	var collectible = null
	if c_type == "Key":
		collectible = Key.instance()
	if c_type == "Food":
		collectible = Food.instance()
	if c_type == "Chest":
		collectible = Chest.instance()
	for a in attr:
		collectible[a] = attr[a]
	collectible.position = p
	add_child(collectible)
