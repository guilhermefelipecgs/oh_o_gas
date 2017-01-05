extends Node2D

var last_pos
var new_pos
var target = Vector2()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var pos = get_pos()
	pos -= (pos - target).normalized() * global.house_speed
	set_pos(pos)

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

func destroy():
	get_node("Sprite").set_frame(2)