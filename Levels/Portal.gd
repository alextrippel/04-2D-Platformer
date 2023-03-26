extends Area2D

onready var inv = Global.inventory

func _ready():
	if Global.level == 2:
		self.set_collision_mask_bit(0,false)
		self.set_collision_layer_bit(0,false)
		

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


func _on_Unlock_body_entered(body):
	if Global.level == 2 and inv.has('key') and $Unlock.visible and body.name == 'Player':
		$Unlock.visible = false
		Global.inventory.erase('key')
		self.set_collision_mask_bit(0,true)
		self.set_collision_layer_bit(0,true)
