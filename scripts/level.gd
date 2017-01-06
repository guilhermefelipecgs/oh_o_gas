extends Node

var house = preload("res://scenes/house.tscn")
var human = preload("res://scenes/human.tscn")
var last_spawn_time = 0.0
var house_spawn_pos
var house_target_pos


const SPAWN_TIME = 1000.0

func _ready():
	
	house_spawn_pos = get_node("house_spawn").get_pos()
	house_target_pos = get_node("house_target").get_pos()
	global.house_direction = (house_target_pos - house_spawn_pos).normalized()
	global.house_speed = 1
	
	set_process(true)
	spawn_house()

func _process(delta):
	if(OS.get_ticks_msec() - last_spawn_time >= SPAWN_TIME):
		spawn_house()

func spawn_house():
	var house = self.house.instance()
	var human = self.human.instance()
	
	house.set_pos(get_node("house_spawn").get_pos())
	
	human.walk_path = house.get_node("walk_path").get_pos()
	human.set_pos(house.get_node("spawn_place").get_pos())
	
	if ceil(randf() * 2) == 10:
		house.target = Vector2((house_spawn_pos.x - house_target_pos.x) + house_spawn_pos.x, house_target_pos.y)
		house.set_scale(Vector2(-1, 1))
	else:
		house.target = house_target_pos
	
	house.add_child(human)
	get_node("YSort").add_child(house)
	last_spawn_time = OS.get_ticks_msec()


func _on_Area2D_body_enter( body ):
	if body.get_name() == 'canister':
		body.set_contact_monitor(false)


func _on_Area2D_body_exit( body ):
	if body.get_name() == 'canister':
		body.set_contact_monitor(true)
