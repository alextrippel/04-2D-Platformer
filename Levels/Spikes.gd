extends Area2D
onready var movelocation = get_node('/root/Game/Player_Container')
onready var damage = 50

func _on_Spikes_body_entered(body):
	if body.name == "Player":
		body.do_damage(damage)
		if Global.level == 0:
			body.position = movelocation.spawn_location
		else:
			body.position = movelocation.spawn_location2
