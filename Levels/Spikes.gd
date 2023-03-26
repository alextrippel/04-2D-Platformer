extends Area2D
onready var location = get_node('/root/Game/Player_Container')
onready var damage = 50

func _on_Spikes_body_entered(body):
	if body.name == "Player":
		body.do_damage(damage)
		body.position = location.spawn_location
