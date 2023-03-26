extends Node2D

onready var E_Ground = load('res://Enemies/Enemy_Ground.tscn')
onready var E_Flying = load('res://Enemies/Enemy_Flying.tscn')
var spawn_point = [Vector2(1300,100),Vector2(640,100),Vector2(2000,800)]
#enemy dict is like this: {type, position, max constraint, min constraint}
func _physics_process(_delta):
	var count = 0
	var children = get_children()
	for c in children:
		if c.is_in_group("Enemy_Flying") and c.is_spawned:
			count += 1
	if count == 0 and Global.flying_left > 0:
		spawn("Enemy_Flying", {}, spawn_point[Global.level])
		Global.flying_left -= 1

func spawn(e_type, attr, p):
	var enemy = null
	if e_type == "Enemy_Ground":
		enemy = E_Ground.instance()
	if e_type == "Enemy_Flying":
		enemy = E_Flying.instance()
		enemy.is_spawned = true
	for a in attr:
		enemy[a] = attr[a]
	enemy.position = p
	add_child(enemy)
