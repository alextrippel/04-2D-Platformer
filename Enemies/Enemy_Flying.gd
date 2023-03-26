extends KinematicBody2D

var player = null
onready var ray = $RayCast2D
export var speed = 175
export var looking_speed = 100
var damage = 35
var score = 10
var velocity = Vector2.ZERO
export var is_spawned = false

func _physics_process(_delta):
	if velocity.x > 0 and !$AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if velocity.x <= 0 and $AnimatedSprite.flip_h :
		$AnimatedSprite.flip_h = false
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c:
			velocity= ray.cast_to.normalized()*looking_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized()*speed
			velocity = move_and_slide(velocity,Vector2(0,0))
		
		

func _on_Area2D_body_entered(body):
	if body.name == "Player" :
		body.do_damage(damage)
		player = null

func die():
	if is_spawned:
		Global.score += score*(Global.flying_left+1)
	else :
		Global.score += score
	queue_free()
