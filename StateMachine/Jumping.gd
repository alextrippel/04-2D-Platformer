extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.velocity.y = 0
	player.set_animation("Jumping")
	player.jump_power = Vector2.ZERO

func physics_process(_delta):
	if not Input.is_action_pressed('jump'):
		SM.set_state("Falling")
	elif player.jump_power.y == -player.max_jump:
		SM.set_state("Falling")
	else:
		player.jump_reset = false
		player.jump_power.y = clamp(player.jump_power.y - player.jump_speed, -player.max_jump, 0)
		player.velocity += player.jump_power
		player.move_and_slide(player.velocity, Vector2.UP)
