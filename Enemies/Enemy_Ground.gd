extends KinematicBody2D

export var speed = 5
export var damage = 25

export var max_constraint = 100
export var min_constraint = -100
var direction = 1
var velocity = Vector2.ZERO


func _physics_process(_delta):
	if direction > 0 and !$AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction < 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	
	velocity.x += direction * speed
	velocity.x = clamp(velocity.x,-500,500)
	velocity = move_and_slide(velocity, Vector2.UP)
		
func die():
	queue_free()

func _on_Area2D_body_entered(body):
	if velocity.x != 0 and (body.name == "Platform" or body.name == "Ground" or body.name == "Player") :
		velocity.x = 0
		direction *= -1
	if body.name == "Player" :
		print(self.get_parent().name)
		body.do_damage(damage)



func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Attack_Container":
		area.end()
		die()
