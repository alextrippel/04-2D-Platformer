extends Area2D

onready var inv = Global.inventory
onready var opened = preload('res://Assets/Chest_Open.png')

func _on_Open_body_entered(body):
	if body.name == 'Player' and inv.has('key') :
		Global.inventory.erase('key')
		$Open.set_collision_mask_bit(0,false)
		$Open.set_collision_layer_bit(0,false)
		$Sprite.texture = opened
		Global.score += 200
