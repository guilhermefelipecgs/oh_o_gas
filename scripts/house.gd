extends Node2D

var last_pos
var new_pos
var target = Vector2()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	##################
	if last_pos != null:
		global.house_direction = (new_pos - last_pos).normalized()
		global.house_speed = new_pos.distance_to(last_pos)
	
	last_pos = new_pos
	new_pos = get_pos()
	##################
	
	var pos = get_pos()
	pos -= (pos - target).normalized() * 1
	set_pos(pos)

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
