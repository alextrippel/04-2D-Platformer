extends KinematicBody2D


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		Global.health = 100
		Global.score += 10
		queue_free()
		var newpos = position + Vector2(0,-32)
		$Tween.interpolate_property($Sprite, 'global_position', position, newpos, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		$Tween.interpolate_property($Sprite, 'scale', scale, Vector2(0.01,0.01), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		$Tween.start()

func _on_Tween_tween_all_completed():
	queue_free()
