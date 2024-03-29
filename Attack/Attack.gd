extends Area2D

var direction = null
var velocity = Vector2.ZERO
var speed = 10
var dead = false

func _ready():
	var player = get_node_or_null('/root/Game/Player_Container/Player')
	direction = player.direction
	$AnimatedSprite.animation = 'start'
	$AnimatedSprite.playing = true

func _physics_process(_delta):
	if direction <0 and !$AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if not dead:
		velocity.x = speed * direction
		position += velocity
	

func _on_Attack_body_entered(body):
	if not dead:
		if body.get_parent().name == "Enemy_Container" :
			body.die()
		$AnimatedSprite.animation = 'end'
		$AnimatedSprite.playing = true
		dead = true
	
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'start':
		$AnimatedSprite.animation = 'default'
	if $AnimatedSprite.animation == 'end':
		print(Global.inventory)
		queue_free()
	$AnimatedSprite.playing = true

func end():
	$AnimatedSprite.animation = 'end'
	$AnimatedSprite.playing = true
	dead = true
