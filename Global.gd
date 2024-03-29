extends Node

var score = 0
var score_init = 0
var deaths = 0
var level = 0
var health = 100
var max_health = 100
var max_lives = 5
var lives = 5
var flying_left = 5
var saves = ["user://game_data_0.json"]

var inventory = []

var levels = ['res://Levels/Level1.tscn',
'res://Levels/Level2.tscn',
'res://Levels/Level3.tscn'

]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var menu = get_node_or_null('/root/Game/UI/Menu')
		if menu != null :
			var p = get_tree().paused
			if p :
				menu.hide()
				get_tree().paused = false
			else :
				menu.show()
				get_tree().paused = true

func decrease_health(d):
	health -= d

func decrease_lives(l):
	lives -= l
	health = max_health
	if lives <= 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene('res://Levels/Game_Over.tscn')

func increase_score(s):
	score += s

func save_game(which_file):
	var file = File.new()
	var data = get_save_data()
	file.open(saves[which_file], File.WRITE)
	file.store_string(to_json(data))
	file.close()

func load_game(which_file):
	var file = File.new()
	if file.file_exists(saves[which_file]):
		file.open(saves[which_file], file.READ)
		var data= parse_json(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY:
			load_save_level(data)
		else:
			printerr("Corrupted_Data")
		file.close()
	else:
		printerr("No saved data")

func get_save_data():
	var data = {
		"score":score,
		"lives":lives,
		"health":health,
		"level":level,
		"player":'',
		"enemy_ground":[],
		'key':[],
		'chest':[],
		"enemy_flying":[],
		"food":[],
		"coins":[],
		'flying_left': flying_left,
		'inventory': inventory
	}
	var player = get_node('/root/Game/Player_Container/Player')
	if player != null:
		data['player'] = var2str(player.position)
	
	var enemies = get_node('/root/Game/Enemy_Container').get_children()
	for e in enemies:
		if e.is_in_group("Enemy_Ground"):
			var temp = {'position':var2str(e.position), "max_constraint":e.max_constraint, "min_constraint":e.min_constraint}
			data['enemy_ground'].append(temp)
		if e.is_in_group("Enemy_Flying"):
			var temp = {'position':var2str(e.position)}
			data['enemy_flying'].append(temp)
	
	var collectables = get_node('/root/Game/Collectable_Container').get_children()
	print(collectables)
	for c in collectables:
		if c.is_in_group("Key"):
			var temp = {'position':var2str(c.position)}
			data['key'].append(temp)
		if c.is_in_group("Chest"):
			var temp = {'position':var2str(c.position)}
			data['chest'].append(temp)
		if c.is_in_group("Food"):
			var temp = {'position':var2str(c.position)}
			data['food'].append(temp)
	
	var coins = get_node("/root/Game/Coin_Container").get_children()
	for c in coins:
		var temp = {'position':var2str(c.position), 'score':c.score}
		data['coins'].append(temp)
	return data

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func load_save_level(data):
	score = data['score']
	lives = data['lives']
	health = data['health']
	flying_left = data['flying_left']
	inventory = data['inventory']
	var savedlevel = data['level']
	level = levels.find(levels[savedlevel])
# warning-ignore:return_value_discarded
	get_tree().change_scene(levels[savedlevel])
	call_deferred("load_save_data", data)


func load_save_data(data):
	var menu = get_node_or_null('/root/Game/UI/Menu')
	if menu != null:
		menu.show()
	if data['player'] != '':
		var player = get_node_or_null('/root/Game/Player_Container/Player')
		if player != null:
			player.name = "Player2"
			player.queue_free()
		get_node('/root/Game/Player_Container').spawn(str2var(data['player']))
		
	var enemy_container = get_node('/root/Game/Enemy_Container')
	for e in enemy_container.get_children():
		e.queue_free()
	for e in data["enemy_ground"]:
		var attr = {'max_constraint':e['max_constraint'],'min_constraint':e['min_constraint']}
		enemy_container.spawn("Enemy_Ground",attr,str2var(e['position']))
	for e in data["enemy_flying"]:
		var attr = {}
		enemy_container.spawn("Enemy_Flying",attr,str2var(e['position']))
	
	var collectable_container = get_node('/root/Game/Collectable_Container')
	for c in collectable_container.get_children():
		c.queue_free()
	for c in data["key"]:
		var attr = {}
		collectable_container.spawn("Key",attr,str2var(c['position']))
	for c in data["chest"]:
		var attr = {}
		collectable_container.spawn("Chest",attr,str2var(c['position']))
	for c in data["food"]:
		var attr = {}
		collectable_container.spawn("Food",attr,str2var(c['position']))
	
	var coin_container = get_node('/root/Game/Coin_Container')
	for c in coin_container.get_children():
		c.queue_free()
	for c in data["coins"]:
		var attr = {'score':c['score']}
		coin_container.spawn(attr, str2var(c['position']))
	pass
