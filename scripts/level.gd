extends Node

var house = preload("res://scenes/house.tscn")
var human = preload("res://scenes/human.tscn")
var last_spawn_time = 0.0

const SPAWN_TIME = 2000.0

func _ready():
	set_process(true)
	spawn_house()

func _process(delta):
	if(OS.get_ticks_msec() - last_spawn_time >= SPAWN_TIME):
		spawn_house()

func spawn_house():
	var house = self.house.instance()
	var human = self.human.instance()
	human.walk_path = house.get_node("walk_path").get_pos()
	human.set_pos(house.get_node("spawn_place").get_pos())
	house.add_child(human)
	add_child(house)
	last_spawn_time = OS.get_ticks_msec()


func _on_Area2D_body_enter( body ):
	body.set_contact_monitor(false)


func _on_Area2D_body_exit( body ):
	body.set_contact_monitor(true)
