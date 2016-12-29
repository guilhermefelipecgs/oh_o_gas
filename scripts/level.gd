extends Node

var house = preload("res://scenes/house.tscn")
var human = preload("res://scenes/human.tscn")
var last_spawn_time = 0.0

const SPAWN_TIME = 2000.0

func _ready():
	set_process(true)

func _process(delta):
	if(OS.get_ticks_msec() - last_spawn_time >= SPAWN_TIME):
		var house = self.house.instance()
		var human = self.human.instance()
		human.walk_path = house.get_node("walk_path").get_pos()
		house.get_node("spawn_place").add_child(human)
		add_child(house)
		last_spawn_time = OS.get_ticks_msec()
	