extends Node2D

onready var Key = load('res://Collectables/Key.tscn')
onready var Food = load('res://Collectables/Food.tscn')
onready var Chest = load('res://Collectables/Chest.tscn')
#enemy dict is like this: {type, position, max constraint, min constraint}

func spawn(c_type, attr, p):
	var collectable = null
	if c_type == "Key":
		collectable = Key.instance()
	if c_type == "Food":
		collectable = Food.instance()
	if c_type == "Chest":
		collectable = Chest.instance()
	for a in attr:
		collectable[a] = attr[a]
	collectable.position = p
	add_child(collectable)
