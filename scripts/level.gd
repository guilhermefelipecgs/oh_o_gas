extends Node

const SPAWN_TIME = 1200.0
const MAX_SHAKE_TIME = 200

var house = preload("res://scenes/house.tscn")
var human = preload("res://scenes/human.tscn")
var gas_over = preload("res://scenes/gas_over.tscn")
var last_spawn_time = 0.0
var house_spawn_pos
var house_target_pos
var start_shake_time = 0
var i_camera = 0

func _ready():
	get_tree().set_pause(true)
	house_spawn_pos = get_node("house_spawn").get_pos()
	house_target_pos = get_node("house_target").get_pos()
	global.house_direction = (house_target_pos - house_spawn_pos).normalized()
	global.house_speed = 0.7
	get_node("Timer").set_wait_time(get_node("music").get_length())
	get_node("Timer").start()
	set_process(true)

func _process(delta):
	var time_left = get_node("Timer").get_time_left()
	var temp_time_left  = int((time_left - int(time_left))*1000)
	get_node("HUD/time_remaining").set_text(str(int(time_left)) + "." + str(temp_time_left))
	if((OS.get_ticks_msec() - last_spawn_time) >= SPAWN_TIME):
		spawn_house()
	
	if global.camera_shake:
		start_shake_time = OS.get_ticks_msec() + MAX_SHAKE_TIME
		global.camera_shake = false
	if start_shake_time > OS.get_ticks_msec():
		if i_camera % 2 == 0:
			get_node("Camera2D").set_pos(get_node("Camera2D").get_pos() + Vector2(randi() % 3, randi() % 3))
		else:
			get_node("Camera2D").set_pos(Vector2())
	i_camera+=1

func spawn_house():
	var house = self.house.instance()
	var human = self.human.instance()
	
	house.set_pos(get_node("house_spawn").get_pos())
	
	human.walk_path = house.get_node("walk_path").get_pos()
	human.spawn_place = house.get_node("spawn_place").get_pos()
	human.set_pos(house.get_node("spawn_place").get_pos())
	
	if ceil(randf() * 2) == 1:
		house.target = Vector2((house_spawn_pos.x - house_target_pos.x) + house_spawn_pos.x, house_target_pos.y)
		house.set_scale(Vector2(-1, 1))
	else:
		house.target = house_target_pos
	
	house.add_child(human)
	get_node("YSort").add_child(house)
	last_spawn_time = OS.get_ticks_msec()

func _on_deactivates_canister_body_enter( body ):
	if body.is_in_group('canister'):
		body.set_contact_monitor(false)

func _on_deactivates_canister_body_exit( body ):
	if body.is_in_group('canister'):
		body.set_contact_monitor(true)

func _on_Timer_timeout():
	get_node("music").play()
	#get_tree().set_pause(true)
	#var go = gas_over.instance()
	#go.get_node("score").set_text("SCORE: " + str(global.score))
	#add_child(go)
	
