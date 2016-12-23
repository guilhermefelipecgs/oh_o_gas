extends RigidBody2D

var canister = preload("res://scenes/canister.tscn")
const LEFT = Vector2(-1,-1)
const RIGHT = Vector2(1,-1)

func _ready():
	set_process_input(true)
	set_process(true)

func _input(event):
	if event.is_action_pressed("ui_left"):
		throw(LEFT)
	if event.is_action_pressed("ui_right"):
		throw(RIGHT)

func _process(delta):
	pass

func throw(direction):
	var spawn_canister = canister.instance()
	if(direction == LEFT):
		spawn_canister.apply_impulse(Vector2(), LEFT*350)
	else:
		spawn_canister.apply_impulse(Vector2(), RIGHT*350)
	spawn_canister.set_pos(get_pos())
	get_parent().add_child(spawn_canister)