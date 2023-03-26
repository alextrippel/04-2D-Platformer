extends Area2D
export var score = 50

func _ready():
	pass


func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.increase_score(score)
		var newpos = position + Vector2(0,-32)
		$Tween.interpolate_property($AnimatedSprite, 'global_position', position, newpos, 0.25, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		$Tween.interpolate_property($AnimatedSprite, 'scale', scale, Vector2(0.01,0.5), 0.25, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	queue_free()
