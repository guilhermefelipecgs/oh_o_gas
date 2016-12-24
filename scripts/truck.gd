extends RigidBody2D

const LEFT = Vector2(-1,-1)
const RIGHT = Vector2(1,-1)
const MAX_THROW = 350
const MIN_THROW = 200
const MAX_TIME = 800

var canister = preload("res://scenes/canister.tscn")
var left_time_press
var right_time_press

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_left"):
		left_time_press = OS.get_ticks_msec()
	elif event.is_action_released("ui_left"):
		throw(LEFT, OS.get_ticks_msec() - left_time_press)

	if event.is_action_pressed("ui_right"):
		right_time_press = OS.get_ticks_msec()
	elif event.is_action_released("ui_right"):
		throw(RIGHT, OS.get_ticks_msec() - right_time_press)

func throw(direction, delta_time_press):
	var spawn_canister = canister.instance()
	var force = MAX_THROW * delta_time_press / MAX_TIME
	force = clamp(force, MIN_THROW, MAX_THROW)
	
	spawn_canister.set_pos(get_pos())
	if(direction == LEFT):
		spawn_canister.set_angular_velocity(5)
		spawn_canister.apply_impulse(Vector2(), LEFT * force)
	else:
		spawn_canister.set_angular_velocity(-5)
		spawn_canister.apply_impulse(Vector2(), RIGHT * force)
		
	get_parent().add_child(spawn_canister)