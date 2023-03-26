extends Area2D

func _ready():
	pass


func _on_Portal_entered(body):
	if body.name == "Player":
		if name == "Portal_to_2":
			Global.level = 1
		if name == "Portal_to_3":
			Global.level = 2
		if name == "Portal_to_4":
			Global.level = 3
		if name == "Portal_to_5":
			Global.level = 4
		if Global.level < Global.levels.size():
			Global.flying_left = 5
			get_tree().change_scene(Global.levels[Global.level])
		else:
			
			get_tree().change_scene('res://Levels/Game_Over.tscn')
