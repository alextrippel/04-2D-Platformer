extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1
onready var Attack = load('res://Attack/Attack.tscn')
onready var camera = get_node('/root/Game/Camera')
onready var overlay = get_node('/root/Game/UI/Overlay')
onready var overlay_die = get_node('/root/Game/UI/Death_Overlay')

export var gravity = Vector2(0,30)
export var wall_slide = Vector2(0,-5)
export var move_speed = 20
export var max_move = 300

export var jump_speed = 200
export var max_jump = 500

var wait = false
var paused = false

var moving = false
var is_jumping = false
var double_jumped = false
var jump_reset = true
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite

func _ready():
	overlay_die.connect('faded_out', self, '_faded_out')
	overlay_die.connect('faded_in', self, '_faded_in')
	paused = true
	overlay_die.fade_in()

func _physics_process(_delta):
	if not paused:
		velocity.x = clamp(velocity.x,-max_move,max_move)
			
		if should_direction_flip:
			if velocity.x < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
			if velocity.x > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false
		
		if Input.is_action_just_pressed('attack'):
			var attack = Attack.instance()
			attack.position = position
			attack.position.x += 20*direction
			attack.direction = direction
			get_node('/root/Game/Attack_Container').add_child(attack)
		if is_on_floor():
			double_jumped = false
			set_wall_raycasts(true)
		if not Input.is_action_pressed('jump'):
			jump_reset = true

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") and not wait:
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			wait = false
			return true
	return false

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Left.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func do_damage(d):
	camera.add_trauma(0.5)
	Global.decrease_health(d)
	overlay.add_trauma(1.0- (Global.health/200.0))
	if Global.health <= 0:
		die()

func die():
	Global.decrease_lives(1)
	overlay_die.fade_out()
	
func _faded_out():
	queue_free()

func _faded_in():
	paused = false



func _on_Timer_timeout():
	wait = false
