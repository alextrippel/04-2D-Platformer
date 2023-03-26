extends KinematicBody2D


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		Global.health = 100
		Global.score += 10
		queue_free()
