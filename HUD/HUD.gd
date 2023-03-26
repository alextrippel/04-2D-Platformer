extends Control


func _physics_process(_delta):
	$Score.text = "Score: " + str(Global.score)
	$Lives.text = "Lives: " + str(Global.lives)
	if $Healthbar.value > Global.health:
		$Healthbar.value -= 1
	if $Healthbar.value < Global.health:
		$Healthbar.value += 1

