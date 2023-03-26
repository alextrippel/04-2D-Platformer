extends KinematicBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		Global.inventory.append('key')
		Global.score += 10
		queue_free()
		
