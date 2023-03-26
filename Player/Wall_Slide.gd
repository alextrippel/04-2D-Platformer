extends Node

onready var SM = get_parent()
onready var player = get_node("../..")
onready var prev_direction = player.direction

func _ready():
	yield(player, "ready")

func start():
	if player.velocity.y > 0:
		player.set_animation("Falling")
	player.jump_power = Vector2.ZERO

func physics_process(_delta):
	if player.is_on_floor() and player.velocity.y > 0:
		player.velocity.y = 0
		if player.is_moving():
			SM.set_state("Moving")
		else:
			SM.set_state("Idle")
		return
	if not((player.is_on_right_wall() and Input.get_action_strength('right')>0) or (player.is_on_left_wall() and Input.get_action_strength('left')>0)):
		SM.set_state('Falling')
	if Input.is_action_pressed("jump"):
		if player.is_on_left_wall():
			player.velocity.x = 300
			player.direction = 1
		if player.is_on_right_wall():
			player.velocity.x = -300
			player.direction = -1
		player.wait = true
		SM.set_state('Jumping')
	if player.velocity.y < 0:
		player.velocity += player.move_speed * player.move_vector() + player.gravity
	if player.velocity.y > 0:
		player.velocity += player.move_speed * player.move_vector() + player.wall_slide
	else:
		player.velocity += player.move_speed * player.move_vector() + player.wall_slide
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
