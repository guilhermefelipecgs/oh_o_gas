extends Node

var house = preload("res://scenes/human.tscn")

func _ready():
	set_process(true)

func _process(delta):
	
	var house = self.house.instance()
	add_child(house)
	